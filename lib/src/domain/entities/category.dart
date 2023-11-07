// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'commission.dart';

class Category {
  final String? id;
  final String? name;
  final String? imageUrl;
  final String? description;
  final String? status;
  final bool? isOrderLimit;
  final Commission? commission;

  Category({
    this.id,
    this.name,
    this.imageUrl,
    this.description,
    this.status,
    this.isOrderLimit,
    this.commission,
  });

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      isOrderLimit:
          map['isOrderLimit'] != null ? map['isOrderLimit'] as bool : null,
      commission: map['commission'] != null
          ? Commission.fromMap(map['commission'] as Map<String, dynamic>)
          : null,
    );
  }
}
