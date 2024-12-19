import 'package:flutter/material.dart';
import 'package:talentz_mobile/assets/colors/colors.dart';
import 'package:talentz_mobile/globals/routes.dart';
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
                    indicatorColor: CustomColors.palered,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorPadding: const EdgeInsets.all(12),
                    indicator: UnderlineTabIndicator(
                        borderRadius: BorderRadius.circular(100.0),
                        borderSide: const BorderSide(
                          width: 42.0,
                          color: CustomColors.palered,
                        ),
                        insets: const EdgeInsets.only(bottom: -3)),
                    dividerColor: Colors.transparent,
                    overlayColor: MaterialStateProperty.all(Colors.transparent),
                    automaticIndicatorColorAdjustment: false,
                    labelColor: CustomColors.white,
                    unselectedLabelColor: CustomColors.palered,
                    tabs: CustomRoutes.routeIcons
                        .map((icon) => SizedBox(
                              width: double.infinity,
                              child: Tab(
                                child: Icon(
                                  icon,
                                  size: 20,
                                ),
                              ),
                            ))
                        .toList()),
              )),
          body: const TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: CustomRoutes.routes),
        ));
  }
}
