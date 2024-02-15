import 'package:djiguiba_music/component/entete_page.dart';
import 'package:flutter/material.dart';
import '../component/my_drawer.dart';

class VideoPage extends StatelessWidget {
  const VideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: EnteteAppBar(), // Utilisez l'appBar personnalisée ici
      ),
      drawer: MyDrawer(),
      body: Center(
        child: Text(
          "Vidéos",
          style: TextStyle(fontSize: 50),
        ),
      ),
    );
  }
}
