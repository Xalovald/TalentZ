import 'package:flutter/material.dart';
import 'package:talentz_mobile/pages/calendar_view.dart';
import 'package:talentz_mobile/pages/chat_view.dart';
import 'package:talentz_mobile/pages/favorites_view.dart';
import 'package:talentz_mobile/pages/swiping_view.dart';
import 'package:talentz_mobile/pages/user_view.dart';

class CustomRoutes {
  static const routes = [
    CalendarView(),
    ChatView(),
    SwipeView(),
    FavoritesView(),
    UserView(),
  ];

  static const routeIcons = [
    Icons.calendar_month_outlined,
    Icons.chat,
    Icons.swipe,
    Icons.favorite,
    Icons.person,
  ];

  static const routeNames = [
    "CalendarView",
    "ChatView",
    "SwipingView",
    "FavoritesView",
    "UserView",
  ];
}