import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/parametre_pages.dart';
import '../themes/theme_provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          // Logo
          DrawerHeader(
            child: Icon(
              Icons.music_note,
              size: 40,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
// :::::::::::::::
          Container(
            // Décoration du conteneur avec une couleur de fond et des coins arrondis :
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(12),
            ),
            // Marge et remplissage du conteneur :
            padding: const EdgeInsets.all(6),
            margin: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Libellé du mode (clair/sombre) avec style de texte en gras :
                Text(
                  "Changez la mode",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // Commutateur pour basculer entre le mode sombre  et le mode clair :
                CupertinoSwitch(
                  value: Provider.of<ThemeProvider>(context, listen: false)
                      .islightMode,
                  onChanged: (value) =>
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleTheme(),
                ),
              ],
            ),
          ),

          // Videos title
          Padding(
            padding: const EdgeInsets.only(top: 25.0, left: 25.0),
            child: ListTile(
              title: const Text("Vidéos"),
              leading: const Icon(Icons.video_call),
              onTap: () {
                Navigator.pop(context);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => VideoPage(),
                //   ),
                // );
              },
            ),
          ),

// Music title
          Padding(
            padding: const EdgeInsets.only(top: 0, left: 25.0),
            child: ListTile(
              title: const Text("Music"),
              leading: const Icon(Icons.music_note),
              onTap: () {
                Navigator.pop(context);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => MusicPage(),
                //   ),
                // );
              },
            ),
          ),
          // Parametre
          Padding(
            padding: const EdgeInsets.only(top: 0, left: 25.0),
            child: ListTile(
              title: const Text("Pamètres"),
              leading: const Icon(Icons.settings),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ParametrePages(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
