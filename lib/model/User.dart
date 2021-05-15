class User {
  String uid;
  String data;

  User(this.uid, this.data);

  get getUid => this.uid;

  set setUid(String uid) => this.uid = uid;

  get getData => this.data;

  set setData(data) => this.data = data;

  Map<String, dynamic> toJson() => {
        'uid': this.uid,
        'data': this.data,
      };
}
