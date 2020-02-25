import 'package:flutter/material.dart';

class Pe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('早操俱乐部'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[Text("早操俱乐部")],
        ),
      ),
    );
  }
}
