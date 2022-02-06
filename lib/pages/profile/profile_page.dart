import 'package:flutter/material.dart';
import 'package:tik_tok_ui/constant/data_json.dart';
import 'package:tik_tok_ui/pages/discover/video_player_page.dart';
import 'package:video_player/video_player.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<VideoPlayerController> controllerss = [];

  @override
  void initState() {
    for (int i = 0; i < items.length; i++) {
      controllerss.add(VideoPlayerController.asset(items[i]['videoUrl'])
        ..initialize().then((value) {
        }));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Image.asset(
                    "assets/image/adduser.png",
                    width: 30,
                    height: 30,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text(
                      "Ahmadjon Developer ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.arrow_drop_down),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Image.asset(
                    "assets/image/option.png",
                    width: 30,
                    height: 30,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 350,
            // color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white),
                      image: const DecorationImage(
                        image: AssetImage("assets/image/image_profile.jpg"),
                        fit: BoxFit.cover,
                      )),
                ),
                const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text(
                    "@AhmadjonDevv",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: const [
                          Text("100",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24)),
                          Text("Following", style: TextStyle(fontSize: 18)),
                        ],
                      ),
                      Column(
                        children: const [
                          Text("548K",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24)),
                          Text("Followers", style: TextStyle(fontSize: 18)),
                        ],
                      ),
                      Column(
                        children: const [
                          Text("1.0M",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24)),
                          Text("Likes", style: TextStyle(fontSize: 18)),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        // onPressed: () {},
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 12),
                          child: Text(
                            "Edit Profile",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(4)),
                          border: Border.all(width: 2, color: Colors.black12),
                        ),
                      ),
                    ),
                    Container(
                      // onPressed: () {},
                      child: const Padding(
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          Icons.bookmark_border_outlined,
                          size: 22,
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(4)),
                        border: Border.all(width: 2, color: Colors.black12),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                controllerss[index].pause();
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoPlayerPage(
                          controller: controllerss[index],
                          name: items[index]['name'],
                          caption:items[index]['caption'],
                          songName: items[index]['songName'],
                          profileImg: items[index]['profileImg'],
                          likes: items[index]['likes'],
                          comments: items[index]['comments'],
                          shares: items[index]['shares'],
                          albumImg: items[index]['albumImg'],
                          videUrl: items[index]['videoUrl'],
                          index: index,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 120,
                    height: 300,
                    margin: const EdgeInsets.all(1),
                    child: Stack(
                      children: [
                        VideoPlayer(controllerss[index]),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(items[index]["views"],
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
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,mainAxisExtent: 220),
            ),
          )
        ],
      ),
    );
  }
}
