import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class GetOverallStatParam {
  final String? registerUserId;
  final String? fromDate;
  final String? toDate;
  final String? bankId;
  final String? bankOfficeId;
  GetOverallStatParam({
    this.registerUserId,
    this.fromDate,
    this.toDate,
    this.bankId,
    this.bankOfficeId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (registerUserId != null) 'registerUserId': registerUserId,
      if (fromDate != null) 'fromDate': fromDate,
      if (toDate != null) 'toDate': toDate,
      if (bankId != null) 'bankId': bankId,
      if (bankOfficeId != null) 'bankOfficeId': bankOfficeId,
    };
  }

  Map<String, dynamic> toJson() => toMap();
}
