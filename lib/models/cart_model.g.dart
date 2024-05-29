// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CartModelImpl _$$CartModelImplFromJson(Map<String, dynamic> json) =>
    _$CartModelImpl(
      name: json['name'] as String,
      description: json['description'] as String,
      size: json['size'] as String,
      type: json['type'] as String,
      height: json['height'] as String,
      humidity: json['humidity'] as String,
      price: (json['price'] as num).toInt(),
      id: json['id'] as String,
      imageUrl: json['imageUrl'] as String,
      postedBy: json['postedBy'] as String,
    );

Map<String, dynamic> _$$CartModelImplToJson(_$CartModelImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'size': instance.size,
      'type': instance.type,
      'height': instance.height,
      'humidity': instance.humidity,
      'price': instance.price,
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'postedBy': instance.postedBy,
    };
