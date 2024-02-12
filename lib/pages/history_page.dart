import 'package:bmi/widgets/info_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryPage extends StatelessWidget{
  double? _dheight,_dwidth;

  @override
  Widget build(BuildContext context) {
    _dheight=MediaQuery.of(context).size.height;
    _dwidth=MediaQuery.of(context).size.width;
    return CupertinoPageScaffold(
      child: _dataCard(),
    );
  }

  Widget _dataCard(){
    return FutureBuilder(
      future: SharedPreferences.getInstance(), 
      builder: (BuildContext _context,AsyncSnapshot _snapshot){
        if(_snapshot.hasData){
          final _pref=_snapshot.data as SharedPreferences;
          final _date=_pref.getString("BMI_Date");
          final _data=_pref.getStringList("BMI_Info");
          return Center(
            child: InfoCard(
              height: _dheight!*0.25, 
              width: _dwidth!*0.75, 
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _statusText(_data![1]),
                  _dateText(_date!),
                  _bmiText(_data[0])
                ],
              )
            ),
          );
        }
        else{
          return const Center(
            child: CupertinoActivityIndicator(
              color: Colors.blue,
            ),
          );
        }
      }
    );
  }

  Widget _statusText(String _status){
    return Text(_status,
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w500
      ),
    );
  }

  Widget _dateText(String _date){
    DateTime _parseDate=DateTime.parse(_date);
    return Text(
      "${_parseDate.day}/${_parseDate.month}/${_parseDate.year}",
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Widget _bmiText(String _bmi){
    return Text(
      double.parse(_bmi).toStringAsFixed(2),
      style: TextStyle(
        fontSize: 50,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}