import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:permission/permission.dart';
import 'package:speech_recognition/speech_recognition.dart';

class Numbers extends StatefulWidget {
  @override
  _NumbersState createState() => _NumbersState();
}

class _NumbersState extends State<Numbers> {
  FlutterTts flutterTts;

  String _currentLocale = 'en_IN';

  bool _isRecording = false;

  SpeechRecognition _speech;

  // PermissionStatus permission;

  int _curNum = 0;

  @override
  void dispose() {
    _speech?.cancel();
    _speech?.stop();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _checkPermission();

    flutterTts = FlutterTts();

    _ttsInit();

    _speech = SpeechRecognition();
  }

  // _checkPermission() async {
  //   PermissionName permissionName = PermissionName.Microphone;
  //   PermissionStatus stat =
  //       await Permission.getSinglePermissionStatus(permissionName);
  //   if (stat != PermissionStatus.allow) {
  //     Permission.requestSinglePermission(permissionName);
  //   }
  // }
  _checkPermission() async {
    PermissionStatus status = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.microphone);
    if (status != PermissionStatus.granted) {
      _reqPermission(PermissionGroup.microphone);
    }
  }

  _reqPermission(PermissionGroup permission) {
    PermissionHandler().requestPermissions([permission]).then((Map map) {
      if (map[permission] != PermissionStatus.granted) {
        _reqPermission(permission);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: GestureDetector(
            onTap: () {
              print('listening');
              _recList = [];
              if (!_isRecording) listen(0);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue[400],
                borderRadius: BorderRadius.circular(20.0),
              ),
              height: 200,
              width: 300,
              child: Center(
                child: Text(
                  _curNum.toString(),
                  style: TextStyle(color: Colors.white, fontSize: 200),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool isAvail = true;
  int number = 1;

  void _ttsInit() async {
    await flutterTts.setLanguage("en-US");

    await flutterTts.setSpeechRate(.4);

    await flutterTts.setVolume(0.5);

    await flutterTts.setPitch(3.0);
  }

  List _recList = [];
  // static const MethodChannel _channel = const MethodChannel('speech_rec');
  bool _listened;

  Future<void> listen(i) async {
    _listened = false;
    if (!_isRecording) {
      setState(() {
        _curNum = _recList.length;
      });
      Future.delayed(Duration(seconds: 1));

      await flutterTts.speak(_curNum.toString());
      _speech.listen(locale: _currentLocale).then((res) {
        _isRecording = true;
      });
      _speech.setRecognitionResultHandler((handler) {
        if (handler == '' || handler == 'i')
          print('\n\n\n');
        else {
          if (!_listened) _recList.add(handler);
          if (_recList.length > 20) _recList = [];
          _isRecording = false;
          _listened = true;
        }
      });
      _speech.setRecognitionCompleteHandler(() {
        _isRecording = false;
        listen(_recList.length);
      });
      // _speech.setErrorHandler((error) {
      //   print(error);
      //   _isRecording = false;
      // });
    }
  }
}
