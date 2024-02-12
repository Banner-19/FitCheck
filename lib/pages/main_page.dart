import 'package:bmi/pages/bmi_page.dart';
import 'package:bmi/pages/history_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class MainPage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _MainPageState();
  }
}

class  _MainPageState extends State<MainPage>{
  final List<Widget> _tabs= [BmiPage(),HistoryPage()];

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar:const CupertinoNavigationBar(
        middle: Text("FitCheck"),
      ),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: "BMI",
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person),
              label: "History"
            )
          ]
        ),
        tabBuilder: (context, index) {
          return CupertinoTabView(
            builder: (context) {
              return _tabs[index];
            },
          );
        },
      ),
    );
  }
}