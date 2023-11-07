// ignore_for_file: public_member_api_docs, sort_constructors_first

class Commission {
  final String? id;
  final DateTime? dateOfApply;
  final double? commisionValue;

  Commission({
    this.id,
    this.dateOfApply,
    this.commisionValue,
  });

  factory Commission.fromMap(Map<String, dynamic> map) {
    return Commission(
      id: map['id'] != null ? map['id'] as String : null,
      dateOfApply: map['dateOfApply'] != null
          ? DateTime.tryParse(map['dateOfApply'] as String)
          : null,
      commisionValue: map['commisionValue'] != null
          ? map['commisionValue'] as double
          : null,
    );
  }
}
