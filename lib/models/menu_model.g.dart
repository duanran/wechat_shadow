// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Menu _$MenuFromJson(Map<String, dynamic> json) {
  return Menu(
      (json['list'] as List)
          ?.map((e) =>
              e == null ? null : Food.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['name'] as String,
      json['parentId'] as String);
}

Map<String, dynamic> _$MenuToJson(Menu instance) => <String, dynamic>{
      'list': instance.list,
      'name': instance.name,
      'parentId': instance.parentId
    };
