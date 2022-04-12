import 'package:firstapp/shared/components/components.dart';
import 'package:flutter/material.dart';

class WebViewScreen extends StatelessWidget {
  const WebViewScreen({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: webView(url: url),
    );
  }
}
