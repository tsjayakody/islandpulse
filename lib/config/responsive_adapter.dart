import 'dart:ui' as ui;

class ResponsiveAdapter {
  static bool responsiveadapter() {
    //* to check screensize
    bool isAndroidTV;
    bool isPhone;

    final double devicePixelRatio = ui.window.devicePixelRatio;
    final ui.Size size = ui.window.physicalSize;
    final double width = size.width;
    final double height = size.height;

    if (devicePixelRatio < 2 && (width >= 1000 || height >= 1000)) {
      isAndroidTV = true;
      isPhone = false;
    } else if (devicePixelRatio == 2 && (width >= 1920 || height >= 1920)) {
      isAndroidTV = true;
      isPhone = false;
    } else {
      isAndroidTV = false;
      isPhone = true;
    }

    return isAndroidTV;
  }
}
