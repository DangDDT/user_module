// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PostBankOfficeRegistrationResponseBody {
  final String? content;
  final int responseUserId;
  final UpdatedBankOfficeInfo updatedBankOfficeInfo;
  final String responseTypeCode;

  PostBankOfficeRegistrationResponseBody({
    this.content,
    required this.responseUserId,
    required this.updatedBankOfficeInfo,
    required this.responseTypeCode,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'content': content,
      'responseUserId': responseUserId,
      'updatedBankOfficeInfo': updatedBankOfficeInfo.toMap(),
      'responseTypeCode': responseTypeCode,
    };
  }

  factory PostBankOfficeRegistrationResponseBody.fromMap(Map<String, dynamic> map) {
    return PostBankOfficeRegistrationResponseBody(
      content: map['content'] != null ? map['content'] as String : null,
      responseUserId: map['responseUserId'] as int,
      updatedBankOfficeInfo: UpdatedBankOfficeInfo.fromMap(map['updatedBankOfficeInfo'] as Map<String, dynamic>),
      responseTypeCode: map['responseTypeCode'] as String,
    );
  }

  Map<String, dynamic> toJson() => toMap();

  factory PostBankOfficeRegistrationResponseBody.fromJson(String source) =>
      PostBankOfficeRegistrationResponseBody.fromMap(json.decode(source) as Map<String, dynamic>);
}

class UpdatedBankOfficeInfo {
  final String? officeName;
  final String? address;
  final String? repName;
  final String? repPhone;
  final String? repEmail;
  final int? bankId;
  final String? officeTypeCode;
  UpdatedBankOfficeInfo({
    this.officeName,
    this.address,
    this.repName,
    this.repPhone,
    this.repEmail,
    this.bankId,
    this.officeTypeCode,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'officeName': officeName,
      'address': address,
      'repName': repName,
      'repPhone': repPhone,
      'repEmail': repEmail,
      'bankId': bankId,
      'officeTypeCode': officeTypeCode,
    };
  }

  factory UpdatedBankOfficeInfo.fromMap(Map<String, dynamic> map) {
    return UpdatedBankOfficeInfo(
      officeName: map['officeName'] != null ? map['officeName'] as String : null,
      address: map['address'] != null ? map['address'] as String : null,
      repName: map['repName'] != null ? map['repName'] as String : null,
      repPhone: map['repPhone'] != null ? map['repPhone'] as String : null,
      repEmail: map['repEmail'] != null ? map['repEmail'] as String : null,
      bankId: map['bankId'] != null ? map['bankId'] as int : null,
      officeTypeCode: map['officeTypeCode'] != null ? map['officeTypeCode'] as String : null,
    );
  }

  Map<String, dynamic> toJson() => toMap();

  factory UpdatedBankOfficeInfo.fromJson(String source) =>
      UpdatedBankOfficeInfo.fromMap(json.decode(source) as Map<String, dynamic>);
}
