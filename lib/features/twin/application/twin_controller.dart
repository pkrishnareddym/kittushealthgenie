class OrganData {
  final String name;
  final double risk;

  const OrganData({
    required this.name,
    required this.risk,
  });

  OrganData copyWith({
    String? name,
    double? risk,
  }) {
    return OrganData(
      name: name ?? this.name,
      risk: risk ?? this.risk,
    );
  }
}

class TwinModel {
  final List<OrganData> organs;
  final String? selectedOrgan;
  final String? disease;

  const TwinModel({
    required this.organs,
    this.selectedOrgan,
    this.disease,
  });

  TwinModel copyWith({
    List<OrganData>? organs,
    String? selectedOrgan,
    String? disease,
  }) {
    return TwinModel(
      organs: organs ?? this.organs,
      selectedOrgan: selectedOrgan ?? this.selectedOrgan,
      disease: disease ?? this.disease,
    );
  }
}

import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/twin_model.dart';
import '../../core/services/ai_service.dart';

class TwinController extends StateNotifier<TwinModel> {
  final Ref ref;
  late final AIService _ai;

  TwinController(this.ref)
      : super(
          const TwinModel(
            organs: [
              OrganData(name: "Heart", risk: 0.2),
              OrganData(name: "Brain", risk: 0.1),
              OrganData(name: "Lungs", risk: 0.3),
            ],
          ),
        ) {
    _ai = AIService();
  }

  // =========================
  // USER ACTION
  // =========================
  void selectOrgan(String organ) {
    state = state.copyWith(selectedOrgan: organ);

    _runAI(organ);
  }

  // =========================
  // UNITY EVENT HANDLER
  // =========================
  void handleUnityEvent(Map<String, dynamic> event) {
    if (event['type'] == 'organ_click') {
      final organ = event['organ'] as String;
      selectOrgan(organ);
    }
  }

  // =========================
  // AI PIPELINE
  // =========================
  Future<void> _runAI(String organ) async {
    final vitals = _mockVitals();

    final risk = _ai.predictRisk(organ, vitals);
    final disease = _ai.predictDisease(organ, risk);

    _updateOrganRisk(organ, risk);

    state = state.copyWith(
      disease: disease,
    );
  }

  // =========================
  // STATE UPDATE
  // =========================
  void _updateOrganRisk(String organ, double risk) {
    final updatedOrgans = state.organs.map((o) {
      if (o.name == organ) {
        return o.copyWith(risk: risk);
      }
      return o;
    }).toList();

    state = state.copyWith(organs: updatedOrgans);
  }

  // =========================
  // MOCK DATA (Replace later)
  // =========================
  Map<String, dynamic> _mockVitals() {
    final rand = Random();

    return {
      "hr": 60 + rand.nextInt(80),
      "spo2": 85 + rand.nextInt(15),
      "bp": 100 + rand.nextInt(80),
    };
  }
}