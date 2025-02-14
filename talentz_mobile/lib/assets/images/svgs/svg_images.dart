import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSvgImages {
  static SvgPicture matchingNotSelected({double height = 10, double width = 10, BoxFit fit = BoxFit.none}) {
    return SvgPicture.asset("lib/assets/images/svgs/matching_not_selected.svg", height: height, width: width, fit: fit);
  }
  static SvgPicture matchingSelected({double height = 10, double width = 10, BoxFit fit = BoxFit.none}) {
    return SvgPicture.asset("lib/assets/images/svgs/matching_selected.svg", height: height, width: width, fit: fit);
  }
  static SvgPicture msgNotSelected({double height = 10, double width = 10, BoxFit fit = BoxFit.none}) {
    return SvgPicture.asset("lib/assets/images/svgs/msg_not_selected.svg", height: height, width: width, fit: fit);
  }
  static SvgPicture msgSelected({double height = 10, double width = 10, BoxFit fit = BoxFit.none}) {
    return SvgPicture.asset("lib/assets/images/svgs/msg_selected.svg", height: height, width: width, fit: fit);
  }
  static SvgPicture notificationsNotSelected({double height = 10, double width = 10, BoxFit fit = BoxFit.none}) {
    return SvgPicture.asset("lib/assets/images/svgs/notifications_not_selected.svg", height: height, width: width, fit: fit);
  }
  static SvgPicture notificationsSelected({double height = 10, double width = 10, BoxFit fit = BoxFit.none}) {
    return SvgPicture.asset("lib/assets/images/svgs/notifications_selected.svg", height: height, width: width, fit: fit);
  }
  static SvgPicture profilNotSelected({double height = 10, double width = 10, BoxFit fit = BoxFit.none}) {
    return SvgPicture.asset("lib/assets/images/svgs/profil_not_selected.svg", height: height, width: width, fit: fit);
  }
  static SvgPicture profilSelected({double height = 10, double width = 10, BoxFit fit = BoxFit.none}) {
    return SvgPicture.asset("lib/assets/images/svgs/profil_selected.svg", height: height, width: width, fit: fit);
  }
}