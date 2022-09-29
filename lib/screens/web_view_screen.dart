import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  // const WebViewScreen({Key? key}) : super(key: key);
   final String url;
  const WebViewScreen(this.url, {super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: WebView(
        initialUrl: url,
      ),
    );
  }
}
