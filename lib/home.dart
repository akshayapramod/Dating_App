import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/constant/string_values.dart';
import 'package:dating_app/favorites.dart';
import 'package:dating_app/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late PageController contrl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    contrl = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: contrl,
        children: [MySwipe(), FavoriteScreen(), ProfileScreen()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: (i) {
          _selectedIndex = i;
          contrl.jumpToPage(_selectedIndex);
          setState(() {});
        },
      ),
    );
  }
}

class MySwipe extends StatefulWidget {
  const MySwipe({super.key});

  @override
  State<MySwipe> createState() => _MySwipeState();
}

class _MySwipeState extends State<MySwipe> {
  final CardSwiperController myController = CardSwiperController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchUserData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            var data = snapshot.data!.docs;
            print(data.length.toString() + "+==========+");
            return Flexible(
              child: CardSwiper(
                  controller: myController,
                  isLoop: false,
                  cardBuilder: (context, index, horizontalOffsetPercentage,
                      verticalOffsetPercentage) {
                    return Stack(
                      children: [
                        // Background Image
                        Positioned.fill(
                          child: Image.network(
                            // 'https://cdn.pixabay.com/photo/2024/03/17/18/04/ai-generated-8639493_1280.jpg', // Replace with your image URL
                            data[index]["Image"],
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Center Buttons
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Decline Button
                              FloatingActionButton(
                                onPressed: () {
                                  myController.swipe(CardSwiperDirection.left);
                                },
                                backgroundColor: Colors.red,
                                child: Icon(Icons.cancel_outlined,
                                    color: Colors.white),
                              ),
                              SizedBox(width: 30),
                              // Accept Button
                              FloatingActionButton(
                                onPressed: () {
                                  var name = data[index]["Firstname"];
                                  var dob = data[index]["DOB"];
                                  var img = data[index]["Image"];
                                  var uid = data[index].id;
                                  addFav(name, dob, img, uid);
                                },
                                backgroundColor: Colors.green,
                                child: Icon(Icons.done, color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                    // Bottom Navigation Bar
                  },
                  cardsCount: data.length),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error Database'),
            );
          } else {
            return Center(
              child: Text('Empty Database'),
            );
          }
        } else {
          return Center(
            child: Text('Error Page'),
          );
        }
      },
    );
  }

  /// example........View user datas
  ///

  fetchUserData() async {
    try {
      var db = FirebaseFirestore.instance;
      var auth = FirebaseAuth.instance.currentUser!.email;

      print("====================== $auth");

      var result = await db
          .collection("userdetails")
          .where('Email', isNotEqualTo: auth)
          .get();
      print(result.toString() + "==================");
      return result;
    } catch (e) {
      throw Exception("Error");
    }
  }

  addFav(name, age, img, uid) async {
    FirebaseFirestore db = FirebaseFirestore.instance;

    Map<String, String> detail = {
      "Firstname": name,
      "DOB": age,
      "Image": img,
    };
    var loginedUid = FirebaseAuth.instance.currentUser!.uid;

    await db
        .collection("userdetails")
        .doc(loginedUid)
        .collection("favorite")
        .doc(uid)
        .set(detail)
        .then((v) {
      myController.swipe(CardSwiperDirection.right);
    });
  }
}
