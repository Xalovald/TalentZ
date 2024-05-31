import 'package:flutter/material.dart';
import 'package:talentz_mobile/pages/chat_view.dart';
import 'package:talentz_mobile/pages/swiping_view.dart';
import 'package:talentz_mobile/pages/user_view.dart';

class CustomRoutes {
  static const routes = [
    UserView(),
    ChatView(),
    SwipeView(),
  ];

  static const routeIcons = [
    Icons.person,
    Icons.chat,
    Icons.favorite,
  ];

  static const routeNames = [
    "UserView",
    "ChatView",
    "SwipingView",
  ];
}