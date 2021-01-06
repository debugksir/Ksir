import 'package:flutter/material.dart';
import 'package:ksir/ksir.dart';

class Adaptation extends StatelessWidget {
  final demo01 = 
  '''
  Container(
    width: setSize(690),
    height: setSize(690),
    decoration: BoxDecoration(
      color: Colors.blueGrey,
      borderRadius: BorderRadius.circular(setSize(16))
    ),
  )
  ''';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Ksir.goBack(context, color: Colors.white),
        title: Ksir.text('适配方案', color: Colors.white),
      ),
      body: ListView(
        padding: EdgeInsets.all(setSize(30)),
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Ksir.text('默认以750px设计为准, 如果需要自定义，可以在初始化的时候指定， 如设计稿宽度375：Ksir.init(context, width: 375); 推荐设置750px，以下Demo以750为例。', lineHeight: 1.2),
              SizedBox(height: setSize(30),),
              Container(
                width: setSize(690),
                height: setSize(690),
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(setSize(16))
                ),
                alignment: Alignment.center,
                child: Ksir.text(demo01, color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }
}