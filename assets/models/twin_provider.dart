import 'package:flutter_riverpod/flutter_riverpod.dart';

final twinProvider = StateProvider<Map<String, String>>((ref) {
  return {
    "heart": "normal",
    "brain": "stable",
    "lungs": "warning",
  };
});

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'twin_controller.dart';
import '../domain/twin_model.dart';

final twinProvider =
    StateNotifierProvider<TwinController, TwinModel>((ref) {
  return TwinController(ref);
});