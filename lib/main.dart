import 'package:flutter/material.dart';
import 'package:kidsapp/alphabet.dart';
import 'package:kidsapp/homepage.dart';
import 'package:kidsapp/numbers.dart';
import 'package:kidsapp/selectionpage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kids Alpha',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
      routes: {
        '123': (context) => Numbers(),
        'abc': (context) => Alphabets(),
        'selection': (context) => SelectionPage()
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
