import 'package:flutter/material.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'dart:async';
import 'package:esys_flutter_share/esys_flutter_share.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VoiceHome(),
    );
  }
}

class VoiceHome extends StatefulWidget {
  @override
  _VoiceHomeState createState() => _VoiceHomeState();
}

class _VoiceHomeState extends State<VoiceHome> {
  String filePath,
      y,
      mood = '',
      mood1 = '';
  Color color = Colors.blue;
  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;
  int x = -120, z = -120;
  double z1 = -120, x1;

  String resultText = "";

  List<String> lut = ['camera', 'music', 'wipers', 'headlights', 'call'];
  List<String> lutt = ['camera.', 'music.', 'wipers.', 'headlights.', 'call.'];
  List<String> luttt = ['camera?', 'song', 'wipers?', 'headlight', 'calls'];
  List<String> lutttt = ['camera?', 'song.', 'wiper', 'headlight.', 'calling'];
  List<String> luttttt = ['camera?', 'song?', 'wipers', 'headlight?', 'call'];
  List<String> lutttttt = ['camera?', 'songs', 'wipers', 'headlights?', 'called'];
  List<int> cval = [0, 0, 0, 0, 0];
  String stateOfDevice = '', deviceCalled = '';

  @override
  void initState() {
    super.initState();
    initSpeechRecognizer();
  }

  Future<void> _shareText() async {
    try {
      Share.text('my text title', '$deviceCalled', 'text/plain');
    } catch (e) {
      print('error: $e');
    }
  }

  void lutCheck() {
    List ls = resultText.split(' ');
    print(ls);
    int x = ls.length.toInt();
    stateOfDevice = '';
    deviceCalled = '';
    for (int j = 0; j < 5; j++) {
      for (int i = 0; i < x; i++) {
        if (ls[i] == 'on' || ls[i] == 'off') {
          setState(() {
            stateOfDevice = ls[i];
          });
        }
        if (ls[i] == lut[j] || ls[i] == lutt[j] || ls[i] == luttt[j] || ls[i] == lutttt[j] || ls[i] == luttttt[j] || ls[i] == lutttttt[j]) {
          setState(() {
            deviceCalled = ls[i];
            cval[j] = 1;
          });
        }
      }
      if(deviceCalled == 'headlights' || deviceCalled == 'headlight' || deviceCalled == 'headlights.' || deviceCalled == 'headlights?'){

      }
      if (stateOfDevice != '' && deviceCalled != '' || deviceCalled == 'call') {
        print(stateOfDevice);
        break;
      }
    }
  }

  void reset() {

    print(deviceCalled);
    initSpeechRecognizer();
    setState(() {
      for (int i = 0; i < 5; i++) {
        cval[i] = 0;
      }
      resultText = '';
    });
  }

  void initSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();

    _speechRecognition.setAvailabilityHandler(
          (bool result) => setState(() => _isAvailable = result),
    );

    _speechRecognition.setRecognitionStartedHandler(
          () => setState(() => _isListening = true),
    );

    _speechRecognition.setRecognitionResultHandler(
          (String speech) => setState(() => resultText = speech),
    );

    _speechRecognition.setRecognitionCompleteHandler(
          () => setState(() => _isListening = false),
    );

    _speechRecognition.activate().then(
          (result) => setState(() => _isAvailable = result),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('DEATHWISH™'),
          backgroundColor: Color(0xff312E52),
        ),
        body: Container(
          child: ListView(
            children: <Widget>[
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    border: Border.all(color: Color(0xff312E52), width: 3.0),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 10.0,
                  ),
                  child: Text(
                    resultText,
                    style: TextStyle(fontSize: 24.0),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: <Widget>[
                    RaisedButton(
                      child: Text(
                        'Go On Look-up',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        lutCheck();
                      },
                      color: Color(0xff5a5774),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    RaisedButton(
                      child: Text(
                        'Reset',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        reset();
                      },
                      color: Color(0xff5a5774),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    RaisedButton(
                      child: Text(
                        'Send',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async => await _shareText(),
                      color: Color(0xff96b98e),
                    ),
                  ],
                ),
              ),
//              MaterialButton(
//                child: Text('Share text'),
//                onPressed: () async => await _shareText(),
//              ),
////              Center(child: Text('Look-Up Table Verification')),
//              Center(
//                child: Padding(
//                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: <Widget>[
//                      Text('STATUS'),
//                      Text('LUT-CONTENT'),
//                    ],
//                  ),
//                ),
//              ),
//              Center(
//                child: Padding(
//                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: <Widget>[
//                      Text('01'),
//                      Text(
//                        lut[0],
//                        style: TextStyle(
//                          color: cval[0] == 1 ? Colors.green : Colors.red,
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//              Center(
//                child: Padding(
//                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: <Widget>[
//                      Text('02'),
//                      Text(
//                        lut[1],
//                        style: TextStyle(
//                          color: cval[1] == 1 ? Colors.green : Colors.red,
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//              Center(
//                child: Padding(
//                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: <Widget>[
//                      Text('03'),
//                      Text(
//                        lut[2],
//                        style: TextStyle(
//                          color: cval[2] == 1 ? Colors.green : Colors.red,
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//              Center(
//                child: Padding(
//                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: <Widget>[
//                      Text('04'),
//                      Text(
//                        lut[3],
//                        style: TextStyle(
//                          color: cval[3] == 1 ? Colors.green : Colors.red,
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//              Center(
//                child: Padding(
//                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: <Widget>[
//                      Text('05'),
//                      Text(
//                        lut[4],
//                        style: TextStyle(
//                          color: cval[4] == 1 ? Colors.green : Colors.red,
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0))),
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Container(
                          height: 120.0,
                          width: 380.0,
                          decoration: BoxDecoration(
                            color: Color(0xff96b98e),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 14.0),
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                  height: 100.0,
                                  width: 100.0,
                                  child: Container(
                                    child: Image(
                                      image: AssetImage('assets/camera.png'),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 25.0,
                                ),
                                Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 35.0,
                                    ),
                                    Text(
                                      lut[0],
                                      style: TextStyle(
                                        color: cval[0] == 1
                                            ? Colors.blueAccent
                                            : Colors.black,
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Container(
                                      width: 100.0,
                                      child: Text(
                                        'Turn ON/OFF',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 50.0,
                                ),
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: cval[0] == 1
                                      ? Icon(Icons.check,size: 30.0,)
                                      : Icon(
                                    Icons.close,size: 30.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Container(
                          height: 120.0,
                          width: 380.0,
                          decoration: BoxDecoration(
                            color: Color(0xffa7d2d2),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 14.0),
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                  height: 100.0,
                                  width: 100.0,
                                  child: Container(
                                    child: Image(
                                      image: AssetImage('assets/music.png'),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 30.0,
                                ),
                                Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 35.0,
                                    ),
                                    Text(
                                      lut[1],
                                      style: TextStyle(
                                        color: cval[1] == 1
                                            ? Colors.blueAccent
                                            : Colors.black,
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Container(
                                      width: 100.0,
                                      child: Text(
                                        'Turn ON/OFF',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 45.0,
                                ),
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: cval[1] == 1
                                      ? Icon(
                                    Icons.check,
                                    size: 30.0,
                                  )
                                      : Icon(
                                    Icons.close,
                                    size: 30.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Container(
                          height: 120.0,
                          width: 380.0,
                          decoration: BoxDecoration(
                            color: Color(0xffe9bf9c),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 14.0),
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                  height: 100.0,
                                  width: 100.0,
                                  child: Container(
                                    child: Image(
                                      image: AssetImage('assets/wipers.png'),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 30.0,
                                ),
                                Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 35.0,
                                    ),
                                    Text(
                                      lut[2],
                                      style: TextStyle(
                                        color: cval[2] == 1
                                            ? Colors.blueAccent
                                            : Colors.black,
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Container(
                                      width: 100.0,
                                      child: Text(
                                        'Turn ON/OFF',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 45.0,
                                ),
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: cval[2] == 1
                                      ? Icon(
                                      Icons.check,
                                      size: 30.0
                                  )
                                      : Icon(
                                      Icons.close,size: 30.0
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Container(
                          height: 120.0,
                          width: 380.0,
                          decoration: BoxDecoration(
                            color: Color(0xffdfc0c0),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 14.0),
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                  height: 100.0,
                                  width: 100.0,
                                  child: Container(
                                    child: Image(
                                      image: AssetImage('assets/headlights.png'),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 30.0,
                                ),
                                Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 35.0,
                                    ),
                                    Text(
                                      lut[3],
                                      style: TextStyle(
                                        color: cval[3] == 1
                                            ? Colors.blueAccent
                                            : Colors.black,
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Container(
                                      width: 100.0,
                                      child: Text(
                                        'Turn ON/OFF',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 33.0,
                                ),
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: cval[3] == 1
                                      ? Icon(Icons.check,size: 30.0)
                                      : Icon(
                                      Icons.close,size: 30.0
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Container(
                          height: 120.0,
                          width: 380.0,
                          decoration: BoxDecoration(
                            color: Color(0xffd4d7de),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Padding(
                            padding:
                            const EdgeInsets.symmetric(horizontal: 14.0),
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                  height: 100.0,
                                  width: 100.0,
                                  child: Container(
                                    child: Image(
                                      image: AssetImage('assets/call.png'),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 30.0,
                                ),
                                Column(
                                  children: <Widget>[
                                    SizedBox(
                                      height: 35.0,
                                    ),
                                    Text(
                                      lut[4],
                                      style: TextStyle(
                                        color: cval[4] == 1
                                            ? Colors.blueAccent
                                            : Colors.black,
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Container(
                                      width: 100.0,
                                      child: Text(
                                        'Turn ON/OFF',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: 45.0,
                                ),
                                Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                  child: cval[4] == 1
                                      ? Icon(Icons.check,size: 30.0)
                                      : Icon(
                                      Icons.close,size: 30.0
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.mic),
          onPressed: () {
            if (_isAvailable && !_isListening)
              _speechRecognition.listen(locale: "en_US").then((result) {
                print('$result');
              });
          },
          backgroundColor: Colors.pink,
        ),
      ),
    );
  }
}
