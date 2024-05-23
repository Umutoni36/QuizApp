class Question {
  final String id;
  String title;
  Map<String, bool> options;
  String categoryName;

  // Constructor
  Question({
    required this.id,
    required this.title,
    required this.options,
    required this.categoryName,
  });
}
