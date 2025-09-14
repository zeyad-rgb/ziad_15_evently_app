class EventModel {
  String imagePath;
  String id;
  String userId;
  int date;
  int time;
  String title;
  String description;
  String categoryName;
bool isFave ;

  EventModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.categoryName,
    required this.date,
    required this.time,
    required this.imagePath,
    this.isFave = false,
  });

  // fromJson
  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'] ?? "",
      userId: json['userId'] ?? "",
      title: json['title'] ?? "",
      description: json['description']?? "" ,
      isFave: json['isFave'] ?? false ,
      categoryName: json['categoryName']?? "" ,
      date: json['date'] ?? 0,
      time: json['time'] ?? 0,
      imagePath: json['imagePath'] ?? "",
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'isFave': isFave,
      'categoryName': categoryName,
      'date': date,
      'time': time,
      'imagePath': imagePath,
    };
  }
}
