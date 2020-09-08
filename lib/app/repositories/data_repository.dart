import 'package:coronavirus_rest_api_flutter_course/app/services/api.dart';
import 'package:coronavirus_rest_api_flutter_course/app/services/api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

//data repository class to only refresh the access token when needed
class DataRepository{
  DataRepository({@required this.apiService});
  final APIService apiService;

  //save the token as a state variable.
  String _accessToken;

  //get the data for a given endpoint
  //  Future<int>는 can show in our UI

  Future<int> getEndpointData(Endpoint endpoint) async {
    try{
    if(_accessToken == null ){
     _accessToken = await apiService.getAccessToken();
    }
    return await apiService.getEndpointData(
      accessToken: _accessToken, endpoint: endpoint);
    
    //Response class is String API Class
    } on Response catch (response) {
      if(response.statusCode ==401){
        //if unauthorized, get access token again
           _accessToken = await apiService.getAccessToken();
             return await apiService.getEndpointData(
               accessToken: _accessToken, endpoint: endpoint);
      }
      //present a generic error to the user
      rethrow;
    }
  }
}