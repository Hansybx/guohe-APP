//import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class SchoolBus extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
//          Container(
//            child: ExtendedImage.network(
//              'http://notice.just.edu.cn/_upload/article/images/7e/9b/733ec5944db89b767c490b49ffc2/a8b7f3b5-342f-498a-886a-2aa3fd4d8bc2.png',
//              fit: BoxFit.contain,
//              //enableLoadState: false,
//              mode: ExtendedImageMode.gesture,
//              initGestureConfigHandler: (state) {
//                return GestureConfig(
//                    minScale: 0.9,
//                    animationMinScale: 0.7,
//                    maxScale: 3.0,
//                    animationMaxScale: 3.5,
//                    speed: 1.0,
//                    inertialSpeed: 100.0,
//                    initialScale: 1.0,
//                    inPageView: false);
//              },
//            ),
//          ),
//          Container(
//            child: ExtendedImage.network(
//              'http://notice.just.edu.cn/_upload/article/images/7e/9b/733ec5944db89b767c490b49ffc2/fb9f5385-7162-4611-85b3-7709c7b38943.png',
//              fit: BoxFit.contain,
//              //enableLoadState: false,
//              mode: ExtendedImageMode.gesture,
//              initGestureConfigHandler: (state) {
//                return GestureConfig(
//                    minScale: 0.9,
//                    animationMinScale: 0.7,
//                    maxScale: 3.0,
//                    animationMaxScale: 3.5,
//                    speed: 1.0,
//                    inertialSpeed: 100.0,
//                    initialScale: 1.0,
//                    inPageView: false);
//              },
//            ),
//          )
          Image(image: NetworkImage('http://notice.just.edu.cn/_upload/article/images/7e/9b/733ec5944db89b767c490b49ffc2/a8b7f3b5-342f-498a-886a-2aa3fd4d8bc2.png'),),
          Image(image: NetworkImage('http://notice.just.edu.cn/_upload/article/images/7e/9b/733ec5944db89b767c490b49ffc2/fb9f5385-7162-4611-85b3-7709c7b38943.png'),)
        ],
      ),
    );
  }
}
