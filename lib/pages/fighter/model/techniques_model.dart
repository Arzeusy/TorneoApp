class techniquesModel {
  final int id;
  final String name;
  final String description;
  final int baseline;
  final int categoryId;
  final String category;
  final String techniqueColor;
  final String categoryColor;

  techniquesModel({
    required this.id,
    required this.name,
    required this.description,
    required this.baseline,
    required this.categoryId,
    required this.category,
    required this.techniqueColor,
    required this.categoryColor,
  });

  factory techniquesModel.fromJson(Map<String, dynamic> json) {
    return techniquesModel(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? "",
      baseline: json['baseline'],
      categoryId: json['category_id'],
      category: json['categoria'],
      techniqueColor: json['techniquecolor'],
      categoryColor: json['categorycolor'],
    );
  }
}
