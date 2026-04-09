import '../../models/vitals.dart';

abstract class AIEngine {
  Future<void> init();

  double predictRisk(String organ, Vitals vitals);

  String predictDisease(String organ, double risk);
}
