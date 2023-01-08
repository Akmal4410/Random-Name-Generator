import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:random_name/add_name_screen.dart';
import 'package:random_name/selectName.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<String>('NameBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Random Name App',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          bodyText2: TextStyle(color: Colors.grey),
          subtitle1: TextStyle(color: Colors.white),
        ),
      ),
      home: AddNameScreen(),
    );
  }
}
