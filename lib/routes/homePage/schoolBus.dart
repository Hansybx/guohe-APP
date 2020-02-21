import 'package:flutter/material.dart';

class SchoolBus extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('校车时刻'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image(image: AssetImage('assets/imgs/schoolbus1.png'),),
            Image(image: AssetImage('assets/imgs/schoolbus2.png'),)
          ],
        ),
      ),
    );
  }
}
