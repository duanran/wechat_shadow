import 'package:json_annotation/json_annotation.dart';

part 'food_detail_model.g.dart';


@JsonSerializable()

class FoodDetail {
  final String id;
  final String title;
  final String tags;
  final String imtro;
  final String ingredients;
  final String burden;
  final List<dynamic> albums;
  final List<Map<String, dynamic>> steps;

  FoodDetail({this.id, this.title, this.tags, this.imtro, this.ingredients,this.burden,this.albums,this.steps});
  factory FoodDetail.fromJson(Map<String,dynamic>json) => _$FoodDetailFromJson(json);
  Map<String,dynamic> toJson() => _$FoodDetailToJson(this);

}


