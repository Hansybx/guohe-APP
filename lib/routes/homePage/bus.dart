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
