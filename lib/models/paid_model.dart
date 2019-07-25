import 'package:json_annotation/json_annotation.dart';

part 'paid_model.g.dart';

@JsonSerializable()


class PaidModel{
  final int id;
  final int item_id;
  final String title;
  final String subtitle;
  final String button;
  final String official_price;
  final int is_disabled;
  final int is_free;
  final int price;
  final String subscript_name;
  final int priceType;
  final int phoneType;

  PaidModel({this.id,this.item_id,this.title,this.subtitle,this.button,this.official_price,this.is_disabled,this.is_free,this.price,this.subscript_name,this.priceType,this.phoneType});
  //反序列化

  factory PaidModel.fromJson(Map<String,dynamic> json) => _$PaidModelFromJson(json);
  Map<String, dynamic> toJson() => _$PaidModelToJson(this);


}
