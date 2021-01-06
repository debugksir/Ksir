import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ksir/ksir.dart';
import 'package:ksir_example/adaptation.dart';
import 'package:ksir_example/components.dart';
import 'package:ksir_example/nextPage.dart';

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
                MaterialButton(
                  minWidth: setSize(690),
                  color: Color(0xff07c160),
                  onPressed: () {
                    Ksir.showModal('确认提交吗？');
                  },
                  child: Ksir.text('showModal', color: Colors.white),
                ),
                MaterialButton(
                  minWidth: setSize(690),
                  color: Color(0xff07c160),
                  onPressed: () {
                    Ksir.showMessage('账号不能为空！');
                  },
                  child: Ksir.text('showMessage', color: Colors.white),
                ),
                MaterialButton(
                  minWidth: setSize(690),
                  color: Color(0xff07c160),
                  onPressed: () {
                    Ksir.showToast('提交成功！');
                  },
                  child: Ksir.text('showToast success', color: Colors.white),
                ),
                MaterialButton(
                  minWidth: setSize(690),
                  color: Color(0xff07c160),
                  onPressed: () {
                    Ksir.showToast('提交失败！', isSuccess: false);
                  },
                  child: Ksir.text('showToast fail', color: Colors.white),
                ),
                MaterialButton(
                  minWidth: setSize(690),
                  color: Color(0xff07c160),
                  onPressed: () {
                    Ksir.showLoading();
                    Timer(Duration(seconds: 2), () {
                      Navigator.pop(context);
                    });
                  },
                  child: Ksir.text('showLoading', color: Colors.white),
                ),
                MaterialButton(
                  minWidth: setSize(690),
                  color: Color(0xff07c160),
                  onPressed: () {
                    Ksir.actionSheet([
                      ActionSheetType(title: '修改', onTap: () {
                        print('修改');
                      }),
                      ActionSheetType(title: '删除', onTap: () {
                        print('删除');
                      }, color: Colors.red),
                    ]);
                  },
                  child: Ksir.text('showAction', color: Colors.white),
                ),
                MaterialButton(
                  minWidth: setSize(690),
                  color: Color(0xff07c160),
                  onPressed: () {
                    Ksir.picker(
                      options: [PickerType(label: '北京', value: '1'), PickerType(label: '广州', value: '2'), PickerType(label: '上海', value: '3'), PickerType(label: '杭州', value: '4')], 
                      title: '请选择',
                      optionHeight: 80,
                      optionTextStyle: TextStyle(fontSize: 14, color: Colors.blueAccent),
                      defaultValue: '3',
                      onChange: (index, item) {
                        print('$index : $item');
                      },
                      onConfirm: (index, item) {
                        print('$index : ${item.label} / ${item.value}');
                      }
                    );
                  },
                  child: Ksir.text('showPicker', color: Colors.white),
                ),
                Container(
                  width: setSize(690),
                  height: setSize(100),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(width: setSize(1), color: Color(0xffe8e8e8)))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Ksir.text('下一页', fontSize: 32, color: Color(0xff666666)),
                      Ksir.nextPage(onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => NextPage(),));
                      })
                    ],
                  ),
                ),
                Container(
                  width: setSize(690),
                  height: setSize(100),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(width: setSize(1), color: Color(0xffe8e8e8)))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Ksir.text('适配方案', fontSize: 32, color: Color(0xff666666)),
                      Ksir.nextPage(onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Adaptation(),));
                      })
                    ],
                  ),
                ),
                Container(
                  width: setSize(690),
                  height: setSize(100),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(width: setSize(1), color: Color(0xffe8e8e8)))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Ksir.text('其他组件', fontSize: 32, color: Color(0xff666666)),
                      Ksir.nextPage(onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Components(),));
                      })
                    ],
                  ),
                ),
                SizedBox(height: setSize(30),),
              ],
            )
          ],
        ),
      ),
    );
  }
}
