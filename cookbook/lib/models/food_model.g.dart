// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Food _$FoodFromJson(Map<String, dynamic> json) {
  return Food(
      id: json['id'] as String,
      name: json['name'] as String,
      parentId: json['parentId'] as String);
}

Map<String, dynamic> _$FoodToJson(Food instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'parentId': instance.parentId
    };
