import 'package:coronavirus_rest_api_flutter_course/app/services/api_keys.dart';
import 'package:flutter/foundation.dart';

enum Endpoint{
cases,
casesSuspected,
casesConfirmed,
deaths,
recovered,
}

class API{
  API({@required this.apiKey});
  final String apiKey;

factory API.sandbox() => API(apiKey: APIKeys.ncovSandboxKey);

static final String host = 'ncov2019-admin.firebaseapp.com';

// Uri = Uniform Resource Identifier - 인터넷 식별자
//define a resource identifier and get the access token
Uri tokenUri () => Uri(
  scheme: 'https', host: host, path: 'token',
  );

Uri endPointUri(Endpoint endpoint) => Uri(
  scheme: 'https', host: host, path: _paths[endpoint],
);

// associate each end point to the relative path.
static Map<Endpoint, String> _paths = {
Endpoint.cases: 'cases',
Endpoint.casesSuspected: 'casesSuspected',
Endpoint.casesConfirmed:'casesConfirmed',
Endpoint.deaths:'deaths',
Endpoint.recovered:'recovered',
};

}