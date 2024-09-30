class FighterModel {
  final int id;
  final String name;
  final String lastName;
  final String avatarUrl;
  final bool state;
  final List<LevelModel> level;

  FighterModel({
    required this.id,
    required this.name,
    required this.lastName,
    required this.avatarUrl,
    required this.state,
    required this.level,
  });

  factory FighterModel.fromJson(Map<String, dynamic> json) {
    return FighterModel(
      id: json['id'],
      name: json['name'],
      lastName: json['last_name'],
      avatarUrl: json['avatar_url'],
      state: json['state'],
      level: (json['level'] as List<dynamic>)
          .map((item) => LevelModel.fromJson(item))
          .toList(),
    );
  }
}

class LevelModel {
  final int power;
  final int techniqueID;
  final DateTime? createdAt;

  LevelModel({
    required this.power,
    required this.techniqueID,
    this.createdAt,
  });

  factory LevelModel.fromJson(Map<String, dynamic> json) {
    return LevelModel(
      power: json['power'],
      techniqueID: json['technique_id'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
