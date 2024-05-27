// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PlantModel {
  final String name;
  final String description;
  final String size;
  final String type;
  final String height;
  final String humidity;
  final int price;
  final String uuid;
  final String imageUrl;
  PlantModel({
    required this.name,
    required this.description,
    required this.size,
    required this.type,
    required this.height,
    required this.humidity,
    required this.price,
    required this.uuid,
    required this.imageUrl,
  });

  PlantModel copyWith({
    String? name,
    String? description,
    String? size,
    String? type,
    String? height,
    String? humidity,
    int? price,
    String? uuid,
    String? imageUrl,
  }) {
    return PlantModel(
      name: name ?? this.name,
      description: description ?? this.description,
      size: size ?? this.size,
      type: type ?? this.type,
      height: height ?? this.height,
      humidity: humidity ?? this.humidity,
      price: price ?? this.price,
      uuid: uuid ?? this.uuid,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'size': size,
      'type': type,
      'height': height,
      'humidity': humidity,
      'price': price,
      'uuid': uuid,
      'imageUrl': imageUrl,
    };
  }

  factory PlantModel.fromMap(Map<String, dynamic> map) {
    return PlantModel(
      name: map['name'] as String,
      description: map['description'] as String,
      size: map['size'] as String,
      type: map['type'] as String,
      height: map['height'] as String,
      humidity: map['humidity'] as String,
      price: map['price'] as int,
      uuid: map['uuid'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlantModel.fromJson(String source) =>
      PlantModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PlantModel(name: $name, description: $description, size: $size, type: $type, height: $height, humidity: $humidity, price: $price, uuid: $uuid, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(covariant PlantModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.description == description &&
        other.size == size &&
        other.type == type &&
        other.height == height &&
        other.humidity == humidity &&
        other.price == price &&
        other.uuid == uuid &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        size.hashCode ^
        type.hashCode ^
        height.hashCode ^
        humidity.hashCode ^
        price.hashCode ^
        uuid.hashCode ^
        imageUrl.hashCode;
  }
}
