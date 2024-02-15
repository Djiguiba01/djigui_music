// Importation des bibliothèques Flutter et des packages nécessaires :
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Importation du gestionnaire de thème personnalisé (ThemeProvider) :
import '../themes/theme_provider.dart';

// Widget définissant la page des paramètres :
class ParametrePages extends StatelessWidget {
  const ParametrePages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text("Paramètre"),
      ),
      body:
       Container(
        // Décoration du conteneur avec une couleur de fond et des coins arrondis :
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        // Marge et remplissage du conteneur :
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(25),
        child: 
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Libellé du mode (clair/sombre) avec style de texte en gras :
            Text(
              "Mode",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),

            // Commutateur pour basculer entre le mode sombre  et le mode clair :
            CupertinoSwitch(
              value:
                  Provider.of<ThemeProvider>(context, listen: false).islightMode,
              onChanged: (value) =>
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme(),
            ),
          ],
        ),
      
      
      ),
    
    
    );
  }
}
