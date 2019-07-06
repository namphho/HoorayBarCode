import 'dart:math' as math;

import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

import 'hooray_qr_code.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(child: HoorayBarCode(title: 'Vương Bảo Ngọc',content: '0988172462'));
  }
}

