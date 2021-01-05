import 'package:flutter/material.dart';
import 'package:ksir/ksir.dart';

class Components extends StatelessWidget {
  final demo01 = 
  '''
  Ksir.text('好好学习，天天向上！', fontSize: 48, color: Colors.black, fontWeight: 'bold', textAlign: TextAlign.right),
  ''';
  final demo02 = 
  '''
  Ksir.image('http://via.placeholder.com/350x150', width: 500, height: 500, fit: BoxFit.cover),
  图片组件自动识别asset和network类型， 当传入src是以http开头时判定为network类型,否则为asset类型。暂不支持file类型
  ''';
  final demo03 = 
  '''
  Ksir.avatar('http://via.placeholder.com/350x150', width: 200),
  圆角头像
  ''';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Ksir.goBack(context, color: Colors.white),
        title: Ksir.text('其他组件', color: Colors.white),
      ),
      body: ListView(
        padding: EdgeInsets.all(setSize(30)),
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Ksir.text('为了节省代码，更加符合css编写习惯，对文字和图片组件进行了封装，使用如下：', lineHeight: 48),
              SizedBox(height: setSize(60),),
              Ksir.text('好好学习，天天向上！', fontSize: 48, color: Colors.black, fontWeight: 'bold', textAlign: TextAlign.right),
              Ksir.text(demo01, lineHeight: 48),
              SizedBox(height: setSize(60),),
              Ksir.image('http://via.placeholder.com/350x150', width: 500, height: 500, fit: BoxFit.cover),
              Ksir.text(demo02, lineHeight: 48),
              SizedBox(height: setSize(60),),
              Ksir.avatar('http://via.placeholder.com/350x150', width: 200),
              Ksir.text(demo03, lineHeight: 48),
            ],
          )
        ],
      ),
    );
  }
}