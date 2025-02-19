import 'package:flutter/material.dart';

class CustomImages {
  static Image? cherry(int id,
      {double height = 10,
      double width = 10,
      BoxFit fit = BoxFit.none,
      double scale = 1}) {
    if (id == 1) {
      return Image.asset('lib/assets/images/juicy_cherry.png',
          height: height, width: width, fit: fit, scale: scale);
    } else if (id == 2) {
      return Image.asset('lib/assets/images/cherry_basket.png',
          height: height, width: width, fit: fit, scale: scale);
    } else if (id == 3) {
      return Image.asset('lib/assets/images/frozen_cherry.png',
          height: height, width: width, fit: fit, scale: scale);
    } else if (id == 4) {
      return Image.asset('lib/assets/images/chewed_cherry.png',
          height: height, width: width, fit: fit, scale: scale);
    } else if (id == 5) {
      return Image.asset('lib/assets/images/cupcake.png',
          height: height, width: width, fit: fit, scale: scale);
    } else if (id == 6) {
      return Image.asset('lib/assets/images/cake.png',
          height: height, width: width, fit: fit, scale: scale);
    } else if (id == 7) {
      return Image.asset('lib/assets/images/millefeuille.png',
          height: height, width: width, fit: fit, scale: scale);
    } else if (id == 8) {
      return Image.asset('lib/assets/images/pie.png',
          height: height, width: width, fit: fit, scale: scale);
    } else {
      return null;
    }
  }

  static Image bombCherry(
      {double height = 10,
      double width = 10,
      BoxFit fit = BoxFit.none,
      double scale = 1}) {
    return Image.asset('lib/assets/images/bomb_cherry.png',
        height: height, width: width, fit: fit, scale: scale);
  }

  static Image google({double height = 10, double width = 10}) {
    return Image.asset(
      'lib/assets/images/google.png',
      height: height,
      width: width,
    );
  }

  static Image iphone14({double height = 10, double width = 10}) {
    return Image.asset(
      'lib/assets/images/iPhone14.png',
      height: height,
      width: width,
    );
  }

  static Image pastillesTombantes({double height = 10, double width = 10}) {
    return Image.asset(
      'lib/assets/images/pastillesTombantes.png',
      height: height,
      width: width,
    );
  }

  static Image line1({double height = 10, double width = 10}) {
    return Image.asset(
      'lib/assets/images/line1.png',
      height: height,
      width: width,
    );
  }

  static Image line2({double height = 10, double width = 10}) {
    return Image.asset(
      'lib/assets/images/line2.png',
      height: height,
      width: width,
    );
  }

  static Image line3({double height = 10, double width = 10}) {
    return Image.asset(
      'lib/assets/images/line3.png',
      height: height,
      width: width,
    );
  }

  static Image messages({double height = 10, double width = 10}) {
    return Image.asset(
      'lib/assets/images/messages.png',
      height: height,
      width: width,
    );
  }

  static Image blankIPhone14({double height = 10, double width = 10}) {
    return Image.asset(
      'lib/assets/images/blankiPhone14.png',
      height: height,
      width: width,
    );
  }

  static Image badgeReactif({double height = 10, double width = 10}) {
    return Image.asset(
      'lib/assets/images/badge_reactif.png',
      height: height,
      width: width,
    );
  }

  static Image badgeFeedback({double height = 10, double width = 10}) {
    return Image.asset(
      'lib/assets/images/badge_feedback.png',
      height: height,
      width: width,
    );
  }

  static Image badgeRecruteur({double height = 10, double width = 10}) {
    return Image.asset(
      'lib/assets/images/badge_recruteur.png',
      height: height,
      width: width,
    );
  }

  static Image fondCarroussel({double height = 10, double width = 10}) {
    return Image.asset(
      'lib/assets/images/fond_carrousel.png',
      height: height,
      width: width,
    );
  }

  static Image carroussel({double height = 10, double width = 10}) {
    return Image.asset(
      'lib/assets/images/carroucel1.png',
      height: height,
      width: width,
    );
  }

  static Image component2({double height = 10, double width = 10}) {
    return Image.asset(
      'lib/assets/images/component2.png',
      height: height,
      width: width,
    );
  }

  static Image frame1531({double height = 10, double width = 10}) {
    return Image.asset(
      'lib/assets/images/Frame_1531.png',
      height: height,
      width: width,
    );
  }
  
  static Image radarEffect({double height = 10, double width = 10}) {
    return Image.asset(
      'lib/assets/images/radar_effect.png',
      height: height,
      width: width,
    );
  }
}
