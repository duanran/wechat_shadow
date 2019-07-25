// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

deviceModel _$deviceModelFromJson(Map<String, dynamic> json) {
  return deviceModel(
      id: json['id'] as int,
      user_id: json['user_id'] as int,
      title: json['title'] as String,
      cid: json['cid'] as String,
      can_renew: json['can_renew'] as int,
      device_type: json['device_type'] as int,
      remain_time: json['remain_time'] as int,
      screen_image_uri: json['screen_image_uri'] as String,
      service_end_time: json['service_end_time'] as int,
      service_start_time: json['service_start_time'] as int,
      status: json['status'] as int);
}

Map<String, dynamic> _$deviceModelToJson(deviceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.user_id,
      'title': instance.title,
      'cid': instance.cid,
      'can_renew': instance.can_renew,
      'device_type': instance.device_type,
      'remain_time': instance.remain_time,
      'screen_image_uri': instance.screen_image_uri,
      'service_end_time': instance.service_end_time,
      'service_start_time': instance.service_start_time,
      'status': instance.status
    };
