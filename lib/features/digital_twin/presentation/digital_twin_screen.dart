import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kittushealthgenie/features/unity_view/presentation/unity_view.dart';

// ========================
// MODELS
// ========================
class Organ {
  final String name;
  final Offset position;

  const Organ({required this.name, required this.position});
}

class Vitals {
  final int heartRate;
  final int spo2;
  final int bp;

  const Vitals({
    required this.heartRate,
    required this.spo2,
    required this.bp,
  });
}

// ========================
// STATE MANAGEMENT
// ========================
final vitalsProvider = StateNotifierProvider<VitalsController, Vitals>((ref) {
  return VitalsController();
});

class VitalsController extends StateNotifier<Vitals> {
  VitalsController() : super(const Vitals(heartRate: 80, spo2: 98, bp: 120)) {
    _start();
  }

  Timer? _timer;

  void _start() {
    _timer = Timer.periodic(const Duration(seconds: 2), (_) {
      state = Vitals(
        heartRate: 60 + Random().nextInt(80),
        spo2: 85 + Random().nextInt(15),
        bp: 100 + Random().nextInt(80),
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

// ========================
// SCREEN
// ========================
class DigitalTwinScreen extends ConsumerStatefulWidget {
  const DigitalTwinScreen({super.key});

  @override
  ConsumerState<DigitalTwinScreen> createState() => _DigitalTwinScreenState();
}

class _DigitalTwinScreenState extends ConsumerState<DigitalTwinScreen> {
  final List<Organ> organs = const [
    Organ(name: "Heart", position: Offset(160, 250)),
    Organ(name: "Lungs", position: Offset(160, 180)),
    Organ(name: "Liver", position: Offset(160, 320)),
  ];

  Organ? selectedOrgan;

  double _risk(String organ, Vitals v) {
    switch (organ) {
      case "Heart":
        return (v.heartRate / 120).clamp(0.0, 1.0);
      case "Lungs":
        return ((100 - v.spo2) / 100).clamp(0.0, 1.0);
      case "Liver":
        return (v.bp / 180).clamp(0.0, 1.0);
      default:
        return 0.1;
    }
  }

  Color _color(double risk) {
    if (risk > 0.7) return Colors.redAccent;
    if (risk > 0.4) return Colors.orangeAccent;
    return Colors.greenAccent;
  }

  @override
  Widget build(BuildContext context) {
    final vitals = ref.watch(vitalsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("KittU Digital Twin")),
      body: Stack(
        children: [
          const Positioned.fill(child: UnityMobileView()),
          ...organs.map((organ) {
            final risk = _risk(organ.name, vitals);

            return Positioned(
              top: organ.position.dy,
              left: organ.position.dx,
              child: GestureDetector(
                onTap: () => setState(() => selectedOrgan = organ),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: _color(risk),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    organ.name,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            );
          }),
          if (selectedOrgan != null)
            Align(
              alignment: Alignment.bottomCenter,
              child: _InfoPanel(
                organ: selectedOrgan!,
                vitals: vitals,
                risk: _risk(selectedOrgan!.name, vitals),
              ),
            ),
        ],
      ),
    );
  }
}

// ========================
// INFO PANEL
// ========================
class _InfoPanel extends StatelessWidget {
  final Organ organ;
  final Vitals vitals;
  final double risk;

  const _InfoPanel({
    required this.organ,
    required this.vitals,
    required this.risk,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(organ.name,
              style: const TextStyle(color: Colors.white, fontSize: 18)),
          const SizedBox(height: 8),
          Text("Risk: ${(risk * 100).toStringAsFixed(1)}%",
              style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 8),
          Text(
            "HR: ${vitals.heartRate} | SpO2: ${vitals.spo2} | BP: ${vitals.bp}",
            style: const TextStyle(color: Colors.white60),
          ),
        ],
      ),
    );
  }
}
