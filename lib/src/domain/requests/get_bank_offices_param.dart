// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class GetBankOfficesParam {
  final String? searchString;
  final DateTime? fromDate;
  final DateTime? toDate;
  final String? officeTypeCode;
  final int pageSize;
  final int page;
  final int? bankId;
  final String? registrationStatusCode;
  GetBankOfficesParam({
    this.searchString,
    this.fromDate,
    this.toDate,
    this.officeTypeCode,
    required this.pageSize,
    required this.page,
    this.bankId,
    this.registrationStatusCode,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (searchString != null) 'searchString': searchString,
      if (fromDate != null) 'fromDate': fromDate?.toIso8601String(),
      if (toDate != null) 'toDate': toDate?.toIso8601String(),
      if (officeTypeCode != null) 'officeTypeCode': officeTypeCode,
      if (bankId != null) 'bankId': bankId,
      if (registrationStatusCode != null) 'registrationStatusCode': registrationStatusCode,
      'pageSize': pageSize,
      'page': page,
    };
  }

  Map<String, dynamic> toJson() => toMap();
}
