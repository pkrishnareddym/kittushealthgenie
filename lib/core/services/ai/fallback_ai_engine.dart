import 'dart:math';
import 'ai_engine.dart';
import '../../models/vitals.dart';

class FallbackAIEngine implements AIEngine {
  final _rand = Random();

  @override
  Future<void> init() async {
    // No-op
  }

  @override
  double predictRisk(String organ, Vitals vitals) {
    // Mock behavior
    return _rand.nextDouble();
  }

  @override
  String predictDisease(String organ, double risk) {
    if (risk > 0.7) return "$organ Risk Detected";
    return "$organ Stable";
  }
}
