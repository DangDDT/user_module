// ignore_for_file: public_member_api_docs, sort_constructors_first
enum GenderType {
  male('Nam'),
  female('Nữ'),
  other('Khác');

  final String name;

  const GenderType(this.name);
}

class AppUser {
  final String fullName;
  final String phoneNumber;
  final String email;
  final String avatar;
  final GenderType gender;
  final DateTime dob;
  final String address;
  AppUser({
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.avatar,
    required this.gender,
    required this.dob,
    required this.address,
  });
}
