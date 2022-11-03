import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:music_player/functions/functions.dart';
import 'package:music_player/model/Hive_Model.dart';
import 'package:music_player/widgets/Ezulizer.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ScreenPlay extends StatefulWidget {
  List<Audio> audiosongs = [];

  Audio? song;
  List<Audio> myaudiosong = [];

  int index;
  ScreenPlay({
    song,
    required this.myaudiosong,
    required this.index,
    Key? key,
  }) : super(key: key);
  // ScreenPlay({Key? key}) : super(key: key);

  @override
  State<ScreenPlay> createState() => _ScreenPlayState();
}

class _ScreenPlayState extends State<ScreenPlay> {
  List<dynamic>? likedsongs = [];

  int repeat = 0;

  bool prevvisible = true;
  bool nxtvisible = false;

  buttondesable() {
    if (widget.index == 0) {
      prevvisible = false;
    } else {
      prevvisible = true;
    }
    if (widget.index == audiosongs.length - 1) {
      nxtvisible = false;
    } else {
      nxtvisible = true;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    databaseSong = box.get('musics') as List<LoacalSongs>;
    assetsAudioPlayer.play();
    super.initState();
  }

  Widget build(BuildContext context) {
    Size DiviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(85, 73, 73, 77),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(0, 73, 73, 77),
        centerTitle: true,
        title: Text('N o w   P l a y i n g'),
        toolbarHeight: 100,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () async {},
            icon: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: assetsAudioPlayer.builderCurrent(
          builder: (context, Playing? playing) {
        final myAudio = find(widget.myaudiosong, playing!.audio.assetAudioPath);
        final currentSong = databaseSong.firstWhere(
            (element) => element.id.toString() == myAudio.metas.id.toString());
        if (playing.audio.assetAudioPath.isEmpty) {
          return Text('Loading...');
        } else {
          return Column(
            children: [
              // MusicWave(),
              // AvatarGlow(
              //   animate: true,
              //   endRadius: 100,
              //   glowColor: Colors.orange,
              //   child: CircleAvatar(
              //     radius: 100,
              //     child: QueryArtworkWidget(
              //       artworkHeight: 200,
              //       artworkWidth: 200,
              //       artworkFit: BoxFit.fill,
              //       artworkBorder: BorderRadius.circular(120),
              //       id: int.parse(myAudio.metas.id!),
              //       type: ArtworkType.AUDIO,
              //       nullArtworkWidget: ClipRRect(
              //         child: Image.asset(
              //           'assets/images/playlist.jpg',
              //         ),
              //       ),
              //     ),
              //   ),
              // ),

              AvatarGlow(
                duration: Duration(seconds: 1),
                glowColor: Colors.orange,
                endRadius: 190,
                animate: true,
                child: CircleAvatar(
                  backgroundColor: Colors.orange,
                  radius: 121,
                  child: QueryArtworkWidget(
                    artworkHeight: 240,
                    artworkWidth: 240,
                    artworkFit: BoxFit.fill,
                    artworkBorder: BorderRadius.circular(120),
                    id: int.parse(myAudio.metas.id!),
                    type: ArtworkType.AUDIO,
                    nullArtworkWidget: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        'assets/images/favori.png',
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(30.0),
                child: SizedBox(
                  height: DiviceSize.height * 0.02,
                  width: DiviceSize.width * 1,
                  child: Marquee(
                    velocity: 40,
                    blankSpace: 30,
                    pauseAfterRound: Duration(seconds: 5),
                    text: myAudio.metas.artist.toString() == '<unknown>'
                        ? 'unknown Artist'
                        : myAudio.metas.artist.toString(),
                    style: GoogleFonts.roboto(
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Container(
                    margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: assetsAudioPlayer.builderRealtimePlayingInfos(
                        builder: (context, infos) {
                      Duration currentposition = infos.currentPosition;
                      Duration totalduration = infos.duration;
                      return ProgressBar(
                          timeLabelTextStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 16),
                          thumbColor: Color.fromARGB(255, 255, 255, 255),
                          baseBarColor: Colors.grey,
                          progressBarColor: Colors.orange,
                          bufferedBarColor: Colors.red,
                          thumbRadius: 10,
                          barHeight: 4,
                          progress: currentposition,
                          total: totalduration,
                          onSeek: ((to) {
                            assetsAudioPlayer.seek(to);
                          }));
                    })),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 30),
                child: Container(
                  // color: Colors.white,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.shuffle,
                            size: 25,
                            color: Colors.white,
                          )),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Color.fromARGB(255, 63, 62, 61),
                        ),
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                assetsAudioPlayer.previous();
                              });
                            },
                            icon: Icon(
                              Icons.skip_previous,
                              size: 35,
                              color: Colors.white,
                            )),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.orange,
                        ),
                        child: PlayerBuilder.isPlaying(
                            player: assetsAudioPlayer,
                            builder: (context, isplaying) {
                              return GestureDetector(
                                onTap: () async {
                                  await assetsAudioPlayer.playOrPause();
                                },
                                child: Icon(
                                  isplaying ? Icons.pause : Icons.play_arrow,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        width: 20,
                      ),

                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Color.fromARGB(255, 63, 62, 61),
                        ),
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                assetsAudioPlayer.next();
                              });
                            },
                            icon: Icon(
                              Icons.skip_next_sharp,
                              color: Colors.white,
                              size: 35,
                            )),
                      ),

                      // nxtvisible
                      //     ? Visibility(
                      //         visible: nxtvisible,
                      // child: IconButton(
                      //     onPressed: () {
                      //       setState(() {
                      //         widget.index = widget.index + 1;
                      //         if (widget.index > 0) {
                      //           prevvisible = true;
                      //         }
                      //         assetsAudioPlayer.next();
                      //       });
                      //     },
                      //     icon: Icon(
                      //       Icons.skip_next_sharp,
                      //       color: Colors.white,
                      //     )))
                      //:
                      // SizedBox(
                      //   width: 20,
                      // ),
                      IconButton(
                          onPressed: () {
                            setState(() {
                              if (repeat % 2 == 0) {
                                assetsAudioPlayer.setLoopMode(LoopMode.single);
                                repeat++;
                              } else {
                                assetsAudioPlayer.setLoopMode(LoopMode.none);
                                repeat++;
                              }
                            });
                          },
                          icon: repeat % 2 == 0
                              ? Icon(
                                  Icons.repeat,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.repeat_one_on_sharp,
                                  color: Colors.white,
                                ))
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
