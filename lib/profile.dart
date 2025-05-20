// ignore_for_file: empty_catches

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  logout(BuildContext context) async {
    var logauth = FirebaseAuth.instance;
    await logauth.signOut().then(
      (value) {
        Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) {
            return LoginScreen();
          },
        ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                logout(context);
              },
              icon: Icon(Icons.logout))
        ],
        title: const Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 163, 146, 146),
        elevation: 8,
        shadowColor: Colors.grey.withOpacity(0.5),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(12), // Rounded bottom corners
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.grey[300]!,
                Colors.grey[300]!,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
        ),
      ),
      body: FutureBuilder(
        future: profileData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(data["Image"].toString()),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    data["Firstname"].toString() +
                        " " +
                        data["Lastname"].toString(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    data["Email"].toString(),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * .8,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {},
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.wifi_tethering,
                              color: Colors.white,
                            ),
                            Text(
                              "Upgrade your Profile",
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox()
                          ],
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Biography',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  const Text(
                      'Commodo consectetur minim elit sunt aliquip laboris dolore adipisicing.'),
                  Row(
                    children: [
                      const Text(
                        'Gallery',
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'View All',
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w900),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    height: 500,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              mainAxisSpacing: 15,
                              crossAxisSpacing: 15),
                      itemBuilder: (context, index) {
                        return Image.network(
                          "https://cdn.pixabay.com/photo/2023/02/17/16/25/man-7796384_1280.jpg",
                          fit: BoxFit.cover,
                        );
                      },
                      itemCount: 10,
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  profileData() async {
    try {
      var db = FirebaseFirestore.instance;
      var profileAuth = FirebaseAuth.instance;
      var uid = profileAuth.currentUser!.uid;

      var prof = await db.collection("userdetails").doc(uid).get();

      return prof;
    } catch (e) {
      throw Exception("Error");
    }
  }
}
