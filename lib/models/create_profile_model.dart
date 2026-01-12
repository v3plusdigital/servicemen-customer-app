class ProfileCreateRequest {
  final String name;
  final String email;
  final String gender;

  ProfileCreateRequest({
    required this.name,
    required this.email,
    required this.gender,

  });

  Map<String, String> toFields() {
    return {
      'name': name,
      'email': email,
      'gender': gender
    };
  }
}
