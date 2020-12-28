import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:ksir/src/screenAdaptation.dart';
import 'package:ksir/src/showDralog.dart';
import 'package:loading/indicator/ball_beat_indicator.dart';
import 'package:loading/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';

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


  /// 设置设备上的尺寸计算设计稿的尺寸
  static setSize(double rpx) => Screen.getIst().setSize(rpx);
  /// 根据设计稿尺寸计算设备上的尺寸
  static sizeSet(double xpr) => Screen.getIst().sizeSet(xpr);
  /// 底部操作栏高度
  static bottomBarHeight() => Screen.bottomBarHeight;
  ///每个逻辑像素的字体像素数，字体的缩放比例
  static textScaleFactory() => Screen.textScaleFactory;
  ///设备的像素密度
  static double get pixelRatio => Screen.pixelRatio;
  ///当前设备宽度 dp
  static double get screenWidthDp => Screen.screenWidthDp;
  ///当前设备高度 dp
  static double get screenHeightDp => Screen.screenHeightDp;
  ///当前设备宽度 px
  static double get screenWidth => Screen.screenWidth;
  ///当前设备高度 px
  static double get screenHeight => Screen.screenHeight;
  ///状态栏高度 dp 刘海屏会更高
  static double get statusBarHeight => Screen.statusBarHeight;
  /// 设置最大宽度
  static setFullWidth() => MediaQuery.of(globalContext).size.width;
  /// 设置最大高度
  static setFullHeight() => MediaQuery.of(globalContext).size.height;

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

  /// nextPageIcon

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
}
