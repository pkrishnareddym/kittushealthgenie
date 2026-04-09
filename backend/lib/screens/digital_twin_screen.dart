import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import '../services/ai_service.dart';
import '../services/socket_service.dart';

// MODELS
class Organ {
  final String name;
  final Offset position;
  Organ({required this.name, required this.position});
}

class Vitals {
  final int heartRate;
  final int spo2;
  final int bp;
  Vitals(this.heartRate, this.spo2, this.bp);
}

final organs = [
  Organ(name: "Heart", position: const Offset(160, 250)),
  Organ(name: "Lungs", position: const Offset(160, 180)),
  Organ(name: "Liver", position: const Offset(160, 320)),
];

class DigitalTwinScreen extends StatefulWidget {
  const DigitalTwinScreen({super.key});

  @override
  State<DigitalTwinScreen> createState() => _DigitalTwinScreenState();
}

class _DigitalTwinScreenState extends State<DigitalTwinScreen> {
  final ai = AIService();
  final socket = SocketService();

  UnityWidgetController? unityController;

  Vitals vitals = Vitals(80, 98, 120);
  Organ? selectedOrgan;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    ai.loadModel();
    startVitals();
    listenBackend();
  }

  void startVitals() {
    timer = Timer.periodic(const Duration(seconds: 2), (_) {
      setState(() {
        vitals = Vitals(
          60 + Random().nextInt(80),
          85 + Random().nextInt(15),
          100 + Random().nextInt(80),
        );
      });

      socket.sendVitals(vitals);
    });
  }

  void listenBackend() {
    socket.stream.listen((msg) {
      debugPrint("Backend: $msg");

      unityController?.postMessage(
        'OrganController',
        'UpdateRisk',
        '0.8',
      );
    });
  }

  double calculateRisk(String organ) {
    if (organ == "Heart") return vitals.heartRate / 120;
    if (organ == "Lungs") return (100 - vitals.spo2) / 100;
    if (organ == "Liver") return vitals.bp / 180;
    return 0.1;
  }

  @override
  void dispose() {
    timer?.cancel();
    socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Digital Twin")),
      body: Stack(
        children: [
          UnityWidget(
            onUnityCreated: (c) => unityController = c,
          ),
          ...organs.map((o) => Positioned(
                top: o.position.dy,
                left: o.position.dx,
                child: GestureDetector(
                  onTap: () {
                    setState(() => selectedOrgan = o);

                    final risk = calculateRisk(o.name);
                    unityController?.postMessage(
                      'OrganController',
                      'UpdateRisk',
                      risk.toString(),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    color: Colors.blue.withOpacity(0.5),
                    child: Text(o.name),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
