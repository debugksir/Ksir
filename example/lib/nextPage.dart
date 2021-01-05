import 'package:flutter/material.dart';
import 'package:ksir/ksir.dart';

class NextPage extends StatelessWidget {
  final demo = 
  '''
  Scaffold(
    appBar: AppBar(
      leading: Ksir.goBack(context, color: Colors.white),
      title: Ksir.text('返回上一页', color: Colors.white),
    ),
  );
  ''';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Ksir.goBack(context, color: Colors.white),
        title: Ksir.text('返回上一页', color: Colors.white),
      ),
      body: Ksir.text(demo),
    );
  }
}