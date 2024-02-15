import 'package:djiguiba_music/music_config/providers/audio_player_provider.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';



class MusicPlayerDetail1 extends StatelessWidget {
  final SongModel song;

  const MusicPlayerDetail1({Key? key, required this.song}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioPlayerProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(song.title ?? ''),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Image de la chanson
          Image.asset(
            'assets/images/music_placeholder.png', // Remplacez ceci par le chemin de l'image de votre chanson
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),

          // Titre de la chanson
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              song.title ?? '',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Artiste de la chanson
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              song.artist ?? '',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ),

          // Icônes de contrôle (pause, précédent, suivant, etc.)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  // Mettez ici la logique pour le bouton pause
                  audioProvider.playPause(audioProvider.currentPlayingIndex!, audioProvider.songs);
                },
                icon: Icon(audioProvider.isPlaying ? Icons.pause : Icons.play_arrow), // Utilisation de l'icône pause ou play en fonction de l'état de lecture
              ),
              IconButton(
                onPressed: () {
                  // Mettez ici la logique pour le bouton précédent
                  audioProvider.playPause(audioProvider.currentPlayingIndex! - 1, audioProvider.songs);
                },
                icon: Icon(Icons.skip_previous),
              ),
              IconButton(
                onPressed: () {
                  // Mettez ici la logique pour le bouton suivant
                  audioProvider.playPause(audioProvider.currentPlayingIndex! + 1, audioProvider.songs);
                },
                icon: Icon(Icons.skip_next),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
