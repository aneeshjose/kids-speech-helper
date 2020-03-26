import 'package:flutter/material.dart';

class SelectionPage extends StatefulWidget {
  @override
  _SelectionPageState createState() => _SelectionPageState();
}

class _SelectionPageState extends State<SelectionPage> {
  Size size;
  TextStyle _buttonText = TextStyle(color: Colors.black, fontSize: 30);
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          width: size.width * 3 / 4,
          height: size.height / 2,
          child: Card(
            color: Colors.grey[800],
            elevation: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Container(
                    width: size.width / 1.8,
                    child: Text(
                      'Numbers 1 2 3',
                      style: _buttonText,
                    ),
                  ),
                  onPressed: () => Navigator.pushNamed(context, '123'),
                  //  Navigator.pushReplacementNamed(context, '123'),
                  color: Colors.white,
                ),
                RaisedButton(
                  child: Container(
                    width: size.width / 1.8,
                    child: Text(
                      'Alphabets A B C',
                      style: _buttonText,
                    ),
                  ),
                  onPressed: () => Navigator.pushNamed(context, 'abc'),
                  //  Navigator.pushReplacementNamed(context, 'abc'),
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
