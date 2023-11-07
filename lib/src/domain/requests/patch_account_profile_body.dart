// ignore_for_file: public_member_api_docs, sort_constructors_first
class PatchAccountProfileBody {
  final String? fullname;
  final String? gender;
  final String? phone;
  final DateTime? dateOfBirth;
  final String? address;
  final String? imageUrl;

  PatchAccountProfileBody({
    required this.fullname,
    required this.gender,
    required this.phone,
    required this.dateOfBirth,
    required this.address,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (fullname != null) 'fullname': fullname,
      if (gender != null) 'gender': gender,
      if (phone != null) 'phone': phone,
      if (dateOfBirth != null) 'dateOfBirth': dateOfBirth!.toIso8601String(),
      if (address != null) 'address': address,
      if (imageUrl != null) 'imageUrl': imageUrl,
    };
  }

  Map<String, dynamic> toJson() => toMap();
}
