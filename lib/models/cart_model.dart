import 'package:freezed_annotation/freezed_annotation.dart';

part 'cart_model.freezed.dart';
part 'cart_model.g.dart';

@freezed
class CartModel with _$CartModel {
  const factory CartModel({
    required String name,
    required String description,
    required String size,
    required String type,
    required String height,
    required String humidity,
    required int price,
    required String id,
    required String imageUrl,
    required String postedBy,
  }) = _CartModel;

  factory CartModel.fromJson(Map<String, dynamic> json) =>
      _$CartModelFromJson(json);
}
