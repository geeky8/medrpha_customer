

import 'dart:io';

import 'package:flutter/cupertino.dart';

class IPhoneXPadding extends Container {
  final Widget child;

  IPhoneXPadding({
    @required this.child,
  });

  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    if (!_isIPhoneX(mediaQueryData)) {
      // fallback for all non iPhone X
      return child;
    }


    var outer = mediaQueryData.padding;
    return new MediaQuery(data: new MediaQueryData(
        padding: new EdgeInsets.fromLTRB(
            outer.left, outer.top, outer.right, 100)),
        child: child
    );
  }

  bool _isIPhoneX(MediaQueryData mediaQuery) {
    if (Platform.isIOS) {
      var size = mediaQuery.size;
      if (size.height == 812.0 || size.width == 812.0) {
        return true;
      }
    }
    return false;
  }
}
