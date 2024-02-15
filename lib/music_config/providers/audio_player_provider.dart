import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AudioPlayerProvider with ChangeNotifier {
  int? _currentPlayingIndex; // Index de la chanson en cours de lecture
  List<SongModel> _songs =
      []; // Liste des chansons à lire, initialisée avec une liste vide
  bool _isPlaying = false; // Indique si la chanson est en cours de lecture

  int? get currentPlayingIndex =>
      _currentPlayingIndex; // Getter pour l'index de la chanson en cours de lecture
  SongModel? get currentSong => // Getter pour la chanson en cours de lecture
      _currentPlayingIndex != null ? _songs[_currentPlayingIndex!] : null;
  bool get isPlaying =>
      _isPlaying; // Getter pour indiquer si la chanson est en cours de lecture
  List<SongModel> get songs => _songs; // Getter pour la liste des chansons

  final player = AudioPlayer(); // Instance du lecteur audio

  AudioPlayerProvider() {
    player.onPlayerComplete.listen((event) {
      // Écouteur d'événements appelé lorsque la lecture d'une chanson est terminée
      playNextSong(); // Appelle la fonction pour jouer la prochaine chanson
      notifyListeners(); // Notifie les auditeurs du changement d'état
    });
  }

  void playNextSong() {
    if (_currentPlayingIndex != null &&
        _currentPlayingIndex! < _songs.length - 1) {
      // Vérifie s'il y a une chanson suivante dans la liste
      playPause(_currentPlayingIndex! + 1, _songs); // Joue la prochaine chanson
    } else {
      // Arrête la lecture s'il n'y a plus de chansons dans la liste
      stop();
    }
  }

  void stop() {
    player.stop(); // Arrête la lecture audio
    _isPlaying = false; // Met à jour l'état de lecture à "false"
    _currentPlayingIndex =
        null; // Réinitialise l'index de la chanson en cours de lecture
    notifyListeners(); // Notifie les auditeurs du changement d'état
  }

  // Fonction de lecture et de pause

  void playPause(int index, List<SongModel> songs) async {
    _songs = songs; // Met à jour la liste des chansons avant d'y accéder
    if (_currentPlayingIndex == index) {
      // Vérifie si la même chanson est en cours de lecture
      _isPlaying
          ? await player.pause()
          : await player.resume(); // Met en pause ou reprend la lecture
      _isPlaying = !_isPlaying; // Inverse l'état de lecture
    } else {
      // Met en pause la chanson actuellement en cours de lecture
      if (_currentPlayingIndex != null) {
        await player.stop(); // Arrête la lecture de la chanson actuelle
        _isPlaying = false; // Met à jour l'état de lecture à "false"
      }

      // Commence la lecture de la nouvelle chanson
      _currentPlayingIndex =
          index; // Met à jour l'index de la nouvelle chanson en cours de lecture
      await player.play(DeviceFileSource(
          _songs[index].data)); // Démarre la lecture de la nouvelle chanson
      _isPlaying = true; // Met à jour l'état de lecture à "true"
    }
    notifyListeners(); // Notifie les auditeurs du changement d'état
  }

// :::::::::::::::::::::::
  void playPreviousSong() {
    if (_currentPlayingIndex != null && _currentPlayingIndex! > 0) {
      // Vérifie s'il y a une chanson précédente dans la liste
      playPause(
          _currentPlayingIndex! - 1, _songs); // Joue la chanson précédente
    }
  }

  void pause() async {
    await player.pause(); // Met en pause la lecture audio
    _isPlaying = false; // Met à jour l'état de lecture à "false"
    notifyListeners(); // Notifie les auditeurs du changement d'état
  }
}
