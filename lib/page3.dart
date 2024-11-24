import 'package:flutter/material.dart';
class Page3 extends StatelessWidget {
  static const String route='Page3';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Page 3'),
      ),
      body:Column(
        children: [
          Expanded(
            child:
            Image.asset(
              'assets/images/palestine1.png',
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}



