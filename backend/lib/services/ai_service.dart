import 'package:tflite_flutter/tflite_flutter.dart';

class AIService {
  Interpreter? _interpreter;

  Future<void> loadModel() async {
    _interpreter = await Interpreter.fromAsset('model.tflite');
  }

  List<double> predict(List<double> input) {
    final output = List.filled(3, 0.0).reshape([1, 3]);
    _interpreter!.run([input], output);
    return output[0];
  }
}
