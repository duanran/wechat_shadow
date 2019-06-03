import 'package:json_annotation/json_annotation.dart';
import 'food_model.dart';

part 'menu_model.g.dart';


@JsonSerializable()

class Menu{
  final List<Food> list;
  final String name;
  final String parentId;

  Menu(this.list,this.name,this.parentId);

  factory Menu.fromJson(Map<String,dynamic> json) => _$MenuFromJson(json);
  Map<String,dynamic> toJson() => _$MenuToJson(this);
}
