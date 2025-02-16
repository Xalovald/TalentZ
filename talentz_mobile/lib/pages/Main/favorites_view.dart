import 'package:flutter/material.dart';
import 'package:talentz/assets/colors/colors.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: CustomColors.red(),
      )
    );
  }
}