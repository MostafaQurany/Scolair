import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  const UserProfile({
    this.id,
    this.name,
    this.username,
    this.email,
    this.fullName,
    this.firstName,
    this.lastName,
    this.headline,
    this.bio,
    this.userImage,
    this.profileImage,
    this.language,
    this.roles = const [],
    this.designation,
    this.department,
    this.subject,
    this.openTo,
    this.linkedin,
    this.github,
    this.twitter,
  });

  final String? id;
  final String? name;
  final String? username;
  final String? email;
  final String? fullName;
  final String? firstName;
  final String? lastName;
  final String? headline;
  final String? bio;
  final String? userImage;
  final String? profileImage;
  final String? language;
  final List<String> roles;
  final String? designation;
  final String? department;
  final String? subject;
  final String? openTo;
  final String? linkedin;
  final String? github;
  final String? twitter;

  /// Displayed avatar image URL, fallback checking both userImage and profileImage.
  String? get displayImageUrl {
    if (userImage != null && userImage!.trim().isNotEmpty) {
      return userImage!.trim();
    }
    if (profileImage != null && profileImage!.trim().isNotEmpty) {
      return profileImage!.trim();
    }
    return null;
  }

  /// Displayed primary name following fallback order:
  /// full_name -> first_name + last_name -> first_name -> username -> email -> 'Teacher'
  String get displayedName {
    if (fullName != null && fullName!.trim().isNotEmpty) {
      return fullName!.trim();
    }
    if (firstName != null && firstName!.trim().isNotEmpty) {
      if (lastName != null && lastName!.trim().isNotEmpty) {
        return '${firstName!.trim()} ${lastName!.trim()}';
      }
      return firstName!.trim();
    }
    if (username != null && username!.trim().isNotEmpty) {
      return username!.trim();
    }
    if (email != null && email!.trim().isNotEmpty) {
      return email!.trim();
    }
    if (name != null && name!.trim().isNotEmpty) {
      return name!.trim();
    }
    return 'Teacher';
  }

  /// Displayed secondary professional summary following fallback order:
  /// headline -> designation -> role/roles -> department -> subject
  String? get displayedSubtitle {
    if (headline != null && headline!.trim().isNotEmpty) {
      return headline!.trim();
    }
    if (designation != null && designation!.trim().isNotEmpty) {
      return designation!.trim();
    }
    if (roles.isNotEmpty) {
      return roles.join(', ');
    }
    if (department != null && department!.trim().isNotEmpty) {
      return department!.trim();
    }
    if (subject != null && subject!.trim().isNotEmpty) {
      return subject!.trim();
    }
    return null;
  }

  UserProfile copyWith({
    String? id,
    String? name,
    String? username,
    String? email,
    String? fullName,
    String? firstName,
    String? lastName,
    String? headline,
    String? bio,
    String? userImage,
    String? profileImage,
    String? language,
    List<String>? roles,
    String? designation,
    String? department,
    String? subject,
    String? openTo,
    String? linkedin,
    String? github,
    String? twitter,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      headline: headline ?? this.headline,
      bio: bio ?? this.bio,
      userImage: userImage ?? this.userImage,
      profileImage: profileImage ?? this.profileImage,
      language: language ?? this.language,
      roles: roles ?? this.roles,
      designation: designation ?? this.designation,
      department: department ?? this.department,
      subject: subject ?? this.subject,
      openTo: openTo ?? this.openTo,
      linkedin: linkedin ?? this.linkedin,
      github: github ?? this.github,
      twitter: twitter ?? this.twitter,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    username,
    email,
    fullName,
    firstName,
    lastName,
    headline,
    bio,
    userImage,
    profileImage,
    language,
    roles,
    designation,
    department,
    subject,
    openTo,
    linkedin,
    github,
    twitter,
  ];
}
