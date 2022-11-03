import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mini_music_visualizer/mini_music_visualizer.dart';

Widget MusicWave() {
  final double width = 10;
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      MiniMusicVisualizer(
        color: Colors.orange,
        width: width,
        height: 10,
      ),
      MiniMusicVisualizer(
        color: Colors.orange,
        width: width,
        height: 30,
      ),
      MiniMusicVisualizer(
        color: Colors.orange,
        width: width,
        height: 70,
      ),
      MiniMusicVisualizer(
        color: Colors.orange,
        width: width,
        height: 90,
      ),
    ],
  );
}
