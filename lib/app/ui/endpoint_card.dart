import 'package:coronavirus_rest_api_flutter_course/app/services/api.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EndPointCardData{
  EndPointCardData(this.title, this.assetName, this.color);
  final String title;
  final String assetName;
  final Color color;
}

class EndpointCard extends StatelessWidget {
  const EndpointCard({Key key, this.endpoint, this.value}) : super(key: key);
  final Endpoint endpoint;
  final int value;

  // create an end point card data object for each key
  //this has a title an asset name and a color which is specified in hex format.
    static Map<Endpoint, EndPointCardData> _cardData = {
    Endpoint.cases: EndPointCardData('Cases', 'assets/count.png', Color(0xFFFFF492)),
    Endpoint.casesSuspected: EndPointCardData('Suspected', 'assets/suspect.png', Color(0xFFEEDA28)),
    Endpoint.casesConfirmed:EndPointCardData('Confirmed', 'assets/fever.png', Color(0xFFE99600)),
    Endpoint.deaths:EndPointCardData('Deaths', 'assets/death.png', Color(0xFFE40000)),
    Endpoint.recovered:EndPointCardData('Recovered', 'assets/patient.png', Color(0xFF70A901)),
  };

  String get formatterValue {
    if(value == null){
      return '';
    }
    return NumberFormat('#,###,###,###').format(value);

  }
  //   static Map<Endpoint, String> _cardTitles = {
  //   Endpoint.cases: 'Cases',
  //   Endpoint.casesSuspected: 'Suspected',
  //   Endpoint.casesConfirmed:'Confirmed',
  //   Endpoint.deaths:'Deaths',
  //   Endpoint.recovered:'Recovered',
  // };

  @override
  Widget build(BuildContext context) {
    final cardData = _cardData[endpoint];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 4.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  cardData.title,
                  style: Theme.of(context).textTheme.headline5
                  .copyWith(color: cardData.color),
                  ),
              SizedBox(height: 4.0),
              SizedBox(
                height: 52.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(cardData.assetName, color: cardData.color),
                    Text(
                      formatterValue,
                      style: Theme.of(context).textTheme.headline4
                      .copyWith(
                        color: cardData.color, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
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