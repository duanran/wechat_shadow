// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paid_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaidModel _$PaidModelFromJson(Map<String, dynamic> json) {
  return PaidModel(
      id: json['id'] as int,
      item_id: json['item_id'] as int,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String,
      button: json['button'] as String,
      official_price: json['official_price'] as String,
      is_disabled: json['is_disabled'] as int,
      is_free: json['is_free'] as int,
      price: json['price'] as int,
      subscript_name: json['subscript_name'] as String,
      priceType: json['priceType'] as int,
      phoneType: json['phoneType'] as int);
}

Map<String, dynamic> _$PaidModelToJson(PaidModel instance) => <String, dynamic>{
      'id': instance.id,
      'item_id': instance.item_id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'button': instance.button,
      'official_price': instance.official_price,
      'is_disabled': instance.is_disabled,
      'is_free': instance.is_free,
      'price': instance.price,
      'subscript_name': instance.subscript_name,
      'priceType': instance.priceType,
      'phoneType': instance.phoneType
    };
