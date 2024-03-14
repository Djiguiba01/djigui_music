import 'package:djiguiba_music/consts/colors.dart';
import 'package:djiguiba_music/consts/text_style.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../controllers/player_controller.dart';

class MusicPageDetail extends StatelessWidget {
  const MusicPageDetail({super.key, required this.songList});

  final List<SongModel> songList;

  @override
  Widget build(BuildContext context) {
    var playerController = Get.put(PlayerController());
    var currentSongIndex = playerController.playIndex;

    if (kDebugMode) {
      print('index from controller ${songList[currentSongIndex.value].id}');
    }
    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back,
                color: whiteColor,
              )),
          title: Obx(
            () => Text(
            songList[currentSongIndex.value].displayNameWOExt,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: monTextStyle(
              color: whiteColor,
            ),
          ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Obx(
            () => Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                Expanded(
                  child: Container(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: QueryArtworkWidget(
                      id: songList[currentSongIndex.value].id,
                      type: ArtworkType.AUDIO,
                      artworkWidth: double.infinity,
                      artworkHeight: double.infinity,
                      nullArtworkWidget: Icon(
                        Icons.music_note,
                        size: 48,
                        color: whiteColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 220,
                ),
                Expanded(
                  child: Container(
                    //width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    // decoration: BoxDecoration(
                    //   borderRadius:
                    //       BorderRadius.vertical(top: Radius.circular(16)),
                    //   color: whiteColor,
                    // ),
                    child: Column(
                      children: [
                        // Text(
                        //   songList[currentSongIndex.value].displayNameWOExt,
                        //   textAlign: TextAlign.center,
                        //   overflow: TextOverflow.ellipsis,
                        //   maxLines: 1,
                        //   style: monTextStyle(
                        //       size: 24, color: bgDarkColor, family: bold),
                        // ),
                        // SizedBox(
                        //   height: 12,
                        // ),
                        // Text(
                        //   songList[playerController.playIndex.value].artist!,
                        //   textAlign: TextAlign.center,
                        //   overflow: TextOverflow.ellipsis,
                        //   maxLines: 2,
                        //   style: monTextStyle(
                        //     size: 18,
                        //     color: bgDarkColor,
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 12,
                        // ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Obx(
                            () => Row(
                              children: [
                                Text(
                                  playerController.position.value,
                                  style: monTextStyle(color: whiteColor),
                                ),
                                Expanded(
                                    child: Slider(
                                        activeColor: sliderColor,
                                        inactiveColor: bgDarkColor,
                                        min: Duration(seconds: 0)
                                            .inSeconds
                                            .toDouble(),
                                        max: playerController
                                            .durationInDouble.value,
                                        value: playerController
                                            .positionToDouble.value,
                                        onChanged: (newValue) {
                                          playerController
                                              .changeDurationToString(
                                                  newValue.toInt());
                                          newValue = newValue;
                                        })),
                                Text(
                                  playerController.duration.value,
                                  style: monTextStyle(color: whiteColor),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () {
                                if (currentSongIndex.value == 0) {
                                  currentSongIndex.value = songList.length - 1;
                                  playerController.playSong(
                                      songList[currentSongIndex.value].uri,
                                      currentSongIndex.value);
                                } else {
                                  --currentSongIndex.value;
                                  playerController.playSong(
                                      songList[currentSongIndex.value].uri,
                                      currentSongIndex.value);
                                }
                              },
                              icon: Icon(
                                Icons.skip_previous,
                                size: 40,
                              ),
                            ),
                            Transform.scale(
                                scale: 2,
                                child: Obx(
                                  () => CircleAvatar(
                                      backgroundColor: bgColor,
                                      child: IconButton(
                                        onPressed: () {
                                          if (playerController
                                              .isPlaying.value) {
                                            playerController.audiPlayer.pause();
                                            playerController.isPlaying.value =
                                                false;
                                          } else {
                                            playerController.audiPlayer.play();
                                            playerController.isPlaying.value =
                                                true;
                                          }
                                        },
                                        icon: Icon(
                                          playerController.isPlaying.value
                                              ? Icons.pause
                                              : Icons.play_arrow,
                                          color: whiteColor,
                                        ),
                                      )),
                                )),
                            IconButton(
                              onPressed: () {
                                if (currentSongIndex.value ==
                                    songList.length - 1) {
                                  currentSongIndex.value = 0;
                                  playerController.playSong(
                                      songList[currentSongIndex.value].uri,
                                      currentSongIndex.value);
                                } else {
                                  ++currentSongIndex.value;
                                  playerController.playSong(
                                      songList[currentSongIndex.value].uri,
                                      currentSongIndex.value);
                                }
                              },
                              icon: Icon(
                                Icons.skip_next,
                                size: 40,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
