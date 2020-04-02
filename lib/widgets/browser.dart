import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Browser extends StatelessWidget {
  const Browser({Key key, this.url, this.title}) : super(key: key);

  final String url;
  final String title;



//  WebViewClient webViewClient = new WebViewClient() {
//  @Override
//  public boolean shouldOverrideUrlLoading(WebView view, String url) {
//    super.shouldOverrideUrlLoading(view, url);
//
//    if (url == null) {
//      return  false;
//    }
//    try {
//      if (url.startsWith("weixin://")) {
//        Intent intent = new Intent(Intent.ACTION_VIEW, Uri.parse(url));
//        view.getContext().startActivity(intent);
//        return true;
//      }
//    } catch (Exception e) {
//      return false;
//    }
//    view.loadUrl(url);
//    return true;
//    }
//  };
//  appWebView.setWebViewClient(webViewClient);

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      url: this.url,
      hidden: true,
      ignoreSSLErrors: true,
      withJavascript: true,
      withZoom: true,
      invalidUrlRegex: '^weixin.*',
    );
  }

}
