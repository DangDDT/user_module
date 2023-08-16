import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class GetOverallStatsParam {
  final String? statIndicator;
  final String? fromDate;
  final String? toDate;
  final String? bankId;
  final String? bankOfficeId;
  final String? registerUserId;
  GetOverallStatsParam({
    this.statIndicator,
    this.fromDate,
    this.toDate,
    this.bankId,
    this.bankOfficeId,
    this.registerUserId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (statIndicator != null) 'statIndicator': statIndicator,
      if (fromDate != null) 'fromDate': fromDate,
      if (toDate != null) 'toDate': toDate,
      if (bankId != null) 'bankId': bankId,
      if (bankOfficeId != null) 'bankOfficeId': bankOfficeId,
      if (registerUserId != null) 'registerUserId': registerUserId,
    };
  }

  factory GetOverallStatsParam.fromMap(Map<String, dynamic> map) {
    return GetOverallStatsParam(
      statIndicator:
          map['statIndicator'] != null ? map['statIndicator'] as String : null,
      fromDate: map['fromDate'] != null ? map['fromDate'] as String : null,
      toDate: map['toDate'] != null ? map['toDate'] as String : null,
      bankId: map['bankId'] != null ? map['bankId'] as String : null,
      bankOfficeId: map['bankOfficeId'] as String?,
      registerUserId: map['registerUserId'] as String?,
    );
  }

  Map<String, dynamic> toJson() => toMap();

  factory GetOverallStatsParam.fromJson(String source) =>
      GetOverallStatsParam.fromMap(json.decode(source) as Map<String, dynamic>);
}
