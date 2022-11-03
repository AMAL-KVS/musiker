import 'dart:ffi';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/functions/functions.dart';
import 'package:music_player/model/Hive_Model.dart';
import 'package:music_player/screens/screenHome/widget/miniPlayer.dart';
import 'package:music_player/widgets/playMyAudio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ScreenSearch extends StatefulWidget {
  const ScreenSearch({Key? key}) : super(key: key);

  @override
  State<ScreenSearch> createState() => _ScreenSearchState();
}

class _ScreenSearchState extends State<ScreenSearch> {
  List<LoacalSongs> songsdatabase = [];
  List<Audio> songsall = [];
  String search = '';

  getSongs() {
    songsdatabase = box.get("musics") as List<LoacalSongs>;
    for (var element in songsdatabase) {
      songsall.add(
        Audio.file(
          element.uri.toString(),
          metas: Metas(
              title: element.title,
              id: element.id.toString(),
              artist: element.artist),
        ),
      );
    }
  }

  Future<String> debounce() async {
    return "Waited 1";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSongs();
  }

  @override
  Widget build(BuildContext context) {
    List<Audio> searchresult = songsall
        .where((element) =>
            element.metas.title!.toLowerCase().startsWith(search.toLowerCase()))
        .toList();
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                    fillColor: Color.fromARGB(255, 36, 35, 34),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xff2b2b29), width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color(0xff2b2b29), width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    prefixIcon: const Icon(Icons.search, color: Colors.white),
                    suffixIcon: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.close,
                          color: Colors.orange[500],
                        )),
                    hintText: 'F i n d   Y o u r   S o n g',
                    filled: true,
                    hintStyle: const TextStyle(color: Colors.white)),
                onChanged: (value) {
                  setState(() {
                    search = value;
                  });
                }),
          ),
          search.isNotEmpty
              ? searchresult.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                      itemCount: searchresult.length,
                      itemBuilder: (context, index) {
                        return FutureBuilder(
                          future: debounce(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return GestureDetector(
                                onTap: () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  showBottomSheet(
                                      context: context,
                                      builder: (ctx) => MiniPlayer(
                                          index: index,
                                          audiosongs: searchresult));
                                  PlayMyAudio(
                                      allsongs: searchresult, index: index);
                                },
                                child: ListTile(
                                  leading: QueryArtworkWidget(
                                    id: int.parse(
                                        searchresult[index].metas.id!),
                                    type: ArtworkType.AUDIO,
                                    nullArtworkWidget: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.asset(
                                        'assets/images/favori.png',
                                      ),
                                    ),
                                  ),
                                  title: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Text(
                                      searchresult[index].metas.title!,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.montserrat(
                                          color: const Color.fromARGB(
                                              255, 255, 255, 255)),
                                    ),
                                  ),
                                ),
                              );
                            }
                            return Container();
                          },
                        );
                      },
                    ))
                  : Padding(
                      padding: const EdgeInsets.all(100.0),
                      child: const Text(
                        "No Result Found",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
              : const SizedBox(),
        ]),
      ),
    );
  }
}
