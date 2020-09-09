
import 'package:coronavirus_rest_api_flutter_course/app/services/api.dart';
import 'package:coronavirus_rest_api_flutter_course/app/services/endpoint_data.dart';
import 'package:flutter/foundation.dart';

class EndpointsData{
  EndpointsData({@required this.values});
  // key는 Endpoint , value는 int
  final Map<Endpoint, EndpointData> values;

  // add getters -  makes EndpointsData easier to query
  EndpointData get cases => values[Endpoint.cases];
  EndpointData get casesSuspected => values[Endpoint.casesSuspected];
  EndpointData get casesConfirmed => values[Endpoint.casesConfirmed];
  EndpointData get deaths => values[Endpoint.deaths];
  EndpointData get recovered => values[Endpoint.recovered];

  // print debugging information for a given and points data object
  @override
  String toString() => 'cases: $cases, suspected: $casesSuspected, confirmed: $casesConfirmed, deaths: $deaths, recovered: $recovered';


  // final int cases;
  // final int casesSuspected;
  // final int casesConfirmed;
  // final int deaths;
  // final int recovered;
}