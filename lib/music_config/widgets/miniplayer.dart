import 'package:audioplayers/audioplayers.dart'; 
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../providers/audio_player_provider.dart';

class MiniPlayer extends StatelessWidget {
  final List<SongModel> songs; // Liste des chansons à jouer

  const MiniPlayer(
      {super.key, required this.songs}); // Constructeur de la classe MiniPlayer

  // Fonctions de lecture audio
  // Cette classe semble nécessiter un fournisseur de AudioPlayerProvider pour fonctionner correctement

  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioPlayerProvider>(
        context); // Récupération du fournisseur de lecteur audio
    final currentPlayingIndex = audioProvider
        .currentPlayingIndex; // Récupération de l'index de la chanson en cours de lecture
    final currentSong = audioProvider
        .currentSong; // Récupération de la chanson en cours de lecture
    return currentPlayingIndex != null && currentSong != null
        ? BottomAppBar(
            // Barre d'application en bas de l'écran
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  SizedBox(
                    width: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentSong.title, // Affichage du titre de la chanson
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          currentSong.artist ??
                              '', // Affichage de l'artiste de la chanson, s'il existe
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.white38),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  if (currentPlayingIndex != null)
                    IconButton(
                      onPressed: () {
                        audioProvider.playPause(currentPlayingIndex,
                            songs); // Lecture ou pause de la chanson
                        if (audioProvider.isPlaying) {
                          AudioPlayer().pause(); // Pause de la lecture audio
                        } else {
                          AudioPlayer().resume(); // Reprise de la lecture audio
                        }
                      },
                      iconSize: 36,
                      icon: Icon(audioProvider.isPlaying
                          ? Icons
                              .pause // Affichage de l'icône de pause si la musique est en cours de lecture
                          : Icons
                              .play_arrow), // Affichage de l'icône de lecture si la musique est en pause
                    ),
                 
                 
                  if (currentPlayingIndex != null)
                    IconButton(
                      onPressed: () {
                        final nextIndex = (currentPlayingIndex + 1) %
                            songs
                                .length; // Index de la prochaine chanson à lire
                        audioProvider.playPause(nextIndex,
                            songs); // Lecture ou pause de la prochaine chanson
                      },
                      iconSize: 36,
                      icon: const Icon(Icons
                          .skip_next), // Icône pour passer à la chanson suivante
                    ),
                ],
              ),
            ),
          )
        : const SizedBox(); // Retourne une boîte vide s'il n'y a pas de chanson en cours de lecture
  }
}
