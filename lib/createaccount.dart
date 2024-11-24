import 'package:flutter/material.dart';
class CreateAccount extends StatelessWidget
{
  @override
  static const String route='CreateAccount';
  Widget build (BuildContext context)
  {
    return Scaffold(
        appBar:AppBar(
          backgroundColor: Colors.greenAccent,
          title:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  'Gemmy Shop',
                  style: TextStyle(fontStyle:FontStyle.italic,
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.lineThrough
                  )
              )
            ],
          ) ,
        ) ,
        body:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ],
        ) ,
    );
  }
}