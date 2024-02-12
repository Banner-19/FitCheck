import 'package:bmi/utils/calculator.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'dart:convert';

class DioMock extends Mock implements Dio {}
void main() {
  test("Give height and weight When CalculateBMI is invoked then BMI is calculated",
   (){
    //Arrange
    const int height=165,weight=50;
    //Act
    double bmi =CalculateBMI(height,weight);
    //Assert
    expect(bmi, 18.36547291092746);
   }
  );
  test('Given url When calculateBMIAsync invoked Then correct BMI returned',
      () async {
    //Arrange
    final _dioMock = DioMock();
    when(() => _dioMock.get('https://jsonkeeper.com/b/AKFA')).thenAnswer(
      (_) => Future.value(
        Response(
          requestOptions: RequestOptions(path: 'https://jsonkeeper.com/b/AKFA'),
          data: {
            "Sergio Ramos": [72, 165]
          },
        ),
      ),
    );
    //Act
    var _result = await CalculateBMIAsync(_dioMock);
    //Assert
    expect(_result, 22.375578703703706);
  });
}