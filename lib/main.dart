import 'package:flutter/material.dart';
import 'package:tik_tok_ui/pages/main_page.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
  Wakelock.enable();
}
final List<bool> isLiked = [];
