import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PostLoanRequestBody {
  final String unitName;
  final String brcNumber;
  final String address;
  final String businessSector;
  final String repName;
  final String repJobTitle;
  final String repPhone;
  final String repEmail;
  final String? question;
  final double loanAmount;
  final String loanPurpose;
  final int registerUserId;
  final int bankOfficeId;
  final String loanTermTypeCode;
  PostLoanRequestBody({
    required this.unitName,
    required this.brcNumber,
    required this.address,
    required this.businessSector,
    required this.repName,
    required this.repJobTitle,
    required this.repPhone,
    required this.repEmail,
    this.question,
    required this.loanAmount,
    required this.loanPurpose,
    required this.registerUserId,
    required this.bankOfficeId,
    required this.loanTermTypeCode,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'unitName': unitName,
      'brcNumber': brcNumber,
      'address': address,
      'businessSector': businessSector,
      'repName': repName,
      'repJobTitle': repJobTitle,
      'repPhone': repPhone,
      'repEmail': repEmail,
      'question': question,
      'loanAmount': loanAmount,
      'loanPurpose': loanPurpose,
      'registerUserId': registerUserId,
      'bankOfficeId': bankOfficeId,
      'loanTermTypeCode': loanTermTypeCode,
    };
  }

  factory PostLoanRequestBody.fromMap(Map<String, dynamic> map) {
    return PostLoanRequestBody(
      unitName: map['unitName'] as String,
      brcNumber: map['brcNumber'] as String,
      address: map['address'] as String,
      businessSector: map['businessSector'] as String,
      repName: map['repName'] as String,
      repJobTitle: map['repJobTitle'] as String,
      repPhone: map['repPhone'] as String,
      repEmail: map['repEmail'] as String,
      question: map['question'] != null ? map['question'] as String : null,
      loanAmount: map['loanAmount'] as double,
      loanPurpose: map['loanPurpose'] as String,
      registerUserId: map['registerUserId'] as int,
      bankOfficeId: map['bankOfficeId'] as int,
      loanTermTypeCode: map['loanTermTypeCode'] as String,
    );
  }

  Map<String, dynamic> toJson() => toMap();

  factory PostLoanRequestBody.fromJson(String source) =>
      PostLoanRequestBody.fromMap(json.decode(source) as Map<String, dynamic>);
}
