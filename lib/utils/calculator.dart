import 'dart:math';

import 'package:dio/dio.dart';

double CalculateBMI(int height,int weight){
  return weight/pow(height/100,2);
}

Future<double> CalculateBMIAsync(Dio _dio)async{
  var _res=await _dio.get("https://www.jsonkeeper.com/b/AKFA");
  var _data=_res.data;
  double height=_data["Sergio Ramos"][0]*2.5;
  double weight=_data["Sergio Ramos"][1]*0.45359237;
  var bmi=CalculateBMI( height.toInt(), weight.toInt());
  return bmi;
}