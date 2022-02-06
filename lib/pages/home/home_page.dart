import 'package:flutter/material.dart';
import 'package:tik_tok_ui/theme/colors.dart';
import 'package:tik_tok_ui/widgets/tik_tok_icons.dart';
import 'package:video_player/video_player.dart';

import '../../main.dart';

class VideoPlayerItem extends StatefulWidget {
  final String name;
  final String caption;
  final String songName;
  final String profileImg;
  final String likes;
  final String comments;
  final String shares;
  final String albumImg;
  final String videUrl;
  final Size size;
  final int index;
  final int following;

  const VideoPlayerItem(
      {Key? key,
      required this.name,
      required this.caption,
      required this.songName,
      required this.profileImg,
      required this.likes,
      required this.comments,
      required this.shares,
      required this.albumImg,
      required this.size,
      required this.videUrl,
      required this.index,
      required this.following})
      : super(key: key);

  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _controller;


  bool isPlaying = true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videUrl)
      ..initialize().then((value) {
        _controller.play();
        isPlaying = true;
      });

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
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
          if (_controller.value.isPlaying) {
            _controller.pause();
            isPlaying = false;
          } else if (!_controller.value.isPlaying) {
            _controller.play();
            isPlaying = true;
          }
        });
      },
      child: SizedBox(
          width: widget.size.width,
          height: widget.size.height,
          child: Stack(
            children: [
              Container(
                color: black,
                height: widget.size.height,
                width: widget.size.width,
                child: VideoPlayer(_controller),
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
                width: widget.size.width,
                height: widget.size.height,
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
                              leftPanel(widget.size),
                              Expanded(
                                  child: SizedBox(
                                height: widget.size.height,
                                child: Column(
                                  children: [
                                    Container(
                                      height: widget.size.height * 0.318,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          getProfile(widget.profileImg),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                if (isLiked[widget.index]) {
                                                  setState(() {
                                                    isLiked[widget.index] =
                                                        false;
                                                  });
                                                } else {
                                                  setState(() {
                                                    isLiked[widget.index] =
                                                        true;
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
                                          getMessage(TikTokIcons.chat_bubble,
                                              white, 35.0, widget.comments),
                                          getMessage(TikTokIcons.reply, white,
                                              25.0, widget.shares),
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
            child: widget.following == 1
                ? Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: primary),
                    child: const Center(
                      child: Icon(
                        Icons.add,
                        color: white,
                        size: 15,
                      ),
                    ),
                  )
                : Container(
                    // width: 20,
                    // height: 20,
                    // decoration: const BoxDecoration(
                    //     shape: BoxShape.circle, color: primary),
                    // child: const Center(
                    //   child: Icon(
                    //     Icons.done,
                    //     color: white,
                    //     size: 15,
                    //   ),
                    // ),
                  ),
          ),
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
