import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/generated/l10n.dart';

class SchoolBus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).bus),
      ),
      body: SingleChildScrollView(
        child: ExtendedImage.asset(
          'assets/imgs/schoolbus.png',
          mode: ExtendedImageMode.gesture,
//              fit: BoxFit.contain,
          initGestureConfigHandler: (state) {
            return GestureConfig(
                minScale: 0.9,
                animationMinScale: 0.7,
                maxScale: 3.0,
                animationMaxScale: 3.5,
                speed: 1.0,
                inertialSpeed: 100.0,
                initialScale: 1.0,
                inPageView: false);
          },
        ),
      ),
    );
  }
}
