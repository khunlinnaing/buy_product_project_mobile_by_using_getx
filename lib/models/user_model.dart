class UserModel {
  int id;
  String username, email;
  String? first_name, last_name;
  Profile profile;
  UserModel({
    required this.id,
    required this.username,
    required this.email,
    this.first_name,
    this.last_name,
    required this.profile,
  });
  factory UserModel.jsonForm(dynamic data) {
    Profile profile = Profile.jsonForm(data['profile']);
    return UserModel(
      id: data['id'],
      username: data['username'],
      email: data['email'],
      first_name: data['first_name'],
      last_name: data['last_name'],
      profile: profile,
    );
  }
}

class Profile {
  String? phone, profile;
  Profile({this.phone, this.profile});
  factory Profile.jsonForm(dynamic data) {
    return Profile(phone: data['phone'], profile: data['profile']);
  }
}
