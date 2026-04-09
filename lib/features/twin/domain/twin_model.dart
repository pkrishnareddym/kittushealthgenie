class OrganData {
  final String name;
  final double risk;

  const OrganData({
    required this.name,
    required this.risk,
  });
}

class TwinModel {
  final List<OrganData> organs;
  final String? selectedOrgan;

  const TwinModel({
    required this.organs,
    this.selectedOrgan,
  });

  TwinModel copyWith({
    List<OrganData>? organs,
    String? selectedOrgan,
  }) {
    return TwinModel(
      organs: organs ?? this.organs,
      selectedOrgan: selectedOrgan ?? this.selectedOrgan,
    );
  }
}

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