// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'types.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HemodialysisGroup_designation_id _$HemodialysisGroup_designation_idFromJson(
        Map<String, dynamic> json) =>
    HemodialysisGroup_designation_id(
      designation: json['designation'] as String?,
      id: json['id'] as String,
    );

Map<String, dynamic> _$HemodialysisGroup_designation_idToJson(
        HemodialysisGroup_designation_id instance) =>
    <String, dynamic>{
      'designation': instance.designation,
      'id': instance.id,
    };

Position_startTime _$Position_startTimeFromJson(Map<String, dynamic> json) =>
    Position_startTime(
      startTime: json['startTime'] as int?,
    );

Map<String, dynamic> _$Position_startTimeToJson(Position_startTime instance) =>
    <String, dynamic>{
      'startTime': instance.startTime,
    };

HemodialysisGroup_id _$HemodialysisGroup_idFromJson(
        Map<String, dynamic> json) =>
    HemodialysisGroup_id(
      id: json['id'] as String,
    );

Map<String, dynamic> _$HemodialysisGroup_idToJson(
        HemodialysisGroup_id instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

HemodialysisGroupListResponse _$HemodialysisGroupListResponseFromJson(
        Map<String, dynamic> json) =>
    HemodialysisGroupListResponse(
      hemodialysisGroupList: (json['hemodialysisGroupList'] as List<dynamic>)
          .map((e) => HemodialysisGroup_designation_id.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HemodialysisGroupListResponseToJson(
        HemodialysisGroupListResponse instance) =>
    <String, dynamic>{
      'hemodialysisGroupList': instance.hemodialysisGroupList,
    };

SavePositionResponse _$SavePositionResponseFromJson(
        Map<String, dynamic> json) =>
    SavePositionResponse(
      savePosition: Position_startTime.fromJson(
          json['savePosition'] as Map<String, dynamic>),
      saveHemodialysisGroup: HemodialysisGroup_id.fromJson(
          json['saveHemodialysisGroup'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SavePositionResponseToJson(
        SavePositionResponse instance) =>
    <String, dynamic>{
      'savePosition': instance.savePosition,
      'saveHemodialysisGroup': instance.saveHemodialysisGroup,
    };