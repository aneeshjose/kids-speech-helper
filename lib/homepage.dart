import 'dart:math';

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _randomNumber = 0;

  String _textValue = '';

  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _randomNum();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width * 3 / 4,
            child: Card(
              elevation: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Enter $_randomNumber',
                    style: TextStyle(fontSize: 30),
                  ),
                  Container(
                    width: 40,
                    child: TextField(
                      maxLength: 2,
                      style: TextStyle(fontSize: 30),
                      // autofocus: mounted ? true : false,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      onChanged: (String s) {
                        _textValue = s;
                      },
                      onSubmitted: (String text) => _onSubmitted(),
                    ),
                  ),
                  RaisedButton(
                    onPressed: () => _onSubmitted(),
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.black,
                  ),
                  Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _randomNum() {
    Random random = new Random();
    setState(() {
      _randomNumber = 10 + random.nextInt(99);
    });
  }

  void _onSubmitted() {
    if (int.parse(_textValue ?? 0) == _randomNumber) {
      Navigator.pushReplacementNamed(context, 'selection');
    } else {
      setState(() {
        _errorMessage = 'Incorrect Value';
      });
    }
  }
}
