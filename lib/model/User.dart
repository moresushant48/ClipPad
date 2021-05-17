import 'dart:convert';

class User {
  String uid;
  String data;

  User(this.uid, this.data);

  get getUid => this.uid;

  set setUid(String uid) => this.uid = uid;

  get getData => this.data;

  set setData(data) => this.data = data;

  factory User.fromJson(dynamic json) {
    dynamic jsonString = jsonDecode(json);
    return User(jsonString['uid'], jsonString['data']);
  }

  Map<String, dynamic> toJson() => {
        'uid': this.uid,
        'data': this.data,
      };
}
