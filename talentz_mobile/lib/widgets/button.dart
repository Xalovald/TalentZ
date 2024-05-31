import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final void Function() onClick;
  final bool isIcon;
  final IconData icon;
  final String text;
  final String heroTag;
  final Color color;
  final double width;
  final double height;
  final double iconSize;

  const CustomButton({
    super.key,
    required this.onClick,
    required this.isIcon,
    this.icon = Icons.add,
    this.text = '',
    required this.heroTag,
    required this.color,
    this.width = 50,
    this.height = 50,
    this.iconSize = 24,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: FloatingActionButton(
        onPressed: onClick,
        heroTag: heroTag,
        backgroundColor: Colors.white,
        shape: CircleBorder(side: BorderSide(width: 3, color: color)),
        child: Center(
          child: isIcon ? Icon(
            icon,
            color: color,
            size: iconSize,
          ) :
          Text(
            text,
            style: TextStyle(color: color),
          )
        ),
      )
    );
  }
}