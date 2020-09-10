import 'package:coronavirus_rest_api_flutter_course/app/repositories/endpoints_data.dart';
import 'package:coronavirus_rest_api_flutter_course/app/services/endpoint_data.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api.dart';
//Shared preferences serialization is an implementation detail - 공유 환경 설정 직렬화는 구현 세부 사항입니다.
//Goal : write all code for writing and reading data with Sahred Preferences
class DataCacheService{
  DataCacheService({@required this.sharedPreferences});
  final SharedPreferences sharedPreferences;

  // result values for different end points will be stored with different keys
  static String endpointValueKey(Endpoint endpoint) => '$endpoint/value';
  static String endpointDateKey(Endpoint endpoint) => '$endpoint/date';

  //synchronous (efficient & easy to use) - not Future
  EndpointsData getData(){
    Map<Endpoint, EndpointData> values = {};
    //foreach - iterate through all the possible end points using
    Endpoint.values.forEach((endpoint) {
      final value = sharedPreferences.getInt(endpointValueKey(endpoint));
      final dateString = sharedPreferences.getString(endpointDateKey(endpoint));
      if(value != null && dateString != null){
        final date = DateTime.tryParse(dateString);
        values[endpoint] = EndpointData(value: value, date: date);
      }
    });
    return EndpointsData(values: values);
  }

  Future<void> setData(EndpointsData endpointsData) async {
    endpointsData.values.forEach((endpoint, endpointData) async {
      await sharedPreferences.setInt(endpointValueKey(endpoint), endpointData.value);
      // toIso8601String - standardized format that can be used to represent dates as strings
      await sharedPreferences.setString(endpointDateKey(endpoint),endpointData.date.toIso8601String(),);
    });
  }
}