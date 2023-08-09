import 'package:flutter/material.dart';

import 'fijk_video_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // FijkLog.setLevel(FijkLogLevel.Debug);
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color(0xFFffd54f),
        primaryColorDark: Color(0xFFffc107),
        primaryColorLight: Color(0xFFffecb3),
        dividerColor: Color(0xFFBDBDBD),
      ),
      home: FijkVideoPage(),
    );
  }
}
