import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class Twin3DView extends StatelessWidget {
  const Twin3DView({super.key});

  @override
  Widget build(BuildContext context) {
    return const ModelViewer(
      src: 'assets/models/human_body.glb',
      alt: "3D Human Body",
      autoRotate: true,
      cameraControls: true,
      backgroundColor: Colors.transparent,
    );
  }
}
