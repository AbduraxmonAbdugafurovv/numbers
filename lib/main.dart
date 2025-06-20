import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:numbersapp/models/models.dart';
import 'package:numbersapp/screens/home.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
   Hive.registerAdapter(NumberFactModelAdapter());

  await Hive.openBox<NumberFactModel>('saved_facts');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Numbers App', theme: ThemeData(),
      home: HomePage(),
      );
  }
}
