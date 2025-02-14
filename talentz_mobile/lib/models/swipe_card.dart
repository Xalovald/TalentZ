import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:talentz_mobile/assets/colors/colors.dart';
import 'package:talentz_mobile/assets/images/images.dart';
import 'package:talentz_mobile/ui/typography.dart';
import 'package:talentz_mobile/widgets/state_button.dart';

class SwipeCard extends StatefulWidget {
  final Map data;

  const SwipeCard({
    super.key,
    required this.data,
  });

  @override
  State<SwipeCard> createState() => _SwipeCardState();
}

class _SwipeCardState extends State<SwipeCard> {
  final Logger logger = Logger();
  @override
  void initState() {
    super.initState();
    logger.i(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    // Use the full width and height of the parent container
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        // Main Card Content in Background
        Container(
          height: height - 120, // Adjust height to start below the circle
          width: width,
          margin:
              const EdgeInsets.only(top: 80), // Adjust margin to avoid overlap
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3), // Shadow direction
              ),
            ],
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 70),
                      child: Text(
                        "À propos",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withValues(alpha: 0.5),
                            spreadRadius: 2,
                            blurRadius: 5, // Ombre vers le haut
                          ),
                        ],
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            CustomColors.yellow1(),
                            CustomColors.darkYellow1(),
                          ],
                        ),
                      ),
                      child: Text(
                        "90% Match",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: CustomColors.white(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Description
                const Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec aliquet id metus elementum malesuada. Quisque fringilla ultricies orci mattis porttitor.",
                  style: TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 20),
                // Badges Section
                Text(
                  "Collection de badges :",
                  style: CustomTextStyles.text(
                    size: "larger",
                    color: CustomColors.black(),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        CustomImages.badgeReactif(height: 35, width: 36),
                        Text(
                          "Réponse sous 48H",
                          style: CustomTextStyles.text(
                            size: "smaller",
                            color: CustomColors.grey(),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CustomImages.badgeFeedback(height: 35, width: 36),
                        Text(
                          "Toujours motivé",
                          style: CustomTextStyles.text(
                            size: "smaller",
                            color: CustomColors.grey(),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        CustomImages.badgeRecruteur(height: 35, width: 36),
                        Text(
                          "Candidat engagé",
                          style: CustomTextStyles.text(
                            size: "smaller",
                            color: CustomColors.grey(),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Skills Section
                const Text(
                  "Compétences",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: List<dynamic>.from(widget.data["competences"])
                      .map(
                        (dynamic item) => StateButton(
                          id: item["id"],
                          onClicked: (int integer) => {},
                          child: Text(
                            item["text"],
                            style: CustomTextStyles.text(
                              size: "larger",
                              color: CustomColors.black(),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 20),
                // Soft Skills Section
                const Text(
                  "Softskills",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 10),
                Wrap(
                  children: List<dynamic>.from(widget.data["softskills"])
                      .map(
                        (dynamic item) => StateButton(
                          id: item["id"],
                          onClicked: (int integer) => {},
                          child: Text(
                            item["text"],
                            style: CustomTextStyles.text(
                              size: "larger",
                              color: CustomColors.black(),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ),
        // Circular Section in Foreground
        Padding(
          padding: const EdgeInsets.only(top: 25),
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: CustomColors.slateWhite(), width: 5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.5),
                    spreadRadius: 2,
                    blurRadius: 5, // Ombre vers le haut
                  ),
                ],
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    CustomColors.lightBlue(),
                    CustomColors.lighterBlue(),
                  ],
                ),
              ),
              child: LayoutBuilder(builder: (context, constraints) {
                return Center(
                  child: CustomImages.frozenCherry(
                      width: constraints.maxWidth * 0.7,
                      height: constraints.maxWidth * 0.7,
                      fit: BoxFit.contain),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
