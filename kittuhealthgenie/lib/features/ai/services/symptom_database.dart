import 'models/disease_model.dart';

class SymptomDatabase {
  static List<Disease> diseases = [
    Disease(
      name: "Gastritis",
      symptoms: ["stomach pain", "burning", "nausea", "bloating"],
      causes: ["spicy food", "infection", "stress"],
      solutions: ["antacids", "light food", "warm water"],
      warnings: ["severe pain", "vomiting blood"],
    ),

    Disease(
      name: "Migraine",
      symptoms: ["headache", "light sensitivity", "nausea"],
      causes: ["stress", "sleep issues"],
      solutions: ["rest", "pain relief", "dark room"],
      warnings: ["frequent attacks"],
    ),

    Disease(
      name: "Common Cold",
      symptoms: ["cough", "sneezing", "fever"],
      causes: ["virus"],
      solutions: ["rest", "fluids"],
      warnings: ["breathing issues"],
    ),

    // 👉 YOU CAN ADD 1000+ diseases HERE 🔥
  ];
}
