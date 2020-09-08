import 'package:coronavirus_rest_api_flutter_course/app/services/api.dart';
import 'package:coronavirus_rest_api_flutter_course/app/services/api_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _accessToken = '';
  int _cases;
  int _deaths;

  void _updateAccessToken() async{
    final apiService = APIService(API.sandbox());
    //assign my access token to the variable - 만든 변수에 액세스 토큰을 할당
    final accessToken = await apiService.getAccessToken();
    final cases = await apiService.getEndpointData(
      accessToken: accessToken,
      endpoint: Endpoint.cases
      );

    final deaths = await apiService.getEndpointData(
      accessToken: accessToken,
      endpoint: Endpoint.deaths
      );

    setState(() {
      _accessToken = accessToken;
      _cases = cases;
      _deaths = deaths;
    });
  }


  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(   
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_accessToken',
              style: Theme.of(context).textTheme.headline4,
            ),
            //special if statement, which is called collection-if.
            if(_cases != null)
            Text(
              'cases: $_cases',
              style: Theme.of(context).textTheme.headline4,
            ),
            if(_deaths != null)
            Text(
              'deaths: $_deaths',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _updateAccessToken,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}