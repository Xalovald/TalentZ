import 'package:flutter/widgets.dart';

class CustomFabIcon extends StatelessWidget {
  final IconData? iconData;
  final String? imagePath;
  final Color? color;
  final double size;

  const CustomFabIcon({
    super.key,
    this.iconData,
    this.imagePath,
    this.color,
    required this.size,
  }) : assert(iconData != null || imagePath != null, "Either iconData or imagePath must be provided");

  @override
  Widget build(BuildContext context) {
    if (iconData != null) {
      return Icon(iconData, color: color, size: size);
    } else if (imagePath != null) {
      return  Image.asset(imagePath.toString(), width: size, height: size,);
    } else {
      return Container();
    }
  }
}
