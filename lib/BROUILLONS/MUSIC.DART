import 'package:device_info_plus/device_info_plus.dart';
import 'package:djiguiba_music/component/entete_page.dart';
import 'package:djiguiba_music/component/my_drawer.dart';
import 'package:djiguiba_music/music_config/providers/audio_player_provider.dart';
import 'package:djiguiba_music/music_config/widgets/miniplayer.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({Key? key});

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  final OnAudioQuery audioQuery = OnAudioQuery();
  List<SongModel> _songs = [];

  /*
    D'abord, récupérons les chansons

    Ajoutez les dépendances suivantes au fichier pubspec.yaml :
      permission_handler et device_info_plus

    Ajoutons les autorisations dans les fichiers androidmanifest.xml et info.plist

    Ajoutez la dépendance on_audio_query au fichier pubspec.yaml
   */

  // Méthode initState appelée lors de l'initialisation de l'état de la page
  @override
  void initState() {
    super.initState();
    requestPermission(); // Appel de la méthode pour demander les autorisations
  }

  // Méthode asynchrone pour demander les autorisations nécessaires
  Future<void> requestPermission() async {
    final deviceInfo = await DeviceInfoPlugin().androidInfo;
    // Vérification de la plateforme pour gérer les autorisations différemment sur Android et iOS
    if (Theme.of(context).platform == TargetPlatform.android) {
      // Vérification des autorisations audio et de stockage
      if (await Permission.audio.isGranted ||
          await Permission.storage.isGranted) {
        _fetchSongs(); // Si les autorisations sont accordées, récupérer les chansons
      } else {
        // Si les autorisations ne sont pas accordées, les demander
        if (deviceInfo.version.sdkInt > 32) {
          await Permission.audio.request();
        } else {
          await Permission.storage.request();
        }
      }
    } else if (Theme.of(context).platform == TargetPlatform.iOS) {
      if (await Permission.mediaLibrary.isGranted) {
        _fetchSongs();
      } else {
        await Permission.mediaLibrary.request();
      }
    }
  }

  // Méthode pour récupérer les chansons à partir de la bibliothèque audio
  Future<void> _fetchSongs() async {
    List<SongModel> songs = await audioQuery.querySongs();

    setState(() {
      _songs =
          songs; // Met à jour la liste des chansons avec les chansons récupérées
    });
  }

  // Méthode build pour construire l'interface utilisateur
  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioPlayerProvider>(context);

    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.background,
      // appBar: PreferredSize(
      //   preferredSize: const Size.fromHeight(kToolbarHeight),
      //   child: EnteteAppBar(), // Utilisez l'appBar personnalisée ici
      // ),
      // drawer: MyDrawer(), // Utilisez le drawer personnalisé ici
      body: ListView.builder(
        itemCount: _songs.length,
        itemBuilder: (context, index) {
          return ListTile(
            tileColor: audioProvider.isPlaying
                ? audioProvider.currentPlayingIndex == index
                    ? Colors.white12
                    : null
                : null,
            onTap: () {
              audioProvider.playPause(index, _songs);
            },
            leading: QueryArtworkWidget(
              id: _songs[index].id,
              type: ArtworkType.AUDIO,
              artworkWidth: 55,
              artworkHeight: 55,
              artworkBorder: BorderRadius.circular(8),
            ),
            title: Text(
              _songs[index].title ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              _songs[index].artist ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white38),
            ),
            trailing: audioProvider.isPlaying
                ? audioProvider.currentPlayingIndex == index
                    ? Icon(Icons.graphic_eq)
                    : null
                : null,
          );
          //   Divider(
          //   color: Colors.white.withOpacity(0.07),
          //   indent: 50,
          // ),
        },
      ),
      bottomNavigationBar: MiniPlayer(
        songs: _songs, // Transmet la liste des chansons au MiniPlayer
      ),
    );
  }
}
