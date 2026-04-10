import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Body3DWebView extends StatelessWidget {
  const Body3DWebView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("3D Human Body")),
      body: const WebView(
        initialUrl: "http://localhost:8080",
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
