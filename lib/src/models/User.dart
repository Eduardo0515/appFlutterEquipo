class User {
  final int id;
  final String name;
  final String lastname;
  //final int edad;
  final String avatar;

  //User({this.id, this.name, this.lastname, this.edad,}) ;
  User({this.id, this.name, this.lastname, this.avatar});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['first_name'],
      lastname: json['last_name'],
      avatar: json['avatar'],
    );
  }
}
