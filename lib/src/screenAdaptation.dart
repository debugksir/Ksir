import 'dart:ui';

class Screen {
  static Screen instance = new Screen();
  //设计稿的设备尺寸修改
  double width;
  static double _screenWidth;
  static double _screenHeight;
  static double _pixelRatio;
  static double _statusBarHeight;
  static double _bottomBarHeight;
  static double _textScaleFactor;
  static Screen getIst() {
    return instance;
  }
  void init() {
    _pixelRatio = window.devicePixelRatio;
    _screenWidth = window.physicalSize.width / _pixelRatio;
    _screenHeight = window.physicalSize.height / _pixelRatio;
    _statusBarHeight = window.padding.top / _pixelRatio;
    _bottomBarHeight = window.padding.bottom / _pixelRatio;
    _textScaleFactor = window.textScaleFactor;
  }
  ///每个逻辑像素的字体像素数，字体的缩放比例
  static double get textScaleFactory => _textScaleFactor;
  ///设备的像素密度
  static double get pixelRatio => _pixelRatio;
  ///当前设备宽度 dp
  static double get screenWidthDp => _screenWidth;
  ///当前设备高度 dp
  static double get screenHeightDp => _screenHeight;
  ///当前设备宽度 px
  static double get screenWidth => _screenWidth * _pixelRatio;
  ///当前设备高度 px
  static double get screenHeight => _screenHeight * _pixelRatio;
  ///状态栏高度 dp 刘海屏会更高
  static double get statusBarHeight => _statusBarHeight;
  ///底部安全区距离 dp
  static double get bottomBarHeight => _bottomBarHeight;
  ///实际的dp与设计稿px的比例
  get scaleWidth => _screenWidth / instance.width;
  ///根据设计稿的设备宽度适配
  sizeSet(double size) => size / scaleWidth;
  setSize(double size) => size * scaleWidth / _textScaleFactor;
}