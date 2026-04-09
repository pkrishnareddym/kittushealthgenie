class AIService {
  double predictRisk(String organ, Map<String, dynamic> vitals) {
    if (organ == "Heart") {
      return vitals["hr"] / 120;
    }
    if (organ == "Lungs") {
      return (100 - vitals["spo2"]) / 100;
    }
    if (organ == "Brain") {
      return vitals["bp"] / 180;
    }
    return 0.1;
  }

  String predictDisease(String organ, double risk) {
    if (risk > 0.7) return "$organ Critical";
    if (risk > 0.4) return "$organ Warning";
    return "$organ Normal";
  }
}
