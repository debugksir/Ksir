import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:ksir/src/screenAdaptation.dart';
import 'package:ksir/src/showDralog.dart';
import 'package:loading/indicator/ball_beat_indicator.dart';
import 'package:loading/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';

/// 设置设备上的尺寸计算设计稿的尺寸
setSize(double rpx) => Screen.getIst().setSize(rpx);
/// 根据设计稿尺寸计算设备上的尺寸
sizeSet(double xpr) => Screen.getIst().sizeSet(xpr);
/// 底部操作栏高度
bottomBarHeight() => Screen.bottomBarHeight;
///每个逻辑像素的字体像素数，字体的缩放比例
textScaleFactory() => Screen.textScaleFactory;
///设备的像素密度
pixelRatio() => Screen.pixelRatio;
///当前设备宽度 dp
screenWidthDp() => Screen.screenWidthDp;
///当前设备高度 dp
screenHeightDp() => Screen.screenHeightDp;
///当前设备宽度 px
screenWidth() => Screen.screenWidth;
///当前设备高度 px
screenHeight() => Screen.screenHeight;
///状态栏高度 dp 刘海屏会更高
statusBarHeight() => Screen.statusBarHeight;
/// 设置最大宽度
setFullWidth() => MediaQuery.of(globalContext).size.width;
/// 设置最大高度
setFullHeight() => MediaQuery.of(globalContext).size.height;

BuildContext globalContext;
class Ksir {
  static const MethodChannel _channel = const MethodChannel('ksir');
  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /// 初始化
  static init(BuildContext context, {
    double width = 750,
  }) {
    globalContext = context;
    Screen.instance = Screen.getIst()..init();
    Screen.instance.width = width;
  }

  /// showLoading
  static void showLoading() {
    customShowDialog(
      context: globalContext,
      barrierColor: Color(0x44fffffff),
      barrierDismissible: false,
      builder: (context) {
        return Center(
          child: Loading(indicator: BallBeatIndicator(), color: Color(0xff000000), size: setSize(36),),
        );
      }
    );
  }

  /// showModal
  static void showModal(String title, {
    Function comfirm,
    Function cancel,
    String comfirmTitle = '确认',
    String cancelTitle = '取消'
  }) {
    showDialog(
      context: globalContext,
      builder: (BuildContext context) {
        return CustomDialog(
          backgroundColor: Color(0xffffffff),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
          ),
          minWidth: 280,
          maxWidth: 280,
          minHeight: 120,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                constraints: BoxConstraints(
                  minHeight: 75,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                    color: Color(0xFFE2E2E2),
                    width: 0.5,
                  ))
                ),
                width: 280,
                padding: EdgeInsets.fromLTRB(16, 20, 16, 16),
                child: Ksir.text(title, fontSize: 32, color: Color(0xff333333), textAlign: TextAlign.center, lineHeight: 48)  
              ),
              Container(
                height: 44,
                child: Flex(
                  direction: Axis.horizontal,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          if (cancel != null) cancel();
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Ksir.text(cancelTitle, fontSize: 28, color: Color(0xff999999), textAlign: TextAlign.center)
                      )
                    ),
                    Container(
                      width: 0.5,
                      height: 44,
                      color: Color(0xFFE2E2E2),
                    ),
                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                          if (comfirm != null) comfirm();
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Ksir.text(comfirmTitle, fontSize: 28, color: Color(0xff4499ff), textAlign: TextAlign.center)
                      )
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    );
  }

  /// showToast
  static void showToast(String title, {
    Function callback, 
    int duration = 1500, 
    bool isSuccess = true
  }) {
    Timer(Duration(milliseconds: duration), () {
      Navigator.pop(globalContext);
      if (callback != null) callback();
    });
    customShowDialog(
      context: globalContext,
      barrierDismissible: false,
      barrierColor: Color(0x00ffffff),
      builder: (BuildContext context) {
        return CustomDialog(
          backgroundColor: Color(0x88000000),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(setSize(12))
          ),
          elevation: 0,
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  isSuccess ? Icons.done : Icons.error,
                  size: setSize(80),
                  color: Colors.white,
                ),
                SizedBox(height: setSize(20)),
                Ksir.text(title??'', color: Colors.white, fontSize: 28, textAlign: TextAlign.center, maxLines: 3),
              ]
            )
          )
        );      
      }
    );
  }

  /// showMessage
  static void showMessage(String title, {
    int duration = 1500, 
    Function callback
  }) {
    Timer(Duration(milliseconds: duration), () {
      Navigator.pop(globalContext);
      if (callback != null) callback();
    });
    customShowDialog(
      context: globalContext,
      barrierDismissible: false,
      barrierColor: Color(0x00ffffff),
      builder: (BuildContext context) {
        return CustomDialog(
          backgroundColor: Color(0x88000000),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4)
          ),
          elevation: 0,
          minWidth: 150,
          maxWidth: 320,
          minHeight: 32,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Ksir.text(title, fontSize: 28, color: Colors.white, textAlign: TextAlign.center, maxLines: 2)
              )
            ],
          )
        );
      }
    );
  }

  /// Image组件
  /// 
  /// 
  static Widget image(String src, {
    double width,
    double height,
    BoxFit fit,
  }) {
    if(src.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: src,
        placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
        errorWidget: (context, url, error) => Icon(Icons.error),
        width: setSize(width),
        height: setSize(height),
        fit: fit,
      );
    }else {
      return Image(image: AssetImage(src), width: setSize(width), height: setSize(height), fit: BoxFit.cover,);
    }
  }

  /// avatar
  /// 
  /// 
  static Widget avatar(String src, {
    double width,
  }) {
    return SizedBox(
      width: setSize(width),
      height: setSize(width),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(width/2),
        child: image(src, width: setSize(width), height: setSize(width), fit: BoxFit.cover)
      ),
    );
  }

  /// Text组件
  /// 
  /// 为了节省代码，将Text组件封装成书写更友好的形式
  /// lineHeight, fontWeight同css写法
  static Widget text(String value, {
    double fontSize = 32,
    Color color = Colors.black,
    dynamic fontWeight = 'normal',
    double lineHeight = 32,
    TextAlign textAlign = TextAlign.left,
    TextOverflow overflow = TextOverflow.ellipsis,
    int maxLines,
  }) {
    const matchFontWeight = {
      'bold': FontWeight.bold,
      'normal': FontWeight.normal,
      '100': FontWeight.w100,
      '200': FontWeight.w200,
      '300': FontWeight.w300,
      '400': FontWeight.w400,
      '500': FontWeight.w500,
      '600': FontWeight.w600,
      '700': FontWeight.w700,
      '800': FontWeight.w800,
      '900': FontWeight.w900,
    };
    if(maxLines != null) {
      return Text(
        value,
        style: TextStyle(
          fontSize: setSize(fontSize),
          fontWeight: matchFontWeight['$fontWeight'],
          color: color,
          height: lineHeight/fontSize,
        ),
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
      );
    }else {
      return Text(
        value,
        style: TextStyle(
          fontSize: setSize(fontSize),
          fontWeight: matchFontWeight['$fontWeight'],
          color: color,
          height: lineHeight/fontSize,
        ),
        textAlign: textAlign,
      );
    }
  }

  /// 下一页
  static Widget nextPage({
    Color color = Colors.black, 
    double size = 36,
    Map params, 
    Function onTap}
  ) {
    return GestureDetector(
      onTap: () {
        if(onTap != null) {
          onTap();
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: setSize(50),
        height: setSize(50),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent, width: 1)
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Icon(Icons.arrow_forward_ios, size: setSize(size), color: color,)
          ],
        ),
      ),
    );
  }

  /// 上一页
  static Widget goBack(BuildContext context, {
    Color color = Colors.black, 
    double size = 36,
    Map params, 
    Function onTap}
  ) {
    return GestureDetector(
      onTap: () {
        if(onTap != null) {
          onTap();
        }else {
          if(Navigator.canPop(context)) {
            Navigator.pop(context, params ?? {});
          }
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: setSize(50),
        height: setSize(50),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.transparent, width: 1)
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Icon(Icons.arrow_back_ios, size: setSize(size), color: color,)
          ],
        ),
      ),
    );
  }

  /// actionSheet
  /// 
  static void actionSheet(List<ActionSheetType> options) {
    showModalBottomSheet(
      context: globalContext,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(setSize(16)),
          topRight: Radius.circular(setSize(16)),
        )
      ),
      builder: (BuildContext context) {
        return Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          Container(
            height: setSize(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(setSize(16)),
                topRight: Radius.circular(setSize(16)),
              )
            ),
          ),
          for(var i = 0; i < options.length; i++) options[i].isShow??true ? MaterialButton(
            onPressed: () {
              (options[i].onTap??()=>{})();
              if(Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            padding: EdgeInsets.all(0),
            color: Colors.white,
            child: Container(
              height: setSize(90),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: i == options.length-1 ? Colors.transparent : Color(0xffe2e2e2),
                    width: setSize(1)
                  )
                )
              ),
              alignment: Alignment.center,
              child: Text(
                options[i].title??'',
                style: TextStyle(
                  fontSize: setSize(32),
                  color: options[i].color??Color(0xff333333)
                ),
              ),
            ),
          ) : SizedBox(),
          Container(
            width: MediaQuery.of(context).size.width,
            height: setSize(20),
            color: Color(0xfff8f8f8),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            shape: BeveledRectangleBorder(
              side: BorderSide(width: 0, color: Colors.transparent)
            ),
            color: Colors.white,
            padding: EdgeInsets.all(0),
            child: Container(
              height: setSize(90),
              alignment: Alignment.center,
              child: Text(
                '取消',
                style: TextStyle(
                  fontSize: setSize(32),
                  color: Color(0xFF999999)
                ),
              ),
            ),
          ),
          Container(
            color: Colors.white,
            height: bottomBarHeight(),
          )
        ]
      );
    });
  }

  /// picker
  /// 
  static void picker({
    @required List<String> options,
    String title: '',
    int defaultIndex: 0,
    Function onChange,
    Function onCancel,
    Function onConfirm,
    String cancelTitle: '取消',
    String confirmTitle: '确认',
    Color cancelColor,
    Color confirmColor,
    TextStyle optionTextStyle,
    double optionsHeight: 300,
    double optionHeight: 60,
    bool closeAble: true,
  }) {
    int pickIndex = defaultIndex;
    FixedExtentScrollController pickScrollCtr = new FixedExtentScrollController(initialItem: pickIndex);
    // pickScrollCtrA.animateToItem(currentPosition, duration: Duration(milliseconds: 500), curve: Curves.easeIn);
    showModalBottomSheet(
      context: globalContext,
      isScrollControlled: true,
      isDismissible: closeAble,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(setSize(16)),
          topRight: Radius.circular(setSize(16)),
        )
      ),
      backgroundColor: Colors.white,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: setSize(40)),
              height: setSize(100),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(width: setSize(1), color: Color(0xffeaeaea), style: BorderStyle.solid))
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  closeAble ? GestureDetector(
                    onTap: () {
                      (onCancel??()=>{})();
                      Navigator.pop(context);
                    },
                    child: Text(cancelTitle, style: TextStyle(color: confirmColor??Color(0xff999999), fontSize: setSize(28))),
                  ) : SizedBox(width: setSize(60),),
                  Text(title, style: TextStyle(fontSize: setSize(32), color: Color(0xff333333)),),
                  GestureDetector(
                    onTap: (){
                      (onConfirm??()=> {})(pickIndex, options[pickIndex]);
                      Navigator.pop(context);
                    },
                    child: Text(confirmTitle, style: TextStyle(color: cancelColor??Color(0xff459EF9), fontSize: setSize(28))),
                  ),
                ],
              ),
            ),
            SizedBox(height: setSize(30),),
            Container(
              width: setFullWidth(),
              constraints: BoxConstraints(
                maxHeight: setFullHeight()/2
              ),
              padding: EdgeInsets.fromLTRB(setSize(40), setSize(0), setSize(40), setSize(0)),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          height: setSize(optionsHeight),
                          child: CupertinoPicker(
                            itemExtent: setSize(optionHeight),
                            onSelectedItemChanged: (index) {
                              pickIndex = index;
                              (onChange??()=>{})(index, options[index]);
                            },
                            scrollController: pickScrollCtr,
                            diameterRatio: 90.0,
                            magnification: 1.0,
                            offAxisFraction: 0,
                            useMagnifier: true,
                            looping: false,
                            backgroundColor: Colors.white,
                            children: <Widget>[
                              for(int i = 0; i < options.length; i++) Container(
                                alignment: Alignment.center,
                                child: Text(options[i], style: optionTextStyle??TextStyle(fontSize: setSize(28), color: Color(0xff666666)),),
                              ),
                            ],
                          )
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: bottomBarHeight(),)
                ]
              )
            ),
          ],
        );
      }
    );
  }
}

class ActionSheetType {
  final String title;
  final Function onTap;
  final Color color;
  final bool isShow;
  ActionSheetType({@required this.title,  this.onTap, this.color, this.isShow});
}
