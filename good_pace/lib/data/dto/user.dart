import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    required String username,
    required String password,
    required String email,
    required String name,
    required int age,
    required String occupation,
    required List<String> hobbies,
    required String hairColor,
    required String eyeColor,
    required List<String> music,
    required String knownFor,
    required String opinion,
    required String aboutMe,
    required String image,
    //TODO Add Images
  }) = _User;
}
