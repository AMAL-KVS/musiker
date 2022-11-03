import 'dart:math';

import 'package:flutter/material.dart';
import 'package:music_player/functions/BoxShadow.dart';

class PlayList extends StatefulWidget {
  const PlayList({Key? key}) : super(key: key);

  @override
  State<PlayList> createState() => _PlayListState();
}

class _PlayListState extends State<PlayList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          title: Text('p l a y l i s t'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: dbox(
                Child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.add),
                  iconSize: 30,
                ),
              ),
            )
          ],
          toolbarHeight: 100,
          backgroundColor: Color.fromARGB(255, 48, 47, 44),
          elevation: 0,
        ),
        body: Column());
  }
}
