import 'package:coronavirus_rest_api_flutter_course/app/services/api.dart';
import 'package:coronavirus_rest_api_flutter_course/app/services/api_service.dart';
import 'package:coronavirus_rest_api_flutter_course/app/services/data_cache_service.dart';
import 'package:coronavirus_rest_api_flutter_course/app/ui/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/repositories/data_repository.dart';

void main() async {
  //
  WidgetsFlutterBinding.ensureInitialized();
  // defaultLocale 변경
  Intl.defaultLocale = 'en-GB';
  await initializeDateFormatting();
  //create our data cache service - getInstance가 Future async 있는 main 안에 구성 다른 때는 FutureBuilder 사용 ㅊㅊ
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp(sharedPreferences: sharedPreferences));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key, @required this.sharedPreferences}) : super(key: key);
  final SharedPreferences sharedPreferences;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (_) => DataRepository(apiService: APIService(API.sandbox()),
      dataCacheService: DataCacheService(sharedPreferences: sharedPreferences,
      ),
    ),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Corona Virus Tracker',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF101010),
        cardColor: Color(0xFF222222),
        ),
        home: Dashboard(),
      ),
    );
  }
}
