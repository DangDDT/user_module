import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class PostLoanResponseBody {
  final String content;
  final int? disbursementAmount;
  final String responseTypeCode;
  PostLoanResponseBody({
    required this.content,
    this.disbursementAmount,
    required this.responseTypeCode,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'content': content,
      'disbursementAmount': disbursementAmount,
      'responseTypeCode': responseTypeCode,
    };
  }

  factory PostLoanResponseBody.fromMap(Map<String, dynamic> map) {
    return PostLoanResponseBody(
      content: map['content'] as String,
      disbursementAmount: map['disbursementAmount'] != null ? map['disbursementAmount'] as int : null,
      responseTypeCode: map['responseTypeCode'] as String,
    );
  }

  Map<String, dynamic> toJson() => toMap();

  factory PostLoanResponseBody.fromJson(String source) =>
      PostLoanResponseBody.fromMap(json.decode(source) as Map<String, dynamic>);
}
