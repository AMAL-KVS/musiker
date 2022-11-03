import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/functions/functions.dart';
import 'package:music_player/model/Hive_Model.dart';
import 'package:music_player/screens/ScreenFavor/screenFavor.dart';
import 'package:music_player/screens/ScreenSearch/Search.dart';
import 'package:music_player/screens/screen%20MostPlayed/screenMostPLay.dart';
import 'package:music_player/screens/screen%20Recen/screenRecent.dart';
import 'package:music_player/screens/screenHome/widget/drawer.dart';
import 'package:music_player/screens/screenHome/widget/miniPlayer.dart';
import 'package:music_player/widgets/playMyAudio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';
import '../ScreenPlaylist/playlist.dart';

List<dynamic> recentsomgsdy = [];
List<dynamic> recents = [];

class ScreenHome extends StatefulWidget {
  ScreenHome({Key? key, required this.audiosongs}) : super(key: key);
  List<Audio> audiosongs = [];

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  Icon myIcon = const Icon(Icons.search);
  List<dynamic>? likedsongs = [];
  Future refreshlist() async {
    setState(() {});
    // fetchingsongs();
    await Future.delayed(const Duration(seconds: 2));
  }

  @override
  void initState() {
    // TODO: implement initState
    databasesongs = box.get('musics');
    likedsongs = box.get("favorites");
    // requstPermission();
  }

  // void requstPermission() {
  //   Permission.storage.request();
  // }

  // PlaySong(String? uri) {
  //   try {
  //     _adudioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
  //     _adudioPlayer.play();
  //   } on Exception {
  //     log("Error Parsing");
  //   }
  // }

  final _audioQuery = new OnAudioQuery();
  final _adudioPlayer = new AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => ScreenSearch()));
                },
                icon: const Icon(Icons.search))
          ],
          toolbarHeight: 130,
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 36, 35, 34),
          title: Column(
            children: [
              Image.asset(
                'assets/images/logo-removebg-preview.png',
                width: 100,
                height: 100,
              ),
              const Text(
                'H o m e',
                style: TextStyle(
                  color: Color.fromARGB(255, 243, 243, 243),
                ),
              )
            ],
          ),
          elevation: 0,
        ),
        backgroundColor: const Color(090808),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            Container(
                width: 500,
                height: 251,
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(100)),
                    color: Color.fromARGB(255, 36, 35, 34)),
                child: Expanded(
                    child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    const SizedBox(
                      width: 40,
                    ),
                    InkWell(
                      child: Container(
                        width: 150,
                        height: 50,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Image.asset('assets/images/playlist.jpg'),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              'P l a y l i s t',
                              style:
                                  GoogleFonts.montserrat(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (ctx) => PlayList()));
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      child: Container(
                        width: 150,
                        height: 50,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Image.asset('assets/images/favori.png'),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              'F a v o u r i t e s',
                              style:
                                  GoogleFonts.montserrat(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (ctx) => Favor()));
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      child: Container(
                        height: 50,
                        width: 150,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Image.asset('assets/images/recent.png'),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              'R e c e n t',
                              style:
                                  GoogleFonts.montserrat(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => const ScreenRecent()));
                      },
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      child: Container(
                        height: 50,
                        width: 150,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 30,
                            ),
                            Image.asset('assets/images/most.jpg'),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              'M o s t   P l a y e d',
                              style:
                                  GoogleFonts.montserrat(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => ScreenMostPlay()));
                      },
                    ),
                  ],
                ))),
            const SizedBox(
              height: 80,
            ),
            StickyHeader(
              header: Container(
                color: Color.fromARGB(255, 0, 0, 0),
                height: 50,
                width: 500,
                child: Text(
                  'A L L   S O N G S',
                  style: GoogleFonts.arimo(
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                      fontSize: 15),
                ),
              ),
              content: Expanded(
                child: FutureBuilder<List<SongModel>>(
                    future: _audioQuery.querySongs(
                      sortType: null,
                      orderType: OrderType.ASC_OR_SMALLER,
                      uriType: UriType.EXTERNAL,
                      ignoreCase: true,
                    ),
                    builder: (context, item) {
                      if (item.data == null) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (item.data!.isEmpty) {
                        return const Text('No songs found');
                      }
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: item.data!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  color: Color.fromARGB(255, 46, 45, 45),
                                  child: ListTile(
                                    onTap: () {
                                      showBottomSheet(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          // elevation: 20,
                                          // backgroundColor: Colors.blueGrey.withOpacity(0.8),
                                          backgroundColor: Colors.blue,
                                          context: context,
                                          builder: (ctx) => MiniPlayer(
                                                index: index,
                                                audiosongs: audiosongs,
                                              ));

                                      PlayMyAudio(
                                        allsongs: widget.audiosongs,
                                        index: index,
                                      ).openAsset(
                                          index: index, audios: audiosongs);
                                      addrecent(index: index);
                                    },
                                    leading: QueryArtworkWidget(
                                      id: item.data![index].id,
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
                                        item.data![index].displayNameWOExt,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.montserrat(
                                            color: const Color.fromARGB(
                                                255, 255, 255, 255)),
                                      ),
                                    ),
                                    trailing: IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Dialog(
                                                child: Container(
                                                  height: 100,
                                                  child: Column(
                                                    children: [
                                                      likedsongs!
                                                              .where((element) =>
                                                                  element.id
                                                                      .toString() ==
                                                                  databasesongs![
                                                                          index]
                                                                      .id
                                                                      .toString())
                                                              .isEmpty
                                                          ? ListTile(
                                                              title: Text(
                                                                  'Add to Favor',
                                                                  style: GoogleFonts
                                                                      .actor()),
                                                              onTap: () async {
                                                                final songs = box
                                                                        .get(
                                                                            "musics")
                                                                    as List<
                                                                        LoacalSongs>;
                                                                final temp = songs.firstWhere((element) =>
                                                                    element.id
                                                                        .toString() ==
                                                                    widget
                                                                        .audiosongs[
                                                                            index]
                                                                        .metas
                                                                        .id
                                                                        .toString());
                                                                favorites =
                                                                    likedsongs!;
                                                                favorites
                                                                    .add(temp);
                                                                box.put(
                                                                    "favorites",
                                                                    favorites);
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                        SnackBar(
                                                                  content:
                                                                      const Text(
                                                                    "Added to Favourites",
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          "poppinz",
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                  backgroundColor:
                                                                      Colors
                                                                          .orange,
                                                                  behavior:
                                                                      SnackBarBehavior
                                                                          .floating,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                ));

                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                            )
                                                          : ListTile(
                                                              title: Text(
                                                                  'Remove From Fav'),
                                                              onTap: () async {
                                                                likedsongs?.removeWhere((elemet) =>
                                                                    elemet.id
                                                                        .toString() ==
                                                                    databasesongs![
                                                                            index]
                                                                        .id
                                                                        .toString());
                                                                await box.put(
                                                                    "favorites",
                                                                    likedsongs!);
                                                                setState(() {});
                                                                // ignore: use_build_context_synchronously
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                // ignore: use_build_context_synchronously
                                                                ScaffoldMessenger.of(
                                                                        context)
                                                                    .showSnackBar(
                                                                        SnackBar(
                                                                  content:
                                                                      const Text(
                                                                    "Remove from Favourites",
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          "poppinz",
                                                                      fontSize:
                                                                          15,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                  backgroundColor:
                                                                      const Color(
                                                                          0xffdd0021),
                                                                  behavior:
                                                                      SnackBarBehavior
                                                                          .floating,
                                                                  shape: RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10)),
                                                                ));
                                                              },
                                                            ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                      },
                                      icon: const Icon(
                                        Icons.more_vert,
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                      ),
                                    ),
                                  ),
                                ));
                          });
                    }),
              ),
            ),
          ],
        ),
        drawer: const Drawers());
  }

  addrecent({required int index}) {
    if (recents.length < 10) {
      final songs = box.get("musics") as List<LoacalSongs>;

      final temp = songs.firstWhere((element) =>
          element.id.toString() == audiosongs[index].metas.id.toString());
      recents = recentsomgsdy;
      recents.add(temp);
      box.put("recents", recents);
    } else {
      recents.removeAt(0);
      box.put("recents", recents);
    }
  }
}
