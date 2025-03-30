import 'package:flutter/material.dart';
import 'services/mongodb_service.dart';
import 'ui/home_page.dart';
import 'package:aila_/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDBService.connect();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        fontFamily: 'Roboto',
      ),
      home: HomePage(),
    );
  }
}
