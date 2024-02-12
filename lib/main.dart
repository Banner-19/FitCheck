import 'package:bmi/pages/main_page.dart';
import 'package:bmi/utils/calculator.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() async{
  print(await CalculateBMIAsync(Dio()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: "FitCheck",
      routes: {
        "/":(BuildContext _context) => MainPage(), 
      },
      initialRoute: "/",
      debugShowCheckedModeBanner: false,
    );
  }
}

