import 'package:coronavirus_rest_api_flutter_course/app/services/api.dart';
import 'package:flutter/material.dart';

class EndpointCard extends StatelessWidget {
  const EndpointCard({Key key, this.endpoint, this.value}) : super(key: key);
  final Endpoint endpoint;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
              'Cases',
              style: Theme.of(context).textTheme.headline5,
              ),
              Text(
                value != null ? value.toString() : '',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ), 
        
      ),
    );
  }

}
  


  //   void _updateAccessToken() async{
  //   final apiService = APIService(API.sandbox());
  //   //assign my access token to the variable - 만든 변수에 액세스 토큰을 할당
  //   final accessToken = await apiService.getAccessToken();
  //   final cases = await apiService.getEndpointData(
  //     accessToken: accessToken,
  //     endpoint: Endpoint.cases
  //     );

  //   final deaths = await apiService.getEndpointData(
  //     accessToken: accessToken,
  //     endpoint: Endpoint.deaths
  //     );

  //   setState(() {
  //     _accessToken = accessToken;
  //     _cases = cases;
  //     _deaths = deaths;
  //   });
  // }