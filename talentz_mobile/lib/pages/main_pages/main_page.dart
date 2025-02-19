import 'package:flutter/material.dart';
import 'package:talentz/assets/colors/colors.dart';
import 'package:talentz/globals/routes.dart';
import "dart:developer" as developer;

import 'package:talentz/ui/typography.dart';

class MainPage extends StatefulWidget {
  final String routesName;
  const MainPage(this.routesName, {super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    setState(() {
      CustomRoutes.selectedRoute = CustomRoutes.routeNames.firstWhere((route) => route == "Matching").toLowerCase();
    });
  }
  @override
  Widget build(BuildContext context) {
    developer.log("Building MainPage");
    return DefaultTabController(
        length: CustomRoutes.routes[widget.routesName]!.length,
        initialIndex: CustomRoutes.routeNames.indexOf("Matching"),
        child: Scaffold(
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white, // Background color
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
              boxShadow: [ // Shadow applied here
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, -2), // Moves shadow upwards
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
              child: BottomAppBar(
                elevation: 0,
                height: 103,
                color: Colors.white,
                child: TabBar(
                    labelPadding: EdgeInsets.zero,
                    onTap: (value) => {
                      setState(() {
                        CustomRoutes.selectedRoute =
                            CustomRoutes.routeIcons.keys.toList()[value];
                      })
                    },
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: CustomColors.red(opacity: 0.05),
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: CustomColors.red(opacity: 0.05),
                    ),
                    dividerColor: Colors.transparent,
                    overlayColor: WidgetStateProperty.all(Colors.transparent),
                    automaticIndicatorColorAdjustment: false,
                    labelColor: CustomColors.white(),
                    unselectedLabelColor: CustomColors.palered(),
                    tabs: CustomRoutes.routeIcons.entries
                        .map((icon) => Tab(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              icon.value[icon.key == CustomRoutes.selectedRoute ? 1 : 0](height: 25, width: 25),
                              Text(
                                CustomRoutes.routeNames[CustomRoutes.routeIcons.keys.toList().indexOf(icon.key)],
                                style: CustomTextStyles.text(
                                  size: "smalest",
                                  color: CustomColors.black(),
                                  bold: icon.key == CustomRoutes.selectedRoute,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                    ).toList(),
                ),
              ),
            ),
          ),
          body: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: CustomRoutes.routes[widget.routesName]!),
        ));
  }
}
