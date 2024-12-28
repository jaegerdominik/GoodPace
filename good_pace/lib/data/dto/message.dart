import 'package:flutter_app/data/enums.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';

@freezed
class Message with _$Message {
  const factory Message({
    required MessageStatus status,
    required DateTime time,
    required String message,
    //TODO Add Images
  }) = _Message;
}
