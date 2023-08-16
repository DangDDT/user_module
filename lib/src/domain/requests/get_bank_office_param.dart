// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

abstract class GetBankOfficeParam {}

class GetBankOfficeByQuery extends GetBankOfficeParam {
  final String query;
  GetBankOfficeByQuery({
    required this.query,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'query': query,
    };
  }

  factory GetBankOfficeByQuery.fromMap(Map<String, dynamic> map) {
    return GetBankOfficeByQuery(
      query: map['query'] as String,
    );
  }

  Map<String, dynamic> toJson() => toMap();

  factory GetBankOfficeByQuery.fromJson(String source) =>
      GetBankOfficeByQuery.fromMap(json.decode(source) as Map<String, dynamic>);
}

class GetBankOfficeByRepEmail extends GetBankOfficeParam {
  final String repEmail;
  GetBankOfficeByRepEmail({
    required this.repEmail,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'repEmail': repEmail,
    };
  }

  factory GetBankOfficeByRepEmail.fromMap(Map<String, dynamic> map) {
    return GetBankOfficeByRepEmail(
      repEmail: map['repEmail'] as String,
    );
  }

  Map<String, dynamic> toJson() => toMap();

  factory GetBankOfficeByRepEmail.fromJson(String source) =>
      GetBankOfficeByRepEmail.fromMap(
          json.decode(source) as Map<String, dynamic>);
}

class GetBankOfficeByRepPhone extends GetBankOfficeParam {
  final String repPhone;

  GetBankOfficeByRepPhone({
    required this.repPhone,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'repPhone': repPhone,
    };
  }

  factory GetBankOfficeByRepPhone.fromMap(Map<String, dynamic> map) {
    return GetBankOfficeByRepPhone(
      repPhone: map['repPhone'] as String,
    );
  }

  Map<String, dynamic> toJson() => toMap();

  factory GetBankOfficeByRepPhone.fromJson(String source) =>
      GetBankOfficeByRepPhone.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
