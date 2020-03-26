import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:permission/permission.dart';
import 'package:speech_recognition/speech_recognition.dart';

class Alphabets extends StatefulWidget {
  @override
  _AlphabetsState createState() => _AlphabetsState();
}

List<String> alphabets = [
  'A',
  'B',
  'C',
  'D',
  'E',
  'F',
  'G',
  'H',
  'I',
  'J',
  'K',
  'L',
  'M',
  'N',
  'O',
  'P',
  'Q',
  'R',
  'S',
  'T',
  'U',
  'V',
  'W',
  'X',
  'Y',
  'Z'
];

class _AlphabetsState extends State<Alphabets> {
  // ScrollController _controller;
  FlutterTts flutterTts;

  String _currentLocale = 'en_IN';

  bool _isRecording = false;

  SpeechRecognition _speech;

  String _result = '';

  // PermissionStatus permission;

  String _curAlpha = 'A';

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
                  _curAlpha,
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
  bool _listened;

  Future<void> listen(i) async {
    _listened = false;
    if (!_isRecording) {
      setState(() {
        _curAlpha = alphabets[i];
      });
      Future.delayed(Duration(seconds: 1));

      await flutterTts.speak(_curAlpha);
      _speech.listen(locale: _currentLocale).then((res) {
        _isRecording = true;
      });
      _speech.setRecognitionResultHandler((handler) {
        if (handler == '' || handler == 'i')
          print('\n\n\n');
        else {
          if (_recList.length > 25) _recList = [];
          if (!_listened) _recList.add(handler);
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
