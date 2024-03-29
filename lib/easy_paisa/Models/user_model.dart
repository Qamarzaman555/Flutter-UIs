class UserModel {
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.status,
  });
  late final int id;
  late final String name;
  late final String email;
  late final String gender;
  late final String status;

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    gender = json['gender'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['gender'] = gender;
    data['status'] = status;
    return data;
  }
}
