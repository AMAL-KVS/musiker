import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_player/functions/functions.dart';
import 'package:music_player/widgets/playMyAudio.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../screenHome/widget/miniPlayer.dart';

class Favor extends StatefulWidget {
  const Favor({Key? key}) : super(key: key);

  @override
  State<Favor> createState() => _FavorState();
}

class _FavorState extends State<Favor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 24, 24, 23),
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 48, 47, 44),
          centerTitle: true,
          title: Text('F a v o u r i t e s'),
          toolbarHeight: 100,
          elevation: 0,
        ),
        body: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: ValueListenableBuilder(
              valueListenable: box.listenable(),
              builder: (context, Boxes, _) {
                final likedsongs = box.get("favorites");
                if (likedsongs == null || likedsongs.isEmpty) {
                  return const Center(
                    child: Text(
                      "No Favourites",
                      style: TextStyle(
                          fontFamily: "poppinz",
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        for (var element in likedsongs) {
                          PlayLikedsongs.add(
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
                        PlayMyAudio(allsongs: PlayLikedsongs, index: index)
                            .openAsset(index: index, audios: PlayLikedsongs);

                        showBottomSheet(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(45),
                            ),
                            backgroundColor: Colors.blueGrey.withOpacity(0.8),
                            context: context,
                            builder: (ctx) => MiniPlayer(
                                  index: index,
                                  audiosongs: PlayLikedsongs,
                                ));
                      },
                      child: Card(
                        color: Color.fromARGB(255, 48, 47, 44),
                        child: ListTile(
                          leading: QueryArtworkWidget(
                            id: likedsongs[index].id,
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                'assets/images/favori.png',
                              ),
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                likedsongs.removeAt(index);
                                box.put("favorites", likedsongs);
                              });
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: const Text(
                                  "Removed From Favourites",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                backgroundColor: Colors.orange,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                              ));
                            },
                            icon: const Icon(Icons.favorite, color: Colors.red),
                          ),
                          title: Text(
                            likedsongs[index].title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontFamily: "poppinz",
                                fontWeight: FontWeight.w700),
                          ),
                          subtitle: Text(
                            likedsongs[index].artist == '<unknown>'
                                ? 'unknown'
                                : likedsongs[index].artist,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontFamily: "poppinz",
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ),
                    ),
                    itemCount: likedsongs.length,
                  );
                }
              },
            )));
  }
}
