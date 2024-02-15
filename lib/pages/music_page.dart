import 'package:djiguiba_music/component/entete_page.dart';
import 'package:djiguiba_music/component/my_drawer.dart';
import 'package:djiguiba_music/sous_pages/detailmusic.dart';
import 'package:djiguiba_music/sous_pages/music_page_detail.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:djiguiba_music/music_config/providers/audio_player_provider.dart';
import 'package:djiguiba_music/music_config/widgets/miniplayer.dart';
import 'package:device_info_plus/device_info_plus.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({Key? key});

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  final OnAudioQuery audioQuery = OnAudioQuery();
  late List<SongModel> _songs;

  @override
  void initState() {
    super.initState();
    _songs = [];
    requestPermission();
  }

  Future<void> requestPermission() async {
    final deviceInfo = await DeviceInfoPlugin().androidInfo;
    if (Theme.of(context).platform == TargetPlatform.android) {
      if (await Permission.audio.isGranted ||
          await Permission.storage.isGranted) {
        _fetchSongs();
      } else {
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

  Future<void> _fetchSongs() async {
    List<SongModel> songs = await audioQuery.querySongs();
    setState(() {
      _songs = songs;
    });
  }

  @override
  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioPlayerProvider>(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text('Music Page'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Toutes les chansons'),
              Tab(text: 'Dossier'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ListView.builder(
              itemCount: _songs.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      tileColor: audioProvider.isPlaying
                          ? audioProvider.currentPlayingIndex == index
                              ? Colors.white12
                              : null
                          : null,
                      onTap: () {
                        audioProvider.playPause(index, _songs);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MusicPlayerDetail(
                              song: _songs[
                                  index], // Passer la chanson sélectionnée à la page MusicPlayerDetail
                            ),
                          ),
                        );
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
                    ),
                    Divider(
                      color: Colors.white.withOpacity(0.07),
                      indent: 50,
                    ),
                  ],
                );
              },
            ),
            Center(
              child: Text('Favorites List &'),
            ),
          ],
        ),
        bottomNavigationBar: MiniPlayer(songs: _songs),
      ),
    );
  }
}
