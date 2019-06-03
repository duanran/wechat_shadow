// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodDetail _$FoodDetailFromJson(Map<String, dynamic> json) {
  return FoodDetail(
      id: json['id'] as String,
      title: json['title'] as String,
      tags: json['tags'] as String,
      imtro: json['imtro'] as String,
      ingredients: json['ingredients'] as String,
      burden: json['burden'] as String,
      albums: json['albums'] as List<dynamic>,
      steps: (json['steps'] as List)
          ?.map((e) => e as Map<String, dynamic>)
          ?.toList());
}

Map<String, dynamic> _$FoodDetailToJson(FoodDetail instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'tags': instance.tags,
      'imtro': instance.imtro,
      'ingredients': instance.ingredients,
      'burden': instance.burden,
      'albums': instance.albums,
      'steps': instance.steps
    };
