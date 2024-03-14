import 'package:flutter/material.dart';

// Importation des configurations de thème pour le mode sombre et le mode clair :
import 'dark_mode.dart';
import 'light_mode.dart';

// Classe responsable de la gestion du thème de l'application :
class ThemeProvider extends ChangeNotifier {
  // Thème initial (mode clair) :
  ThemeData _themeData = darkMode;

  // Getter pour récupérer le thème actuel :
  ThemeData get themeData => _themeData;

  // Getter pour vérifier si le mode clair est activé :
  bool get islightMode => _themeData == lightMode;

  // Setter pour définir un nouveau thème et mettre à jour l'UI :
  set themeData(ThemeData themeData) {
    _themeData = themeData;

    // Mise à jour de l'UI en notifiant les écouteurs (widgets dépendants) :
    notifyListeners();
  }

  // Méthode pour basculer entre le mode clair et le mode sombre :
  void toggleTheme() {
    // Si le thème actuel est le mode clair, basculer vers le mode sombre, et vice versa :
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}

