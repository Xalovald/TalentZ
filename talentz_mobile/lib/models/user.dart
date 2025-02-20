import 'package:flutter/foundation.dart';

class User with ChangeNotifier {
  String? lastName;
  String? companyName;
  String? firstName;
  String? dateNaissance;
  String telephone = "";
  String email = "";
  int? secteurActivite;
  int? companySize;
  String? typePoste;
  int typeContrat = 1;
  String? city;
  String? location;
  String? address;
  String? siret;
  String password = "";
  String? cerise;
  String whyCerise = "";
  List<int> apprentissages = [];
  List<int> avantages = [];
  List<int> carrieres = [];
  List<int> competences = [];
  List<int> missions = [];
  List<int> personnalites = [];
  List<int> valeursEthiques = [];
  Map<String, dynamic>? questionMystere;

  void setLastName(String? value) {
    if (value != lastName) {
      lastName = value;
      notifyListeners();
    }
  }
  void setFirstName(String? value) {
    if (value != firstName) {
      firstName = value;
      notifyListeners();
    }
  }

  void setCompanyName(String? value) {
    if (value!= companyName) {
      companyName = value;
      notifyListeners();
    }
  }

  void setDateNaissance(String? value) {
    if (value!= dateNaissance) {
      dateNaissance = value;
      notifyListeners();
    }
  }

  void setTelephone(String value) {
    if (value!= telephone) {
      telephone = value;
      notifyListeners();
    }
  }

  void setEmail(String value) {
    if (value!= email) {
      email = value;
      notifyListeners();
    }
  }
  void setSecteurActivite(int value) {
    if (value!= secteurActivite) {
      secteurActivite = value;
      notifyListeners();
    }
  }
  void setCompanySize(int value) {
    if (value!= companySize) {
      companySize = value;
      notifyListeners();
    }
  }
  void setTypePoste(String? value) {
    if (value!= typePoste) {
      typePoste = value;
      notifyListeners();
    }
  }
  void setTypeContrat(int value) {
    if (value!= typeContrat) {
      typeContrat = value;
      notifyListeners();
    }
  }

  void setQuestionMystere(Map<String, dynamic> value) {
    if (value!= questionMystere) {
      questionMystere = value;
      notifyListeners();
    }
  }

  void setCity(String? value) {
    if (value!= city) {
      city = value;
      notifyListeners();
    }
  }

  void setLocation(String? value) {
    if (value!= location) {
      location = value;
      notifyListeners();
    }
  }

  void setAddress(String? value) {
    if (value!= address) {
      address = value;
      notifyListeners();
    }
  }

  void setSiret(String? value) {
    if (value!= siret) {
      siret = value;
      notifyListeners();
    }
  }

  void setPassword(String value) {
    if (value!= password) {
      password = value;
      notifyListeners();
    }
  }

  void setCerise(String value) {
    if (value!= cerise) {
      cerise = value;
      notifyListeners();
    }
  }

  void setWhyCerise(String value) {
    if (value!= whyCerise) {
      whyCerise = value;
      notifyListeners();
    }
  }

  void pushToApprentissages(int value) {
    if (!apprentissages.contains(value)) {
      apprentissages.add(value);
      notifyListeners();
    }
  }
  void removeFromApprentissages(int value) {
    if (apprentissages.contains(value)) {
      apprentissages.remove(value);
      notifyListeners();
    }
  }

  void pushToAvantages(int value) {
    if (!avantages.contains(value)) {
      avantages.add(value);
      notifyListeners();
    }
  }
  void removeFromAvantages(int value) {
    if (avantages.contains(value)) {
      avantages.remove(value);
      notifyListeners();
    }
  }

  void pushToCarrieres(int value) {
    if (!carrieres.contains(value)) {
      carrieres.add(value);
      notifyListeners();
    }
  }
  void removeFromCarrieres(int value) {
    if (carrieres.contains(value)) {
      carrieres.remove(value);
      notifyListeners();
    }
  }

  void pushToCompetences(int value) {
    if (!competences.contains(value)) {
      competences.add(value);
      notifyListeners();
    }
  }
  void removeFromCompetences(int value) {
    if (competences.contains(value)) {
      competences.remove(value);
      notifyListeners();
    }
  }

  void pushToMissions(int value) {
    if (!missions.contains(value)) {
      missions.add(value);
      notifyListeners();
    }
  }
  void removeFromMissions(int value) {
    if (missions.contains(value)) {
      missions.remove(value);
      notifyListeners();
    }
  }

  void pushToPersonnalites(int value) {
    if (!personnalites.contains(value)) {
      personnalites.add(value);
      notifyListeners();
    }
  }
  void removeFromPersonnalites(int value) {
    if (personnalites.contains(value)) {
      personnalites.remove(value);
      notifyListeners();
    }
  }

  void pushToValeursEthiques(int value) {
    if (!valeursEthiques.contains(value)) {
      valeursEthiques.add(value);
      notifyListeners();
    }
  }
  void removeFromValeursEthiques(int value) {
    if (valeursEthiques.contains(value)) {
      valeursEthiques.remove(value);
      notifyListeners();
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "lastName": lastName,
      "companyName": companyName,
      "firstName": firstName,
      "dateNaissance": dateNaissance,
      "telephone": telephone,
      "email": email,
      "secteurActivite": secteurActivite,
      "companySize": companySize,
      "typePoste": typePoste,
      "typeContrat": typeContrat,
      "city": city,
      "location": location,
      "address": address,
      "siret": siret,
      "password": password,
      "cerise": cerise,
      "whyCerise": whyCerise,
      "apprentissages": apprentissages,
      "avantages": avantages,
      "carrieres": carrieres,
      "competences": competences,
      "missions": missions,
      "personnalites": personnalites,
      "valeursEthiques": valeursEthiques,
      "questionMystere": questionMystere,
    };
  }
}