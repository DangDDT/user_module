// ignore_for_file: public_member_api_docs, sort_constructors_first
class CommissionModel {
  final String id;
  final DateTime dateOfApply;
  final double value;
  CommissionModel({
    required this.id,
    required this.dateOfApply,
    required this.value,
  });

  factory CommissionModel.loading() {
    return CommissionModel(
      id: '',
      dateOfApply: DateTime(2100),
      value: -1,
    );
  }

  factory CommissionModel.error() {
    return CommissionModel(
      id: '',
      dateOfApply: DateTime(2100),
      value: -1,
    );
  }
}
