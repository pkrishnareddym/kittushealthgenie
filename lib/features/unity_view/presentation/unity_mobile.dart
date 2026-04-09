import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';

typedef UnityEventHandler = void Function(Map<String, dynamic> data);

class UnityMobileView extends StatefulWidget {
  final UnityEventHandler? onEvent;

  const UnityMobileView({super.key, this.onEvent});

  @override
  State<UnityMobileView> createState() => _UnityMobileViewState();
}

class _UnityMobileViewState extends State<UnityMobileView> {
  UnityWidgetController? _controller;

  void sendToUnity({
    required String object,
    required String method,
    required Map<String, dynamic> payload,
  }) {
    final msg = jsonEncode(payload);
    _controller?.postMessage(object, method, msg);
  }

  @override
  Widget build(BuildContext context) {
    return UnityWidget(
      onUnityCreated: (c) => _controller = c,
      onUnityMessage: (message) {
        try {
          final data = jsonDecode(message.toString());
          widget.onEvent?.call(data);
        } catch (_) {
          debugPrint("Invalid Unity message: $message");
        }
      },
    );
  }
}
