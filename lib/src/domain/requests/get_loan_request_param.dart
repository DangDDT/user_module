import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class GetLoanRequestParam {
  final int id;
  GetLoanRequestParam({
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
    };
  }

  factory GetLoanRequestParam.fromMap(Map<String, dynamic> map) {
    return GetLoanRequestParam(
      id: map['id'] as int,
    );
  }

  Map<String, dynamic> toJson() => toMap();

  factory GetLoanRequestParam.fromJson(String source) =>
      GetLoanRequestParam.fromMap(json.decode(source) as Map<String, dynamic>);
}
