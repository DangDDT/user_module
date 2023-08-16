import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class GetLoanRequestsParam {
  final String? searchString;
  final DateTime? fromDate;
  final DateTime? toDate;
  final int? bankId;
  final int? bankOfficeId;
  final int? loanAmountFrom;
  final int? loanAmountTo;
  final int? registerUserId;
  final String? loanTermTypeCode;
  final String? officeTypeCode;
  final String? registrationStatusCode;
  final int pageSize;
  final int page;
  final String? searchBy;
  GetLoanRequestsParam({
    this.searchString,
    this.fromDate,
    this.toDate,
    this.bankId,
    this.bankOfficeId,
    this.loanAmountFrom,
    this.loanAmountTo,
    this.registerUserId,
    this.loanTermTypeCode,
    this.officeTypeCode,
    this.registrationStatusCode,
    this.searchBy,
    required this.pageSize,
    required this.page,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      if (searchString != null) 'searchString': searchString,
      if (fromDate != null) 'fromDate': fromDate?.toIso8601String(),
      if (toDate != null) 'toDate': toDate?.toIso8601String(),
      if (bankId != null) 'bankId': bankId,
      if (bankOfficeId != null) 'bankOfficeId': bankOfficeId,
      if (loanAmountFrom != null) 'loanAmountFrom': loanAmountFrom,
      if (loanAmountTo != null) 'loanAmountTo': loanAmountTo,
      if (registerUserId != null) 'registerUserId': registerUserId,
      if (loanTermTypeCode != null) 'loanTermTypeCode': loanTermTypeCode,
      if (officeTypeCode != null) 'officeTypeCode': officeTypeCode,
      if (registrationStatusCode != null)
        'registrationStatusCode': registrationStatusCode,
      if (searchBy != null) 'searchBy': searchBy,
      'pageSize': pageSize,
      'page': page,
    };
  }

  factory GetLoanRequestsParam.fromMap(Map<String, dynamic> map) {
    return GetLoanRequestsParam(
      searchString:
          map['searchString'] != null ? map['searchString'] as String : null,
      fromDate: map['fromDate'] != null
          ? DateTime.parse(map['fromDate'] as String)
          : null,
      toDate: map['toDate'] != null
          ? DateTime.parse(map['toDate'] as String)
          : null,
      bankId: map['bankId'] != null ? map['bankId'] as int : null,
      bankOfficeId:
          map['bankOfficeId'] != null ? map['bankOfficeId'] as int : null,
      loanAmountFrom:
          map['loanAmountFrom'] != null ? map['loanAmountFrom'] as int : null,
      loanAmountTo:
          map['loanAmountTo'] != null ? map['loanAmountTo'] as int : null,
      registerUserId:
          map['registerUserId'] != null ? map['registerUserId'] as int : null,
      loanTermTypeCode: map['loanTermTypeCode'] != null
          ? map['loanTermTypeCode'] as String
          : null,
      officeTypeCode: map['officeTypeCode'] != null
          ? map['officeTypeCode'] as String
          : null,
      registrationStatusCode: map['registrationStatusCode'] != null
          ? map['registrationStatusCode'] as String
          : null,
      searchBy: map['searchBy'] != null ? map['searchBy'] as String : null,
      pageSize: map['pageSize'] as int,
      page: map['page'] as int,
    );
  }

  Map<String, dynamic> toJson() => toMap();

  factory GetLoanRequestsParam.fromJson(String source) =>
      GetLoanRequestsParam.fromMap(json.decode(source) as Map<String, dynamic>);
}
