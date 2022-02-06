import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tik_tok_ui/constant/data_json.dart';
import 'package:tik_tok_ui/pages/discover/video_player_page.dart';
import 'package:tik_tok_ui/widgets/tik_tok_icons.dart';
import 'package:video_player/video_player.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with TickerProviderStateMixin {
  List<VideoPlayerController> controllers = [];
  List videos = [];
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    videos = items;

    for (int i = 0; i < items.length; i++) {
      controllers.add(VideoPlayerController.asset(videos[i]['videoUrl'])
        ..initialize().then((value) {}));
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> pageImage = [
      "assets/image/pubg_mobile.jpg",
      "assets/image/football.jpg",
      "assets/image/tiger.jpg"
    ];
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(4),
              width: double.infinity,
              height: 55,
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Container(
                        color: const Color(0xFFE2E2E2),
                        child: const TextField(
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              alignLabelWithHint: true,
                              prefixIcon: Icon(TikTokIcons.search,
                                  size: 20, color: Colors.black),
                              fillColor: Colors.transparent,
                              filled: true,
                              hintText: "Search"),
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(4),
                    child: Icon(Icons.qr_code_scanner, size: 32),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  allowImplicitScrolling: true,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(
                      width: double.infinity,
                      height: 150,
                      decoration: const BoxDecoration(
                        color: Colors.yellow,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child:
                          Image.asset(pageImage[index], fit: BoxFit.fill),
                    );
                  },
                ),
              ),
            ),
            Container(
              height: 45,
              alignment: Alignment.centerLeft,
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  "Trending",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 220,
              // color: Colors.black,
              child: ListView.builder(
                itemCount: items.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VideoPlayerPage(
                              controller: controllers[index],
                              name: videos[index]['name'],
                              caption: videos[index]['caption'],
                              songName: videos[index]['songName'],
                              profileImg: videos[index]['profileImg'],
                              likes: videos[index]['likes'],
                              comments: videos[index]['comments'],
                              shares: videos[index]['shares'],
                              albumImg: videos[index]['albumImg'],
                              videUrl: videos[index]['videoUrl'],
                              index: index,
                            ),
                          ));
                    },
                    child: Container(
                      width: 140,
                      height: 240,
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.all(Radius.circular(100)),
                      // ),
                      margin: const EdgeInsets.all(1),
                      child: Stack(
                        children: [
                          VideoPlayer(controllers[index]),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(videos[index]["views"],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                    textAlign: TextAlign.end),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              height: 60,
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Ahmadjon Developer",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage("assets/image/image_profile.jpg"),
                            fit: BoxFit.cover,
                          )),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 220,
              // color: Colors.black,
              child: ListView.builder(
                itemCount: items.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoPlayerPage(
                            controller: controllers[index],
                            name: videos[index]['name'],
                            caption: videos[index]['caption'],
                            songName: videos[index]['songName'],
                            profileImg: videos[index]['profileImg'],
                            likes: videos[index]['likes'],
                            comments: videos[index]['comments'],
                            shares: videos[index]['shares'],
                            albumImg: videos[index]['albumImg'],
                            videUrl: videos[index]['videoUrl'],
                            index: index,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 140,
                      height: 220,
                      margin: const EdgeInsets.all(1),
                      child: Stack(
                        children: [
                          VideoPlayer(controllers[index]),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(videos[index]["views"],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                    textAlign: TextAlign.end),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
