import 'package:flutter/material.dart';
import 'package:webapp/main.dart';
import 'screens/webview_screen.dart';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WebView App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: WebViewScreen(initialUrl: 'https://www.google.com'), // Replace with your URL
    );
  }
}