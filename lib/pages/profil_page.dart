import 'package:djiguiba_music/component/entete_page.dart';
import 'package:flutter/material.dart';
import '../component/my_drawer.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: EnteteAppBar(), 
      ),
      drawer: MyDrawer(),
      body: Center(
        child: Text(
          "Profil",
          style: TextStyle(fontSize: 50),
        ),
      ),
    );
  }
}
