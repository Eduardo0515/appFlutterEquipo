class UserProfile {
  final int id;
  final String firstName;
  final String lastName;
  final String photo;
  final String address;
  final int age;

  UserProfile({this.id, this.firstName, this.lastName, this.photo, this.address, this.age});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      photo: json['photo'],
      address: json['address'],
      age: json['age'],
    );
  }
}