import 'dart:math';

import 'package:bmi/utils/calculator.dart';
import 'package:bmi/widgets/info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BmiPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return  _BMIState();
  }
}

class _BMIState extends  State<BmiPage>{
  double? _dheight,_dwidth;
  int _age=25;
  int _weight=50;
  int _height=165;
  int _gender=0;

  @override
  Widget build(BuildContext context) {
    _dheight=MediaQuery.of(context).size.height;
    _dwidth=MediaQuery.of(context).size.width;
    return CupertinoPageScaffold(
      child: Center(
        child: Container(
          height: _dheight!*0.85,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _ageSelect(),
                  _weightSelect()
                ],
              ),
              _heightSelect(),
              _genderSelect(),
              _bmiBtn()
            ],
          )
        ),
      ) 
    );
  }

  Widget _ageSelect(){
    return InfoCard(
      height: _dheight!*0.20, 
      width: _dwidth!*0.45, 
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Age",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400
            ),
          ),
          Text("$_age",
            style: TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.w700
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                child: CupertinoDialogAction(
                  onPressed: () {
                    setState(() {
                      _age--;
                    });
                  },
                  child: Text("-",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 50,
                child: CupertinoDialogAction(
                  onPressed: () {
                    setState(() {
                      _age++;
                    });
                  },
                  child: Text("+",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.blue,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      )
    );
  }

  Widget _weightSelect(){
    return InfoCard(
      height: _dheight!*0.20, 
      width: _dwidth!*0.45, 
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Weight(in KG)",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400
            ),
          ),
          Text("$_weight",
            style: TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.w700
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 50,
                child: CupertinoDialogAction(
                  onPressed: () {
                    setState(() {
                      _weight--;
                    });
                  },
                  child: Text("-",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 50,
                child: CupertinoDialogAction(
                  onPressed: () {
                    setState(() {
                      _weight++;
                    });
                  },
                  child: Text("+",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.blue,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      )
    );
  }

  Widget _heightSelect(){
    return InfoCard(
      height: _dheight!*0.20, 
      width: _dwidth!*0.90, 
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Height(in cm)",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text("$_height",
            style: TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(
            width: _dwidth!*0.75,
            child: CupertinoSlider(
              min: 30,
              max: 225,
              divisions: 195,
              value: _height.toDouble(), 
              onChanged: (_value){
                setState(() {
                  _height = _value.toInt();
                });
              }
            ),
          )
        ],
      )
    );
  }

  Widget _genderSelect(){
    return InfoCard(
      height: _dheight!*0.12, 
      width: _dwidth!*0.90, 
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Gender",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          CupertinoSlidingSegmentedControl(
            groupValue: _gender,
            children:const {
              0:Text("Male"),
              1:Text("Female")
            }, 
            onValueChanged: (_value){
              setState(() {
                _gender=_value as int;
              });
            }
          )
        ],
      )
    );
  }

  Widget _bmiBtn(){
    return Container(
      height: _dheight!*0.06,
      child: CupertinoButton.filled(
        child: Text("Calculate BMI"), 
        onPressed: (){
          if(_height>0 && _weight>0 && _age>0){
            double _bmi=CalculateBMI(_height, _weight);
            _showResult(_bmi);
          }
        }
      ),
    );
  }
  void _showResult(double _bmi){
    String? _status;
    if(_bmi<18.5){
      _status="UnderWeight";
    }
    else if(_bmi>=18.5 && _bmi<25){
      _status="Normal";
    }
    else if(_bmi>=25 && _bmi<30){
      _status="OverWeight";
    }
    else if(_bmi>30){
      _status="Obesity";
    }
    showCupertinoDialog(
      context: context, 
      builder: (BuildContext _context){
        return CupertinoAlertDialog(
          title: Text(_status!),
          content: Text(_bmi.toStringAsFixed(2)),
          actions: [
            CupertinoDialogAction(
              child: Text("Ok"),
              onPressed: () {
                _saveResult(_bmi.toString(), _status!);
                Navigator.pop(_context);
              },
            )
          ],
        );
      }
    );
  }

  void _saveResult(String _bmi, String _status)async{
    final pref=await SharedPreferences.getInstance();
    await pref.setString("BMI_Date", DateTime.now().toString());
    await pref.setStringList("BMI_Info", <String>[_bmi,_status]);
  }
}