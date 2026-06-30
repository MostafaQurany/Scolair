import 'package:json_annotation/json_annotation.dart';

part 'login_response_data.g.dart';

@JsonSerializable()
class LoginTokenData {
  const LoginTokenData({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.tokenType,
    required this.scope,
    this.user,
  });

  final String accessToken;

  final String refreshToken;

  final int expiresIn;

  final String tokenType;

  final String scope;
  final LoginUserData? user;

  factory LoginTokenData.fromJson(Map<String, dynamic> json) => LoginTokenData(
    accessToken: json['access_token'] as String? ?? '',
    refreshToken: json['refresh_token'] as String? ?? '',
    expiresIn: json['expires_in'] as int? ?? 0,
    tokenType: json['token_type'] as String? ?? '',
    scope: json['scope'] as String? ?? '',
    user: json['user'] is Map<String, dynamic>
        ? LoginUserData.fromJson(json['user'] as Map<String, dynamic>)
        : null,
  );

  Map<String, dynamic> toJson() => {
    'access_token': accessToken,
    'refresh_token': refreshToken,
    'expires_in': expiresIn,
    'token_type': tokenType,
    'scope': scope,
    if (user != null) 'user': user!.toJson(),
  };
}

class LoginUserData {
  const LoginUserData({
    required this.name,
    required this.email,
    required this.username,
    required this.fullName,
    required this.roles,
    this.firstName,
    this.lastName,
    this.headline,
    this.bio,
    this.userImage,
    this.openTo,
    this.linkedin,
    this.github,
    this.twitter,
    this.language,
  });

  final String name;
  final String email;
  final String username;
  final String fullName;
  final String? firstName;
  final String? lastName;
  final String? headline;
  final String? bio;
  final String? userImage;
  final String? openTo;
  final String? linkedin;
  final String? github;
  final String? twitter;
  final String? language;
  final List<String> roles;

  factory LoginUserData.fromJson(Map<String, dynamic> json) => LoginUserData(
    name: json['name'] as String? ?? '',
    email: json['email'] as String? ?? '',
    username: json['username'] as String? ?? '',
    fullName: json['full_name'] as String? ?? '',
    firstName: json['first_name'] as String?,
    lastName: json['last_name'] as String?,
    headline: json['headline'] as String?,
    bio: json['bio'] as String?,
    userImage: json['user_image'] as String?,
    openTo: json['open_to'] as String?,
    linkedin: json['linkedin'] as String?,
    github: json['github'] as String?,
    twitter: json['twitter'] as String?,
    language: json['language'] as String?,
    roles: (json['roles'] as List<dynamic>? ?? const [])
        .whereType<String>()
        .toList(growable: false),
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'username': username,
    'full_name': fullName,
    'first_name': firstName,
    'last_name': lastName,
    'headline': headline,
    'bio': bio,
    'user_image': userImage,
    'open_to': openTo,
    'linkedin': linkedin,
    'github': github,
    'twitter': twitter,
    'language': language,
    'roles': roles,
  };
}

@JsonSerializable()
class LoginResponseData {
  const LoginResponseData({
    required this.state,
    required this.message,
    required this.data,
  });

  final String state;
  final String message;
  final LoginTokenData data;

  factory LoginResponseData.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseDataToJson(this);
}
