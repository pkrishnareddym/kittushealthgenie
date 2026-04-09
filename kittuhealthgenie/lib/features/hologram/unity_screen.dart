import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Body3DWebView extends StatefulWidget {
  const Body3DWebView({super.key});

  @override
  State<Body3DWebView> createState() => _Body3DWebViewState();
}

class _Body3DWebViewState extends State<Body3DWebView> {
  late final WebViewController controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) {
            setState(() {
              isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse("http://localhost:8080")); // Unity server
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("3D Human Body 🔥"),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),

          if (isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
}
