import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/functions/BoxShadow.dart';
import 'package:music_player/functions/functions.dart';
import 'package:music_player/screens/screenHome/widget/miniPlayer.dart';
import 'package:music_player/widgets/playMyAudio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ScreenRecent extends StatefulWidget {
  const ScreenRecent({Key? key}) : super(key: key);

  @override
  State<ScreenRecent> createState() => _ScreenRecentState();
}

class _ScreenRecentState extends State<ScreenRecent> {
  List<Audio> recentAudio = [];

  get index => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 48, 47, 44),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 48, 47, 44),
        title: Text('R e c e n t s'),
        toolbarHeight: 100,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: ValueListenableBuilder(
            valueListenable: box.listenable(),
            builder: (context, Boxes, _) {
              final recentsongs = box.get("recents");
              if (recentsongs == recentsongs?.isEmpty) {
                return Center(child: Text('No recents'));
              } else {
                return ListView.builder(
                    itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            for (var element in recentsongs!) {
                              recentAudio.add(
                                Audio.file(
                                  element.uri!,
                                  metas: Metas(
                                    title: element.title,
                                    id: element.id.toString(),
                                    artist: element.artist,
                                  ),
                                ),
                              );
                            }
                            PlayMyAudio(
                              allsongs: recentAudio,
                              index: index,
                            ).openAsset(index: index, audios: recentAudio);

                            showBottomSheet(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(45),
                                ),
                                backgroundColor:
                                    Colors.blueGrey.withOpacity(0.8),
                                context: context,
                                builder: (ctx) => MiniPlayer(
                                      index: index,
                                      audiosongs: recentAudio,
                                    ));
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 20.0),
                            child: Card(
                              child: ListTile(
                                tileColor: Color.fromARGB(255, 22, 22, 22),
                                leading: QueryArtworkWidget(
                                    id: recentsongs![index].id,
                                    type: ArtworkType.AUDIO,
                                    nullArtworkWidget: ClipOval(
                                      child: Image.asset(
                                        'assets/images/logo-removebg-preview.png',
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                                trailing: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      recentsongs.removeAt(index);
                                      box.put("recents", recentsongs);
                                    });
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      backgroundColor: Colors.orange,
                                      content: const Text(
                                        "Removed From Recents",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ));
                                  },
                                  icon: const Icon(
                                    Icons.close_sharp,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                                title: Text(
                                  recentsongs[index].title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                                subtitle: Text(
                                  recentsongs[index].artist == '<unknown>'
                                      ? 'unknown Artist'
                                      : recentsongs[index].artist,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    itemCount: recentsongs!.length);
              }
            }),
      ),
    );
  }
}
