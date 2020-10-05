import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/generated/l10n.dart';
import 'package:flutter_app/widgets/commonWidget.dart';

class SchoolMap extends StatefulWidget {
  int orientation;

  SchoolMap(this.orientation);

  @override
  _SchoolMapState createState() => _SchoolMapState();
}

class _SchoolMapState extends State<SchoolMap> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
  }


  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Common.appBar(context, title: S.of(context).map),
      body: SingleChildScrollView(
        child: ExtendedImage.asset(
          'assets/imgs/school_map.jpg',
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
