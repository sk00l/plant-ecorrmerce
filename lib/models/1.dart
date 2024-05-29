// // ignore_for_file: invalid_annotation_target

// import 'package:freezed_annotation/freezed_annotation.dart';

// part 'post_model.freezed.dart';
// part 'post_model.g.dart';

// @freezed
// class PostModel with _$PostModel {
//   const factory PostModel({
//     required String caption,
//     required String id,
//     required String postedBy,
//     String? username,
//     bool? isVerified,
//     String? profileImage,
//     @JsonKey(
//         defaultValue:
//             'https://thumbs.dreamstime.com/b/lady-confident-sexy-girl-dress-attractive-girl-wears-expensive-fashionable-evening-dress-nude-shoulders-woman-lady-184347352.jpg')
//     String? imageUrl,
//     String? videoUrl,
//     @JsonKey(defaultValue: 0) int? likeCount,
//     @JsonKey(defaultValue: false) bool? isLiked,
//     @JsonKey(defaultValue: 0) int? commentCount,
//     @JsonKey(defaultValue: false) bool? isSaved,
//     String? createdAt,
//   }) = _PostModel;

//   factory PostModel.fromJson(Map<String, dynamic> json) =>
//       _$PostModelFromJson(json);
// }