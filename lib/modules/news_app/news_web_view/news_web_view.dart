import 'package:firstapp/shared/components/components.dart';
import 'package:flutter/material.dart';

class WebViewScreen extends StatelessWidget {

  WebViewScreen({@required this.url});
  String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: webView(url: url),
    );
  }
}
