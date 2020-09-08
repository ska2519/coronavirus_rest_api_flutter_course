 // as - functions inside this file, we need to prefix them with a dot.

//how to use the HTTP package to make a post request.
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:coronavirus_rest_api_flutter_course/app/services/api.dart';

class APIService{
  APIService(this.api);
  final API api;

  Future<String> getAccessToken() async{
    final response = await http.post(
      api.tokenUri().toString(),
      //headers - takes a map of key value pairs / pass a key code authorization
      // ${} add the API key using string interpolation.
      headers: {'Authorization': 'Basic ${api.apiKey}'},
    );

    if(response.statusCode ==200){
      //response body is a string object
      //decode - passes the json in the input string and returns a map of key value parts
      final data = json.decode(response.body);
      final accessToken = data['access_token'];
      if(accessToken != null){
        return accessToken;
      }
    }
    //error 
    print(
      'Request ${api.tokenUri()} failed\nResponse : ${response.statusCode} ${response.reasonPhrase}');
  throw response;
  }
  // Future<int> APIService give exactly what we need
  Future<int> getEndpointData({
    @required String accessToken,
    @required Endpoint endpoint,
  }) async {
    final uri = api.endPointUri(endpoint);
    final response = await http.get(
      uri.toString(),
      // Make requests(implementation detail)
      headers: {'Authorization':'Bearer $accessToken'},
    );
     if(response.statusCode ==200){
       // declared this data to be updated list of dynamic.
       // Json payload contains a list with a map inside
       final List<dynamic> data = json.decode(response.body);
       //add a defensive check
       if(data.isNotEmpty){
         final Map<String, dynamic> endpointData = data[0];
         //Parse responses(implementation detail)
         final String responseJsonKey = _responseJsonKeys[endpoint];
         final int result = endpointData[responseJsonKey];
         if(result != null){
           return result;
         }
       }
     }
     //notify the clean code that something went wrong and we can also add a print
         print('Request $uri failed\nResponse : ${response.statusCode} ${response.reasonPhrase}');
     throw response;
  }
//a new map that associates each end point to the json key that we will use to extract the data - 각 끝점을 데이터를 추출하는 데 사용할 json 키에 연결하는 새 맵.
//map has keys of type, end point and values of type string.
static Map<Endpoint, String> _responseJsonKeys = {
Endpoint.cases: 'cases',
Endpoint.casesSuspected: 'data',
Endpoint.casesConfirmed:'data',
Endpoint.deaths:'data',
Endpoint.recovered:'data',
};

}
//errors should be handled by the presentation and UI Layer of the app