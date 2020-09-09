
import 'package:coronavirus_rest_api_flutter_course/app/services/api.dart';
import 'package:flutter/foundation.dart';

class EndpointData{
  EndpointData({@required this.values});
  // key는 Endpoint , value는 int
  final Map<Endpoint, int> values;

  // add getters -  makes EndpointsData easier to query
  int get cases => values[Endpoint.cases];
  int get casesSuspected => values[Endpoint.casesSuspected];
  int get casesConfirmed => values[Endpoint.casesConfirmed];
  int get deaths => values[Endpoint.deaths];
  int get recovered => values[Endpoint.recovered];

  // print debugging information for a given and points data object
  @override
  String toString() => 'cases: $cases, suspected: $casesSuspected, confirmed: $casesConfirmed, deaths: $deaths, recovered: $recovered';


  // final int cases;
  // final int casesSuspected;
  // final int casesConfirmed;
  // final int deaths;
  // final int recovered;
}