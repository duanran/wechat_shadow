import 'package:json_annotation/json_annotation.dart';

part 'food_model.g.dart';



@JsonSerializable()

class Food{
  final String id;
  final String name;
  final String parentId;

  Food({this.id,this.name,this.parentId});
  factory Food.fromJson(Map<String,dynamic> json) => _$FoodFromJson(json);
  Map<String,dynamic> toJson() => _$FoodToJson(this);

}