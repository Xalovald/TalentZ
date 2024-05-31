import 'package:flutter/material.dart';
import 'package:talentz_mobile/assets/colors/colors.dart';
import 'package:talentz_mobile/globals/routes.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: CustomRoutes.routes.length,
        child: Scaffold(
          appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: AppBar(
                backgroundColor: CustomColors.darkGrey,
                bottom: TabBar(
                    labelPadding: EdgeInsets.zero,
                    indicatorColor: CustomColors.gold,
                    indicator: const UnderlineTabIndicator(
                      borderRadius: BorderRadius.zero,
                      borderSide: BorderSide(width: 3.0, color: CustomColors.gold),
                    ),
                    dividerColor: CustomColors.darkGrey,
                    overlayColor:
                        MaterialStateProperty.all(CustomColors.darkGrey),
                    automaticIndicatorColorAdjustment: false,
                    labelColor: CustomColors.white,
                    unselectedLabelColor: CustomColors.lightGrey,
                    tabs: CustomRoutes.routeIcons.map((icon) => SizedBox(
                      width: double.infinity,
                      child: Tab(
                        child: Icon(
                          icon,
                          size: 20,
                        ),
                      ),
                    )
                  ).toList()
                ),
              )),
          body: const TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: CustomRoutes.routes
          ),
        ));
  }
}
