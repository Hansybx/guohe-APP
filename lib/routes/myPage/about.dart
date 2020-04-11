import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "关于果核",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          })),
      body: SingleChildScrollView(
        child: Column(
//              padding: const EdgeInsets.all(10.0),
          children: <Widget>[
            Image(
                width: 80,
                height: 80,
                image: AssetImage('assets/imgs/logo.jpg')),
            SizedBox(
              height: 15,
            ),
            Column(
              children: <Widget>[
                Text(
                  "v1.0.0",
                  style: TextStyle(fontSize: 25),
                ),
                Text(
                  "果核Lite 二世的初代版本，它大体上已经完成了日常学校生活所需",
                  style: TextStyle(fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
