import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:talentz/assets/colors/colors.dart';
import 'package:talentz/assets/icons/icons.dart';
import 'package:talentz/assets/images/images.dart';
import 'package:talentz/ui/typography.dart';
import 'package:talentz/widgets/state_button.dart';

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
                color: Colors.grey.withOpacity(0.5),
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
                            color: Colors.grey.withOpacity(0.5),
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
                        "${widget.data['score']}% Match",
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
                Text(
                  widget.data["user"]["whyCerise"],
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 20),
                // Badges Section
                Visibility(
                  visible: widget.data["user"]["role"] == "candidat",
                  child: Text(
                    "Collection de badges :",
                    style: CustomTextStyles.text(
                      size: "larger",
                      color: CustomColors.black(),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Visibility(
                  visible: widget.data["user"]["role"] == "candidat",
                  child: const SizedBox(height: 10)
                ),
                Visibility(
                  visible: widget.data["user"]["role"] == "candidat",
                  child: Row(
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
                ),
                const SizedBox(height: 10),
                const Divider(height: 1, color: Colors.grey),
                const SizedBox(height: 20),
                // Skills Section
                Visibility(
                  visible: widget.data["user"]["valeursEthiques"].isNotEmpty && widget.data["user"]["role"] == "entreprise",
                  child: const Text(
                    "Valeurs et éthique",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.data["user"]["valeursEthiques"].isNotEmpty && widget.data["user"]["role"] == "entreprise",
                  child: const SizedBox(height: 10)
                ),
                Visibility(
                  visible: widget.data["user"]["valeursEthiques"].isNotEmpty && widget.data["user"]["role"] == "entreprise",
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: List<dynamic>.from(widget.data["user"]["valeursEthiques"])
                        .map(
                          (dynamic item) => StateButton(
                            id: item["id"],
                            onClicked: null,
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
                ),
                Visibility(
                  visible: widget.data["user"]["valeursEthiques"].isNotEmpty && widget.data["user"]["role"] == "entreprise",
                  child: const SizedBox(height: 20)
                ),
                Visibility(
                  visible: widget.data["user"]["apprentissages"].isNotEmpty && widget.data["user"]["role"] == "entreprise",
                  child: const Text(
                    "Apprentissages",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.data["user"]["apprentissages"].isNotEmpty && widget.data["user"]["role"] == "entreprise",
                  child: const SizedBox(height: 10)
                ),
                Visibility(
                  visible: widget.data["user"]["apprentissages"].isNotEmpty && widget.data["user"]["role"] == "entreprise",
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: List<dynamic>.from(widget.data["user"]["apprentissages"])
                        .map(
                          (dynamic item) => StateButton(
                            id: item["id"],
                            onClicked: null,
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
                ),
                Visibility(
                  visible: widget.data["user"]["apprentissages"].isNotEmpty && widget.data["user"]["role"] == "entreprise",
                  child: const SizedBox(height: 20)
                ),
                Visibility(
                  visible: widget.data["user"]["carrieres"].isNotEmpty && widget.data["user"]["role"] == "entreprise",
                  child: const Text(
                    "Carriere",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.data["user"]["carrieres"].isNotEmpty && widget.data["user"]["role"] == "entreprise",
                  child: const SizedBox(height: 10)
                ),
                Visibility(
                  visible: widget.data["user"]["carrieres"].isNotEmpty && widget.data["user"]["role"] == "entreprise",
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: List<dynamic>.from(widget.data["user"]["carrieres"])
                        .map(
                          (dynamic item) => StateButton(
                            id: item["id"],
                            onClicked: null,
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
                ),
                Visibility(
                  visible: widget.data["user"]["carrieres"].isNotEmpty && widget.data["user"]["role"] == "entreprise",
                  child: const SizedBox(height: 20)
                ),
                Visibility(
                  visible: widget.data["user"]["avantages"].isNotEmpty && widget.data["user"]["role"] == "entreprise",
                  child: const Text(
                    "Avantages Salariaux",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.data["user"]["avantages"].isNotEmpty && widget.data["user"]["role"] == "entreprise",
                  child: const SizedBox(height: 10)
                ),
                Visibility(
                  visible: widget.data["user"]["avantages"].isNotEmpty && widget.data["user"]["role"] == "entreprise",
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: List<dynamic>.from(widget.data["user"]["avantages"])
                        .map(
                          (dynamic item) => StateButton(
                            id: item["id"],
                            onClicked: null,
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
                ),
                Visibility(
                  visible: widget.data["user"]["avantages"].isNotEmpty && widget.data["user"]["role"] == "entreprise",
                  child: const SizedBox(height: 20)
                ),
                Visibility(
                  visible: widget.data["user"]["missions"].isNotEmpty && widget.data["user"]["role"] == "entreprise",
                  child: const Divider(height: 1, color: Colors.grey),
                ),
                Visibility(
                  visible: widget.data["user"]["missions"].isNotEmpty && widget.data["user"]["role"] == "entreprise",
                  child: const SizedBox(height: 20)
                ),
                Visibility(
                  visible: widget.data["user"]["missions"].isNotEmpty && widget.data["user"]["role"] == "entreprise",
                  child: const Text(
                    "Tes missions",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.data["user"]["missions"].isNotEmpty && widget.data["user"]["role"] == "entreprise",
                  child: const SizedBox(height: 10)
                ),
                Visibility(
                  visible: widget.data["user"]["missions"].isNotEmpty && widget.data["user"]["role"] == "entreprise",
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: List<dynamic>.from(widget.data["user"]["missions"])
                        .map(
                          (dynamic item) => StateButton(
                            id: item["id"],
                            onClicked: null,
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
                ),
                Visibility(
                  visible: widget.data["user"]["missions"].isNotEmpty && widget.data["user"]["role"] == "entreprise",
                  child: const SizedBox(height: 20)
                ),
                Visibility(
                  visible: widget.data["user"]["competences"].isNotEmpty && widget.data["user"]["role"] == "candidat",
                  child: const Text(
                    "Competences",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.data["user"]["competences"].isNotEmpty && widget.data["user"]["role"] == "candidat",
                  child: const SizedBox(height: 10)
                ),
                Visibility(
                  visible: widget.data["user"]["competences"].isNotEmpty && widget.data["user"]["role"] == "candidat",
                  child: Wrap(
                    children: List<dynamic>.from(widget.data["user"]["competences"])
                        .map(
                          (dynamic item) => StateButton(
                            id: item["id"],
                            onClicked: null,
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
                ),
                Visibility(
                  visible: widget.data["user"]["competences"].isNotEmpty && widget.data["user"]["role"] == "candidat",
                  child: const SizedBox(height: 20)
                ),
                // Soft Skills Section
                Visibility(
                  visible: widget.data["user"]["personnalites"].isNotEmpty && widget.data["user"]["role"] == "candidat",
                  child: const Text(
                    "Softskills",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.data["user"]["personnalites"].isNotEmpty && widget.data["user"]["role"] == "candidat",
                  child: const SizedBox(height: 10)
                ),
                Visibility(
                  visible: widget.data["user"]["personnalites"].isNotEmpty && widget.data["user"]["role"] == "candidat",
                  child: Wrap(
                    children: List<dynamic>.from(widget.data["user"]["personnalites"])
                        .map(
                          (dynamic item) => StateButton(
                            id: item["id"],
                            onClicked: null,
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
                ),
                Visibility(
                  visible: widget.data["user"]["personnalites"].isNotEmpty && widget.data["user"]["role"] == "candidat",
                  child: const SizedBox(height: 20)
                ),
                Visibility(
                  visible: widget.data["user"]["questionMystere"] != null && widget.data["user"]["role"] == "candidat",
                  child: const Text(
                    "Question surprise",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.data["user"]["questionMystere"] != null && widget.data["user"]["role"] == "candidat",
                  child: const SizedBox(height: 10)
                ),
                Visibility(
                  visible: widget.data["user"]["questionMystere"] != null && widget.data["user"]["role"] == "candidat",
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        child: Icon(
                          CustomIcons.cupcake,
                          color: CustomColors.lightGrey5(),
                          size: 1.2,
                        ),
                      ),
                      const SizedBox(width: 20,),
                      Text(
                        widget.data["user"]["questionMystere"] != null ? widget.data["user"]["questionMystere"]["text"] : "",
                        style: CustomTextStyles.text(size: "smaller", color: CustomColors.lightGrey5()),
                      )
                    ]
                  )
                ),
                Visibility(
                  visible: widget.data["user"]["questionMystere"] != null && widget.data["user"]["role"] == "candidat",
                  child: const SizedBox(height: 10)
                ),
                Visibility(
                  visible: widget.data["user"]["questionMystere"] != null && widget.data["user"]["role"] == "candidat",
                  child: Text(
                    widget.data["user"]["questionMystere"] != null ? widget.data["user"]["questionMystere"]["reponse"] : "",
                  )
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
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5, // Ombre vers le haut
                  ),
                ],
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: widget.data["user"]["cerise"] != null ? [
                    CustomColors.lightBlue(),
                    CustomColors.lighterBlue(),
                  ] : [CustomColors.white(), CustomColors.white()],
                ),
              ),
              child: LayoutBuilder(builder: (context, constraints) {
                return Center(
                  child: widget.data["user"]["cerise"] != null ? CustomImages.cherry(
                    widget.data["user"]["cerise"]["id"],
                    width: constraints.maxWidth * 0.7,
                    height: constraints.maxWidth * 0.7,
                    fit: BoxFit.contain
                  ) : const SizedBox(),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
