import 'package:book_store_trial1/screens/store.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Generated App',
      theme: new ThemeData(
        primarySwatch: Colors.deepPurple,
        primaryColor: const Color(0xFF673ab7),
        accentColor: const Color(0xFF673ab7),
        canvasColor: const Color(0xFFfafafa),
      ),
      home: StorePage(),
    );
  }
}

// ./gradlew --refresh-dependencies
