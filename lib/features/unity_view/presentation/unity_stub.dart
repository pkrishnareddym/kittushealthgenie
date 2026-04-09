import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class UnityMobileView extends StatelessWidget {
  const UnityMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ModelViewer(
      src: 'assets/models/human_body.glb',
      alt: "3D Human Body",
      autoRotate: true,
      cameraControls: true,
    );
  }
}
