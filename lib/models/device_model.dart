import 'package:json_annotation/json_annotation.dart';

part 'device_model.g.dart';

@JsonSerializable()

class deviceModel{
  final int id;
  final String user_id;
  final String title;
  final int cid;
  final bool can_renew;
  final int device_type;
  final int remain_time;
  final String screen_image_uri;
  final int service_end_time;
  final int service_start_time;
  final int status;

  deviceModel({this.id, this.user_id, this.title, this.cid, this.can_renew,this.device_type,this.remain_time,this.screen_image_uri,this.service_end_time,this.service_start_time,this.status});
  //反序列化
  factory deviceModel.fromJson(Map<String, dynamic> json) => _$deviceModelFromJson(json);
  Map<String, dynamic> toJson() => _$deviceModelToJson(this);



}
