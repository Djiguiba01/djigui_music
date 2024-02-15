import 'package:djiguiba_music/music_config/providers/audio_player_provider.dart';
import 'package:djiguiba_music/component/bottom_pied_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Music',
      theme: ThemeData.dark(),
      home: ChangeNotifierProvider(
        create: (context) => AudioPlayerProvider(),
        child: BottomPiedPage(),
      ),
    );
  }
}






// // import 'dart:js';
// import 'package:djiguiba_music/Nouveau%20dossier/providers/audio_player_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:djiguiba_music/pages/bienvenue_page.dart';
// import 'package:djiguiba_music/themes/theme_provider.dart';
// import 'package:provider/provider.dart';

// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => ThemeProvider(),
//       child: const MyApp(),
//     ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // title: 'Flutter Demo',
//       debugShowCheckedModeBanner: false,
//       theme: Provider.of<ThemeProvider>(context).themeData,
//       // home: WelcomePage(),
//       home: ChangeNotifierProvider(
//         create: (context) => AudioPlayerProvider(),
//         child: WelcomePage(),
//       ),
//     );
//   }
// }


