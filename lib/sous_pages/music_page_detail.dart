import 'package:djiguiba_music/music_config/providers/audio_player_provider.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

class MusicPlayerDetail extends StatefulWidget {
  final SongModel song; // Ajouter une propriété pour la chanson sélectionnée
  MusicPlayerDetail({required this.song});

  @override
  State<MusicPlayerDetail> createState() => _MusicPlayerDetailState();
}

class _MusicPlayerDetailState extends State<MusicPlayerDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.song.title ??
              '', // Utiliser le titre de la chanson sélectionnée
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        actions: [Icon(Icons.panorama_horizontal)],
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: 80)),
          Center(
            child: PulseAnimationWidget(
              child: ClipOval(
                child: Image.asset(
                  "assets/images/${widget.song.id}", // Utiliser l'image de la chanson sélectionnée
                  width: 250,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // ::::::::::::
          SizedBox(
            height: 150,
          ),
          Container(
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('1:32'), // Minute de début de la musique
                Expanded(
                  child: Slider(
                    value:
                        0.5, // Valeur de progression de la musique (modifiable)
                    onChanged: (double value) {},
                  ),
                ),
                Text('3:48'), // Minute de fin de la musique
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.skip_previous,
                    size: 35,
                  ),
                  onPressed: () {
                    final audioProvider = Provider.of<AudioPlayerProvider>(
                      context,
                      listen: false,
                    );
                    audioProvider
                        .playPreviousSong(); // Passer à la chanson précédente
                  },
                ),
                IconButton(
                  icon: Icon(Icons.pause_circle, size: 70),
                  onPressed: () {
                    final audioProvider = Provider.of<AudioPlayerProvider>(
                      context,
                      listen: false,
                    );
                    audioProvider.pause(); // Mettre en pause la lecture audio
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.skip_next,
                    size: 35,
                  ),
                  onPressed: () {
                    final audioProvider = Provider.of<AudioPlayerProvider>(
                      context,
                      listen: false,
                    );
                    audioProvider
                        .playNextSong(); // Passer à la chanson suivante
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Animation Image Music::::::::::::::::::
class PulseAnimationWidget extends StatefulWidget {
  final Widget child;

  PulseAnimationWidget({required this.child});

  @override
  _PulseAnimationWidgetState createState() => _PulseAnimationWidgetState();
}

class _PulseAnimationWidgetState extends State<PulseAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _animation = Tween(begin: 1.0, end: 1.2).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
