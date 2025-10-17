class AuthModel {
  final bool success;
  final String token;
  final int userid;
  final User user;

  AuthModel({
    required this.success,
    required this.token,
    required this.userid,
    required this.user,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      success: json['success'] ?? false,
      token: json['token'] ?? '',
      userid: json['userid'] ?? 0,
      user: User.fromJson(json['user'] ?? {}),
    );
  }
}

class User {
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final Profile profile;

  User({
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.profile,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      profile: Profile.fromJson(json['profile'] ?? {}),
    );
  }
}

class Profile {
  final int user;
  final String phone;
  final String? profile;

  Profile({required this.user, required this.phone, this.profile});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      user: json['user'] ?? 0,
      phone: json['phone'] ?? '',
      profile: json['profile'],
    );
  }
}

class TokenModel {
  final String token;
  final bool isLogin;
  final int userId;

  TokenModel({
    required this.token,
    required this.isLogin,
    required this.userId,
  });

  Map<String, dynamic> toJson() => {
    "token": token,
    "isLogin": isLogin,
    "userId": userId,
  };

  factory TokenModel.fromJson(Map<String, dynamic> json) => TokenModel(
    token: json['token'],
    isLogin: json['isLogin'],
    userId: json['userId'],
  );
}
