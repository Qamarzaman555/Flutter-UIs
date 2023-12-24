class Articles {
  int id;
  String title;
  String description;
  String body;

  Articles({
    required this.id,
    required this.title,
    required this.description,
    required this.body,
  });

  factory Articles.fromJson(Map<String, dynamic> json) {
    return Articles(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      body: json['body'],
    );
  }
}
