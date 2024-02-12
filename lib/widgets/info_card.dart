import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class InfoCard extends StatelessWidget{
  final Widget child;
  final double height,width;

  InfoCard({required this.height,required this.width, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow:const [BoxShadow(
          color: Colors.black26,
          blurRadius: 5,
          ),
        ],
      ),
      height: height,
      width: width,
      child: child,
    );
  }
}