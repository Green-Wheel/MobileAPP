part of 'reports.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReportReasonSerializer _$ReportReasonSerializerFromJson(Map<String, dynamic> json) => ReportReasonSerializer(
      id: json['id'] as int?,
      name: json['name'] as String,
    );

Map<String, dynamic> _$ReportReasonSerializerToJson(ReportReasonSerializer instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
