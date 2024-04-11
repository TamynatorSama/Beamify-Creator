class CategoryModel {
  final String id;
  final String tagSlug;

  const CategoryModel({required this.id, required this.tagSlug});

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      CategoryModel(id: json["id"], tagSlug: json["tag_slug"]);
}
