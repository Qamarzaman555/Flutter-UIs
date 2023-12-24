class ParentModel {
  List<Model>? data;

  ParentModel({this.data});

  ParentModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Model>[];
      json['data'].forEach((v) {
        data!.add(Model.fromJson(v));
      });
    }
  }
}

class Model {
  int? userId;
  int? id;
  String? title;

  Model({this.userId, this.id, this.title});

  Model.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId'] = userId;
    data['id'] = id;
    data['title'] = title;
    return data;
  }
}
