import 'package:flutter/material.dart';
import 'package:tik_tok_ui/constant/data_json.dart';
import 'package:tik_tok_ui/pages/discover/discover_page.dart';
import 'package:tik_tok_ui/pages/home/home_page.dart';
import 'package:tik_tok_ui/pages/message/message_page.dart';
import 'package:tik_tok_ui/pages/profile/profile_page.dart';
import 'package:tik_tok_ui/widgets/tik_tok_icons.dart';
import 'package:tik_tok_ui/widgets/upload_icon.dart';


import '../main.dart';
import '../theme/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController verticalTabController;
  late TabController horizontalTabController;
  int pageIndex = 0;


  @override
  void initState() {
    super.initState();
    for (int i = 0; i < items.length; i++) {
      isLiked.add(false);
    }
    verticalTabController = TabController(length: items.length, vsync: this);
    horizontalTabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    verticalTabController.dispose();
    horizontalTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: getFooter(),
      body: getBody(size),
    );
  }

  Widget getBody(size) {
    return IndexedStack(
      index: pageIndex,
      children: [
        TabBarView(
          controller: horizontalTabController,
          children: List.generate(2, (position) {
            setState(() {});
            return Stack(
              children: [
                RotatedBox(
                  quarterTurns: 1,
                  child: TabBarView(
                    controller: verticalTabController,
                    children: List.generate(items.length, (index) {
                      return RotatedBox(
                        quarterTurns: -1,
                        child: VideoPlayerItem(
                          index: index,
                          size: size,
                          name: items[index]['name'],
                          caption: items[index]['caption'],
                          albumImg: items[index]['albumImg'],
                          profileImg: items[index]['profileImg'],
                          comments: items[index]['comments'],
                          likes: items[index]['likes'],
                          shares: items[index]['shares'],
                          songName: items[index]['songName'],
                          videUrl: items[index]['videoUrl'], following: position,
                        ),
                      );
                    }),
                  ),
                ),
                SafeArea(
                    child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Center(child: headerHomePage(position)),
                  ],
                )),
              ],
            );
          }),
        ),
        const DiscoverPage(),
        const Center(
          child: Text(
            "Uploads",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: black,
            ),
          ),
        ),
        const MessagePage(),
        const ProfilePage(),
      ],
    );
  }

  Widget getFooter() {
    List bottomItems = [
      {"icon": TikTokIcons.home, "label": "Home", "isIcon": true},
      {"icon": TikTokIcons.search, "label": "Discover", "isIcon": true},
      {"icon": "", "label": "", "isIcon": false},
      {"icon": TikTokIcons.messages, "label": "Message", "isIcon": true},
      {"icon": TikTokIcons.profile, "label": "Profile", "isIcon": true},
    ];
    return Container(
      width: double.infinity,
      height: 80,
      decoration: const BoxDecoration(color: appBgColor),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(5, (index) {
            return bottomItems[index]["isIcon"]
                ? InkWell(
                    onTap: () {
                      selectedIndex(index);
                    },
                    child: Column(
                      children: <Widget>[
                        Icon(
                          bottomItems[index]['icon'],
                          color: white,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          bottomItems[index]['label'],
                          style: const TextStyle(
                            color: white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  )
                : InkWell(
                    onTap: () {
                      selectedIndex(index);
                    },
                    child: const UploadIcon(),
                  );
          }),
        ),
      ),
    );
  }

  Widget headerHomePage(index) {
    if (index == 1) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: (){
              setState(() {
                horizontalTabController.index = 1;
              });
            },
            child: Text(
              "Following",
              style: TextStyle(
                color: white.withOpacity(0.5),
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            "|",
            style: TextStyle(
              color: white.withOpacity(0.5),
              fontSize: 20,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          InkWell(
            onTap: (){
              setState(() {
                horizontalTabController.index = 0;
              });
            },
            child: Text(
              "For You",
              style: TextStyle(
                  color: white.withOpacity(1),
                  fontSize: 21,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Following",
            style: TextStyle(
                color: white.withOpacity(1),
                fontSize: 21,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            "|",
            style: TextStyle(
              color: white.withOpacity(0.5),
              fontSize: 20,
            ),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            "For You",
            style: TextStyle(
              color: white.withOpacity(0.5),
              fontSize: 20,
            ),
          ),
        ],
      );
    }
  }

  void selectedIndex(int index) {
    setState(() {
      pageIndex = index;

    });
  }
}
