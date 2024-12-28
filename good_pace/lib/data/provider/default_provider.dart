import 'package:flutter_app/data/dto/message.dart';
import 'package:flutter_app/data/dto/user.dart';
import 'package:flutter_app/data/mock/user_mock_data.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../enums.dart';

final messageProvider = StateProvider<Map<String, List<Message>>>((ref) => {
      "Lisa": [],
      "Rose": [
        Message(
          status: MessageStatus.Recieved,
          time: DateTime.now(),
          message: "Hello",
        ),
        Message(
            status: MessageStatus.Send,
            time: DateTime.now(),
            message: "Hey Rose"),
      ],
      "Somi": [],
      "Taylor": [
        Message(
          status: MessageStatus.Recieved,
          time: DateTime.now(),
          message: "Hello",
        ),
        Message(
            status: MessageStatus.Send,
            time: DateTime.now(),
            message: "Hey Taylor"),
        Message(
          status: MessageStatus.Recieved,
          time: DateTime.now(),
          message: "S3nd nud3s?",
        ),
      ],
      "Jennie": [],
    });

final matchesProvider = StateProvider<List<User>>((ref) => mockMatches);
final userProvider = StateProvider<List<User>>((ref) => mockUser);
final swipesProvider = StateProvider<List<User>>((ref) => mockSwipes);
