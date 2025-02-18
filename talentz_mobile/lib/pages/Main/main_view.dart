import 'package:flutter/material.dart';
import 'package:talentz/assets/colors/colors.dart';
import 'package:talentz/assets/icons/icons.dart';
import 'package:talentz/globals/routes.dart';
import "dart:developer" as developer;

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    developer.log("Building MainView");
    return DefaultTabController(
        length: CustomRoutes.routes.length,
        initialIndex: CustomRoutes.routeNames.indexOf("SwipingView"),
        child: Scaffold(
          bottomNavigationBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: BottomAppBar(
                elevation: 0,
                color: Colors.transparent,
                child: TabBar(
                    labelPadding: EdgeInsets.zero,
                    indicatorColor: CustomColors.palered(),
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorPadding: const EdgeInsets.all(12),
                    indicator: UnderlineTabIndicator(
                        borderRadius: BorderRadius.circular(100.0),
                        borderSide: BorderSide(
                          width: 42.0,
                          color: CustomColors.palered(),
                        ),
                        insets: const EdgeInsets.only(bottom: -3)),
                    dividerColor: Colors.transparent,
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                    automaticIndicatorColorAdjustment: false,
                    labelColor: CustomColors.white(),
                    unselectedLabelColor: CustomColors.palered(),
                    tabs: CustomRoutes.routeIcons["candidat"]!
                        .map((icon) => const SizedBox(
                              width: double.infinity,
                              child: Tab(
                                child: Icon(
                                  CustomIcons.cupcake,
                                  size: 20,
                                ),
                              ),
                            ))
                        .toList()),
              )),
          body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: CustomRoutes.routes["candidat"]!),
        ));
  }
}
