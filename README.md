# ksir

一个帮助快速建站的插件

## 使用

添加 ksir 到项目中的 [pubspec.yaml](https://flutter.cn/docs/development/packages-and-plugins/using-packages)文件中

## 使用案例

```dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ksir/ksir.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await Ksir.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }
  @override
  Widget build(BuildContext context) {
    Ksir.init(context, width: 750);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: ListView(
          children: <Widget>[
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Ksir.text(
                  'Running on: $_platformVersion', 
                  fontSize: 40, 
                  fontWeight: 'bold', 
                  color: Color(0xff333333), 
                  lineHeight: 80, 
                ),
                MaterialButton(
                  color: Colors.blue[200],
                  onPressed: () {
                    Ksir.showModal('确认提交吗？');
                  },
                  child: Ksir.text('showModal'),
                ),
                MaterialButton(
                  color: Colors.blue[200],
                  onPressed: () {
                    Ksir.showMessage('账号不能为空！');
                  },
                  child: Ksir.text('showMessage'),
                ),
                MaterialButton(
                  color: Colors.blue[200],
                  onPressed: () {
                    Ksir.showToast('提交成功！');
                  },
                  child: Ksir.text('showToast success'),
                ),
                MaterialButton(
                  color: Colors.blue[200],
                  onPressed: () {
                    Ksir.showToast('提交失败！', isSuccess: false);
                  },
                  child: Ksir.text('showToast fail'),
                ),
                MaterialButton(
                  color: Colors.blue[200],
                  onPressed: () {
                    Ksir.showLoading();
                    Timer(Duration(seconds: 2), () {
                      Navigator.pop(context);
                    });
                  },
                  child: Ksir.text('showLoading'),
                ),
                Ksir.image('http://via.placeholder.com/350x150', width: 500, height: 500, fit: BoxFit.cover),
                SizedBox(height: Ksir.setSize(30),),
                Ksir.avatar('http://via.placeholder.com/350x150', width: 200),
                SizedBox(height: Ksir.setSize(30),),
                Ksir.nextPage(),
                SizedBox(height: Ksir.setSize(30),),
                Ksir.goBack(context),
                SizedBox(height: Ksir.setSize(30),),
                Container(
                  width: Ksir.setSize(600),
                  height: Ksir.setSize(450),
                  color: Colors.blueGrey,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
```