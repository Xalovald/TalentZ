import 'package:flutter/material.dart';
import 'package:talentz/assets/colors/colors.dart';
import 'package:talentz/assets/icons/icons.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.lightGrey3(),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: CustomColors.white(),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, -2), // Ombre vers le haut
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
          child: BottomNavigationBar(
            backgroundColor: CustomColors.white(),
            currentIndex: 0,
            items: [
              BottomNavigationBarItem(
                backgroundColor: CustomColors.white(),
                icon: Icon(
                  CustomIcons.cupcake,
                  color: CustomColors.lightGrey2(),
                  size: 1.4,
                ),
                label: 'Notifications',
              ),
              BottomNavigationBarItem(
                backgroundColor: CustomColors.white(),
                icon: Icon(
                  CustomIcons.cupcake,
                  color: CustomColors.lightGrey2(),
                  size: 1.4,
                ),
                label: 'Échanges',
              ),
              BottomNavigationBarItem(
                backgroundColor: CustomColors.white(),
                icon: Icon(
                  CustomIcons.cupcake,
                  color: CustomColors.lightGrey2(),
                  size: 1.4,
                ),
                label: 'Matching',
              ),
              BottomNavigationBarItem(
                backgroundColor: CustomColors.white(),
                icon: Icon(
                  CustomIcons.cupcake,
                  color: CustomColors.lightGrey2(),
                  size: 1.4,
                ),
                label: 'Mon espace',
              ),
            ],
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
      ),
    );
  }
}