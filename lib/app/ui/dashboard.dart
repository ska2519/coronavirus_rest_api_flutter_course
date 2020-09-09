import 'package:coronavirus_rest_api_flutter_course/app/repositories/data_repository.dart';
import 'package:coronavirus_rest_api_flutter_course/app/repositories/endpoints_data.dart';
import 'package:coronavirus_rest_api_flutter_course/app/services/api.dart';
import 'package:coronavirus_rest_api_flutter_course/app/ui/endpoint_card.dart';
import 'package:coronavirus_rest_api_flutter_course/app/ui/last_updated_status_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}



class _DashboardState extends State<Dashboard> {
  EndpointsData _endpointData;
 

  @override
  void initState() { 
    super.initState();
    _updateData();
  }

//listen: false - ensure that we don't register our dashboard state as a listener when we get the data repository.
  Future<void> _updateData() async {
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    final endpointData = await dataRepository.getAllEndpointsData();
    setState(() => _endpointData = endpointData);
  }


  @override
  Widget build(BuildContext context) {
    final formatter = LastUpdatedDateFormatter(lastUpdated: _endpointData != null
               ? _endpointData.values[Endpoint.cases].date
               :null);

    return Scaffold(
      appBar: AppBar(
        title: Text('Corona Virus Tracker'),
      ),
      body: RefreshIndicator(
        onRefresh: _updateData,
              child: ListView(
          children: [
            // ? if null 아니면 // ?? if null 이면
            LastUpdatedStatusText(text:formatter.lastUpdatedStatusText(),
            ),
            //Endpoint.values in Enum 
            for (var endpoint in Endpoint.values)
            EndpointCard(
              endpoint: endpoint,
              value: _endpointData != null
               ? _endpointData.values[endpoint].value : null,
            ),
          ],
        ),
      ),
    );
  }

}


