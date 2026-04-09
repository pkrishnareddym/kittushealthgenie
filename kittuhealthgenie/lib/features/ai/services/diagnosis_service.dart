import 'symptom_database.dart';

class DiagnosisService {
  static String analyze(String input) {
    input = input.toLowerCase();

    List matchedDiseases = [];

    for (var disease in SymptomDatabase.diseases) {
      for (var symptom in disease.symptoms) {
        if (input.contains(symptom)) {
          matchedDiseases.add(disease);
          break;
        }
      }
    }

    if (matchedDiseases.isEmpty) {
      return """
❌ No strong match found

💡 Try:
• stomach pain + nausea
• headache + stress
• fever + cough
""";
    }

    String result = "";

    for (var d in matchedDiseases) {
      result +=
          """
🦠 Disease: ${d.name}

📌 Symptoms:
${d.symptoms.map((e) => "• $e").join("\n")}

💡 Causes:
${d.causes.map((e) => "• $e").join("\n")}

🩺 Solutions:
${d.solutions.map((e) => "• $e").join("\n")}

⚠️ Warnings:
${d.warnings.map((e) => "• $e").join("\n")}

----------------------------------
""";
    }

    return result;
  }
}
