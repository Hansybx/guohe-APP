
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:url_launcher/url_launcher.dart';

class Browser extends StatefulWidget {
  const Browser({Key key, this.url, this.title}) : super(key: key);

  final String url;
  final String title;

  @override
  _BrowserState createState() => _BrowserState();
}

class _BrowserState extends State<Browser> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();

    //监听页面状态改变
    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (url.startsWith("weixin://")) {
        flutterWebviewPlugin.close();
        launch(url);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      url: this.widget.url,
      hidden: true,
      ignoreSSLErrors: true,
      withJavascript: true,
      withZoom: true,
      displayZoomControls: true,
      useWideViewPort: true,
      withOverviewMode: true,
    );
  }
}
