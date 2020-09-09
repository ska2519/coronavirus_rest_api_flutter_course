import 'package:coronavirus_rest_api_flutter_course/app/repositories/endpoints_data.dart';
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

  Future<int> getEndpointData(Endpoint endpoint) async => 
    await _getDataRefreshingToken<int>(
      onGetData: () => apiService.getEndpointData(
        accessToken: _accessToken, endpoint: endpoint),
    );

  
  //Reading all endpoints at once
  Future<EndpointData> getAllEndpointsData() async =>
  await _getDataRefreshingToken(onGetData: _getAllEndpointsData);




  // use generics and function arguments to make code more reusable
  // <T> because 2가지 type 받음 Future<int>, Future<EndpointData> 
  Future<T> _getDataRefreshingToken<T>({Future<T> Function() onGetData}) async {
    try{
    if(_accessToken == null ){
     _accessToken = await apiService.getAccessToken();
    }
    return await onGetData();
    
    //Response class is String API Class
    } on Response catch (response) {
      if(response.statusCode ==401){
        //if unauthorized, get access token again
           _accessToken = await apiService.getAccessToken();
             return await onGetData();
      }
      //present a generic error to the user
      rethrow;
    }
  }

  Future<EndpointData> _getAllEndpointsData() async {
    // final cases = await apiService.getEndpointData(accessToken: _accessToken, endpoint: Endpoint.cases);
    // final casesSuspected = await apiService.getEndpointData(accessToken: _accessToken, endpoint: Endpoint.casesSuspected);
    // final casesConfirmed = await apiService.getEndpointData(accessToken: _accessToken, endpoint: Endpoint.casesConfirmed);
    // final deaths = await apiService.getEndpointData(accessToken: _accessToken, endpoint: Endpoint.deaths);
    // final recovered = await apiService.getEndpointData(accessToken: _accessToken, endpoint: Endpoint.recovered);
    
    // loading all the data in parallel.
    // values return List<int>
    final values = await Future.wait([
      apiService.getEndpointData(accessToken: _accessToken, endpoint: Endpoint.cases),
      apiService.getEndpointData(accessToken: _accessToken, endpoint: Endpoint.casesSuspected),
      apiService.getEndpointData(accessToken: _accessToken, endpoint: Endpoint.casesConfirmed),
      apiService.getEndpointData(accessToken: _accessToken, endpoint: Endpoint.deaths),
      apiService.getEndpointData(accessToken: _accessToken, endpoint: Endpoint.recovered),
    ]);
    return EndpointData(values: {
       Endpoint.cases: values[0], 
       Endpoint.casesSuspected: values[1],
       Endpoint.casesConfirmed: values[2],
       Endpoint.deaths: values[3],
       Endpoint.recovered: values[4],
    });
  }
}