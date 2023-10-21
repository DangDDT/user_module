// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserInfo {
  final String? id;
  final String? username;
  final String? status;
  final String? refId;
  final String? roleName;

  UserInfo({
    this.id,
    this.username,
    this.status,
    this.refId,
    this.roleName,
  });

  factory UserInfo.fromMap(Map<String, dynamic> map) {
    return UserInfo(
      id: map['id'] != null ? map['id'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
      refId: map['refId'] != null ? map['refId'] as String : null,
      roleName: map['roleName'] != null ? map['roleName'] as String : null,
    );
  }

  factory UserInfo.fromJson(String source) =>
      UserInfo.fromMap(json.decode(source) as Map<String, dynamic>);
}
