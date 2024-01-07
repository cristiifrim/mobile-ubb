import 'package:finapp/business_logic/saving_business_logic.dart';
import 'package:finapp/data_access/app_database.dart';
import 'package:finapp/screens/home.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  final savingBusinessLogic = SavingBusinessLogic(database.savingDao);
  runApp(MyApp(savingBusinessLogic: savingBusinessLogic));
}

class MyApp extends StatelessWidget {
  final SavingBusinessLogic savingBusinessLogic;
  const MyApp({super.key, required this.savingBusinessLogic});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinApp',
      home: Home(savingBusinessLogic: savingBusinessLogic),
    );
  }
}
