import 'package:flutter/material.dart';
import 'package:talentz_mobile/pages/Main/calendar_view.dart';
import 'package:talentz_mobile/pages/Main/chat_view.dart';
import 'package:talentz_mobile/pages/Main/favorites_view.dart';
import 'package:talentz_mobile/pages/Main/swiping_view.dart';
import 'package:talentz_mobile/pages/Main/user_view.dart';

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