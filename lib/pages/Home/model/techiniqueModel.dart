class techniqueModel {
  final int id;
  final String name;
  final String description;
  final String baseline;
  final int categoryId;
  final String categoryName;

  techniqueModel({
    required this.id,
    required this.name,
    required this.description,
    required this.baseline,
    required this.categoryId,
    required this.categoryName,
  });
}

class categoryModel {
  final int id;
  final String name;
  final String color;
  final int techniqueCount;

  categoryModel({
    required this.id,
    required this.name,
    required this.color,
    required this.techniqueCount,
  });

  factory categoryModel.fromJson(Map<String, dynamic> json) {
    return categoryModel(
      id: json['id'],
      name: json['name'],
      color: json['color'],
      techniqueCount: json['techniques_count'],
    );
  }
}
