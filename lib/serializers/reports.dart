import 'package:json_annotation/json_annotation.dart';

part 'reports.g.dart';

@JsonSerializable()
class ReportReasonSerializer {
  ReportReasonSerializer({
    this.id,
    required this.name,
  });

  int? id;
  String name;

  factory ReportReasonSerializer.fromJson(Map<String, dynamic> json) =>
      _$ReportReasonSerializerFromJson(json);

  Map<String, dynamic> toJson() => _$ReportReasonSerializerToJson(this);
}