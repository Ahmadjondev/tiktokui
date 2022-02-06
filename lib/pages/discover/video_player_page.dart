import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../../main.dart';
import '../../theme/colors.dart';
import '../../widgets/tik_tok_icons.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage(
      {Key? key,
      required this.controller,
      required this.name,
      required this.caption,
      required this.songName,
      required this.profileImg,
      required this.likes,
      required this.comments,
      required this.shares,
      required this.albumImg,
      required this.videUrl,
      required this.index})
      : super(key: key);
  final VideoPlayerController controller;
  final String name;
  final String caption;
  final String songName;
  final String profileImg;
  final String likes;
  final String comments;
  final String shares;
  final String albumImg;
  final String videUrl;
  final int index;

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  bool isPlaying = true;

  @override
  void initState() {
    super.initState();
    widget.controller.play();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        widget.controller.pause();
        return true;
      },
      child: Scaffold(
        body: InkWell(
          onDoubleTap: () {
            if (isLiked[widget.index]) {
              setState(() {
                isLiked[widget.index] = false;
              });
            } else {
              setState(() {
                isLiked[widget.index] = true;
              });
            }
          },
          onTap: () {
            setState(() {
              if (widget.controller.value.isPlaying) {
                widget.controller.pause();
                isPlaying = false;
              } else if (!widget.controller.value.isPlaying) {
                widget.controller.play();
                isPlaying = true;
              }
            });
          },
          child: SizedBox(
              width: size.width,
              height: size.height,
              child: Stack(
                children: [
                  Container(
                    color: black,
                    height: size.height,
                    width: size.width,
                    child: VideoPlayer(widget.controller),
                  ),
                  Center(
                      child: isPlaying
                          ? null
                          : Icon(
                              Icons.play_arrow_rounded,
                              color: const Color(0xFF0EB4B4).withOpacity(0.7),
                              size: 150,
                            )),
                  SizedBox(
                    width: size.width,
                    height: size.height,
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 25, right: 10, left: 10, bottom: 10),
                        child: Column(
                          children: [
                            // HeaderHomePage(),
                            Flexible(
                              child: Row(
                                children: [
                                  leftPanel(size),
                                  Expanded(
                                      child: SizedBox(
                                    height: size.height,
                                    child: Column(
                                      children: [
                                        Container(
                                          height: size.height * 0.34,
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: [
                                              getProfile(widget.profileImg),
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    if (isLiked[
                                                        widget.index]) {
                                                      setState(() {
                                                        isLiked[widget
                                                            .index] = false;
                                                      });
                                                    } else {
                                                      setState(() {
                                                        isLiked[widget
                                                            .index] = true;
                                                      });
                                                    }
                                                  });
                                                },
                                                child: isLiked[widget.index]
                                                    ? getMessage(
                                                        TikTokIcons.heart,
                                                        Colors.red,
                                                        35.0,
                                                        widget.likes)
                                                    : getMessage(
                                                        TikTokIcons.heart,
                                                        white,
                                                        35.0,
                                                        widget.likes),
                                              ),
                                              getMessage(
                                                  TikTokIcons.chat_bubble,
                                                  white,
                                                  35.0,
                                                  widget.comments),
                                              getMessage(TikTokIcons.reply,
                                                  white, 25.0, widget.shares),
                                              getAlbum(widget.albumImg),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget getAlbum(albumImg) {
    return SizedBox(
      width: 55,
      height: 55,
      child: Stack(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: black),
          ),
          Center(
            child: Container(
              width: 30,
              height: 30,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: AssetImage("assets/image/image_profile.jpg"),
                      fit: BoxFit.cover)),
            ),
          )
        ],
      ),
    );
  }

  Widget getProfile(profile) {
    return SizedBox(
      width: 55,
      height: 55,
      child: Stack(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white),
                image: const DecorationImage(
                  image: AssetImage("assets/image/image_profile.jpg"),
                  fit: BoxFit.cover,
                )),
          ),
          Positioned(
              bottom: 2,
              left: 30,
              child: Container(
                width: 20,
                height: 20,
                decoration:
                    const BoxDecoration(shape: BoxShape.circle, color: primary),
                child: const Center(
                  child: Icon(
                    Icons.add,
                    color: white,
                    size: 15,
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget getMessage(icon, color, size, count) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 35,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          count,
          style: const TextStyle(
            color: white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget leftPanel(size) {
    return SizedBox(
      height: size.height,
      width: size.width * 0.78,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            widget.name,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            widget.caption,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              const Icon(
                Icons.music_note,
                color: white,
                size: 15,
              ),
              Text(
                widget.songName,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
