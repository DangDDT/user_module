import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PostBankOfficeBody {
  final int bankId;
  final String? officeName;
  final String address;
  final String repName;
  final String repPhone;
  final String repEmail;
  final String? officeTypeCode;
  PostBankOfficeBody({
    required this.bankId,
    this.officeName,
    required this.address,
    required this.repName,
    required this.repPhone,
    required this.repEmail,
    this.officeTypeCode,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'bankId': bankId,
      'officeName': officeName,
      'address': address,
      'repName': repName,
      'repPhone': repPhone,
      'repEmail': repEmail,
      'officeTypeCode': officeTypeCode,
    };
  }

  factory PostBankOfficeBody.fromMap(Map<String, dynamic> map) {
    return PostBankOfficeBody(
      bankId: map['bankId'] as int,
      officeName: map['officeName'] != null ? map['officeName'] as String : null,
      address: map['address'] as String,
      repName: map['repName'] as String,
      repPhone: map['repPhone'] as String,
      repEmail: map['repEmail'] as String,
      officeTypeCode: map['officeTypeCode'] != null ? map['officeTypeCode'] as String : null,
    );
  }

  Map<String, dynamic> toJson() => toMap();

  factory PostBankOfficeBody.fromJson(String source) =>
      PostBankOfficeBody.fromMap(json.decode(source) as Map<String, dynamic>);
}
