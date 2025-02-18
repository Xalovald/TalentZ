import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:logger/logger.dart';

class CustomHelpers {
  static final Logger _logger = Logger();
  //static const String _key = 'current_id';

  // Get the path for the file inside the app's private documents directory
  static Future<String> get _filePath async {
    final directory = await getApplicationDocumentsDirectory();
    _logger.i(directory.path);
    return directory.path;
  }

  // Get the file reference inside the app's private directory
  static Future<File> get _file async {
    final path = await _filePath;
    final file = File("$path/files/base.txt");

    if (!await file.exists()) {
      // If the file doesn't exist, check if data is stored in flutter_secure_storage
      await file.create(recursive: true);
    }

    return file;
  }

  // Save the number to the file and flutter_secure_storage
  static Future<void> saveCurrentId(int number) async {
    final file = await _file;
    
    // Save data to the file
    await file.writeAsString(number.toString(), mode: FileMode.write);
  }

  // Retrieve the number from the file or flutter_secure_storage
  static Future<int?> getCurrentId() async {
    try {
      final file = await _file;
      final contents = await file.readAsString();
      return int.tryParse(contents);
    } catch (e) {
      _logger.e("Error reading Id: $e");
      return null;
    }
  }

  static Future<void> deleteFile() async {
    final file = await _file;
    await file.delete();
  }
  static const competencesList = [
    {
      "id": 1,
      "name": "Patronage"
    },
    {
      "id": 2,
      "name": "Broderie"
    },
    {
      "id": 3,
      "name": "Couture à la machine"
    },
    {
      "id": 4,
      "name": "Couture à la main"
    },
    {
      "id": 5,
      "name": "Coupe de tissu"
    },
    {
      "id": 6,
      "name": "Retouche"
    },
    {
      "id": 7,
      "name": "Assemblage de vêtements"
    },
    {
      "id": 8,
      "name": "Culture du tissu et matériaux"
    },
  ];
  static const qualitesList = [
    {
      "id": 1,
      "name": "Force de proposition"
    },
    {
      "id": 2,
      "name": "Communication"
    },
    {
      "id": 3,
      "name": "Esprit d'équipe"
    },
    {
      "id": 4,
      "name": "Minutie"
    },
    {
      "id": 5,
      "name": "Patience"
    },
    {
      "id": 6,
      "name": "Adaptabilité"
    },
    {
      "id": 7,
      "name": "Organisation"
    },
    {
      "id": 8,
      "name": "Autonomie"
    },
    {
      "id": 9,
      "name": "Autonomie"
    },
    {
      "id": 10,
      "name": "Autonomie"
    },
    {
      "id": 11,
      "name": "Autonomie"
    },
    {
      "id": 12,
      "name": "Autonomie"
    },
    {
      "id": 13,
      "name": "Autonomie"
    },
    {
      "id": 14,
      "name": "Autonomie"
    },
    {
      "id": 15,
      "name": "Autonomie"
    },
    {
      "id": 16,
      "name": "Autonomie"
    },
    {
      "id": 17,
      "name": "Autonomie"
    },
    {
      "id": 18,
      "name": "Autonomie"
    },
    {
      "id": 18,
      "name": "Autonomie"
    },
    {
      "id": 18,
      "name": "Autonomie"
    },
    {
      "id": 18,
      "name": "Autonomie"
    },
    {
      "id": 18,
      "name": "Autonomie"
    },
    {
      "id": 18,
      "name": "Autonomie"
    },
    {
      "id": 18,
      "name": "Autonomie"
    },
  ];

  static const valueList = [
    {"id": 1, "name": "La planète avant tout"},
    {"id": 2, "name": "Partage"},
    {"id": 3, "name": "A l'écoute"},
    {"id": 4, "name": "Respect"},
    {"id": 5, "name": "Collaboration"},
    {"id": 6, "name": "Responsbalité"},
    {"id": 7, "name": "Durabilité"},
    {"id": 8, "name": "Créativité"},
    {"id": 9, "name": "Passion"},
    {"id": 10, "name": "Transparence"},
    {"id": 11, "name": "Intégrité"},
    {"id": 12, "name": "Confidentiailté"}
  ];

  static const benefitList = [
    {"id": 1, "name": "Ticket restaurant"},
    {"id": 2, "name": "Crèche"},
    {"id": 3, "name": "Crèche"},
    {"id": 4, "name": "Crèche"},
    {"id": 5, "name": "Horaire flexible"},
    {"id": 6, "name": "Carte carburant"},
    {"id": 7, "name": "Carte carburant"},
    {"id": 8, "name": "Primes"},
    {"id": 9, "name": "Carte carburant"},
    {"id": 10, "name": "Carte carburant"},
    {"id": 11, "name": "Carte carburant"},
    {"id": 12, "name": "Carte carburant"},
    {"id": 13, "name": "Crèche"},
    {"id": 14, "name": "Carte carburant"},
    {"id": 15, "name": "Ticket restaurant"},
    {"id": 16, "name": "Ticket restaurant"},
    {"id": 17, "name": "Carte carburant"},
    {"id": 18, "name": "Primes"},
    {"id": 19, "name": "Carte carburant"},
    {"id": 20, "name": "Carte carburant"}
  ];

  static const carrerlist = [
    {"id": 1, "name": "Manager couture"},
    {"id": 2, "name": "Couturier"},
    {"id": 3, "name": "Styliste"},
    {"id": 4, "name": "Chef produit design"}
  ];

  static const learninglist = [
    {"id": 1, "name": "Séléction de matériaux"},
    {"id": 2, "name": "Couture à la main"},
    {"id": 3, "name": "Culture du tissu"},
    {"id": 4, "name": "Couture à la machine"},
    {"id": 5, "name": "Gestion des stocks"},
    {"id": 6, "name": "technique de retouche"},
    {"id": 7, "name": "Ajustements"},
    {"id": 8, "name": "Ajustements"},
    {"id": 9, "name": "Ajustements"},
    {"id": 10, "name": "Ajustements"},
    {"id": 11, "name": "Ajustements"},
    {"id": 12, "name": "Ajustements"},
    {"id": 13, "name": "Ajustements"},
    {"id": 14, "name": "Ajustements"},
    {"id": 15, "name": "Ajustements"},
    {"id": 16, "name": "Ajustements"},
    {"id": 17, "name": "Ajustements"},
    {"id": 18, "name": "Ajustements"},
    {"id": 19, "name": "Couture à la machine"},
    {"id": 20, "name": "Couture à la machine"},
    {"id": 21, "name": "Couture à la machine"},
    {"id": 22, "name": "Couture à la machine"},
    {"id": 23, "name": "Culture du tissu"},
    {"id": 24, "name": "Culture du tissu"},
    {"id": 25, "name": "Culture du tissu"},
    {"id": 26, "name": "Gestion des stocks"},
    {"id": 27, "name": "Gestion des stocks"},
    {"id": 28, "name": "Couture à la machine"},
  ];

  static const masteredCompetencesList = [
    {"id": 1, "name": "Patronage"},
    {"id": 2, "name": "Broderie"},
    {"id": 3, "name": "Couture à la machine"},
    {"id": 4, "name": "Couture à la main"},
    {"id": 5, "name": "Coupe de tissu"},
    {"id": 6, "name": "Retouche"},
    {"id": 7, "name": "Assemblage de vêtements"},
    {"id": 8, "name": "Culture du tissu et matériaux"},
  ];

  static const personalityList = [
    {"id": 1, "name": "Force de proposition"},
    {"id": 2, "name": "Communication"},
    {"id": 3, "name": "Esprit d’équipe"},
    {"id": 4, "name": "Minutie"},
    {"id": 5, "name": "Patience"},
    {"id": 6, "name": "Adaptabilité"},
    {"id": 7, "name": "Organisation"},
    {"id": 8, "name": "Autonomie"},
  ];

  static const missionslist = [
    {"id": 1, "name": "Couture"},
    {"id": 2, "name": "Retouches"},
    {"id": 3, "name": "Sélection de matériaux"},
    {"id": 4, "name": "Création de collections"},
    {"id": 5, "name": "Gestion de commandes"}
  ];
}
