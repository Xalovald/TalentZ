import 'package:talentz/assets/images/svgs/svg_images.dart';
import 'package:talentz/pages/main_pages/candidat/matching_page_1.dart';
import 'package:talentz/pages/main_pages/company/matching_page_1.dart';
import 'package:talentz/pages/main_pages/echanges_page.dart';
import 'package:talentz/pages/main_pages/notifications_page.dart';
import 'package:talentz/pages/main_pages/profil_page.dart';

class CustomRoutes {
  static const routes = {
      "candidat": [
        NotificationsPage(),
        EchangesPage(),
        MatchingPageCandidat(),
        ProfilPage(),
      ],
      "entreprise": [
        NotificationsPage(),
        EchangesPage(),
        MatchingPageCompany(),
        ProfilPage(),
      ]
    };

  static const routeIcons = {
    "notifications": [
      CustomSvgImages.notificationsNotSelected,
      CustomSvgImages.notificationsSelected,
    ],
    "messages": [
      CustomSvgImages.msgNotSelected,
      CustomSvgImages.msgSelected,
    ],
    "matching": [
      CustomSvgImages.matchingNotSelected,
      CustomSvgImages.matchingSelected,
    ],
    "profil": [
      CustomSvgImages.profilNotSelected,
      CustomSvgImages.profilSelected,
    ],
  };

  static String selectedRoute = "matching";

  static const routeNames = [
    "Notifications",
    "Echanges",
    "Matching",
    "Profil",
  ];
}