class TodoModel {
  final String name;
   int status;

  TodoModel({required this.name, this.status = 0});

  factory TodoModel.fromJson(Map data) {
    return TodoModel(name: data["name"], status: data["status"]);
  }

  Map toJson() {
    return {"name": name, "status": status};
  }
}
