import '../../platform_service.dart';
import '../models/vitals.dart';
import 'ai/ai_engine.dart';
import 'ai/mobile_ai_engine.dart';
import 'ai/fallback_ai_engine.dart';

class AIService {
  late final AIEngine _engine;

  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;

    if (PlatformService.isMobile) {
      _engine = MobileAIEngine();
    } else {
      _engine = FallbackAIEngine();
    }

    await _engine.init();
    _initialized = true;
  }

  double predictRisk(String organ, Vitals vitals) {
    _ensureInit();
    return _engine.predictRisk(organ, vitals);
  }

  String predictDisease(String organ, double risk) {
    _ensureInit();
    return _engine.predictDisease(organ, risk);
  }

  void _ensureInit() {
    if (!_initialized) {
      throw Exception("AIService not initialized. Call init() first.");
    }
  }
}
