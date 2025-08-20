class ListModel {
  final int id;
  final String title;
  final String body;

  ListModel({
    required this.id,
    required this.title,
    required this.body,
  });

  factory ListModel.fromJson(Map<String, dynamic> json) {
    return ListModel(id: json['id'], title: json['title'], body: json['body']);
  }
}