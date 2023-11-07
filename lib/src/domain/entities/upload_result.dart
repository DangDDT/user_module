// ignore_for_file: public_member_api_docs, sort_constructors_first

class UploadResult {
  final String? filename;
  final String? link;
  final String? size;
  final String? type;
  UploadResult({
    this.filename,
    this.link,
    this.size,
    this.type,
  });

  factory UploadResult.fromMap(Map<String, dynamic> map) {
    return UploadResult(
      filename: map['filename'] != null ? map['filename'] as String : null,
      link: map['link'] != null ? map['link'] as String : null,
      size: map['size'] != null ? map['size'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
    );
  }
}
