import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dating_app/constant/string_values.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Favorites',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.pinkAccent,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFF8F8F8),
      // body: ListView.builder(
      //   padding: const EdgeInsets.all(16),
      //   itemCount: dummyData.length,
      //   itemBuilder: (context, index) {
      //     return Card(
      //       elevation: 4,
      //       margin: const EdgeInsets.symmetric(vertical: 10),
      //       shape:
      //           RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      //       child: ListTile(
      //         contentPadding: EdgeInsets.all(12),
      //         leading: CircleAvatar(
      //           radius: 30,
      //           backgroundImage: NetworkImage(dummyData[index]['Image']),
      //         ),
      //         title: Text(
      //           dummyData[index]["Name"],
      //           style: const TextStyle(
      //             fontWeight: FontWeight.bold,
      //             fontSize: 18,
      //           ),
      //         ),
      //         subtitle: Text(
      //           dummyData[index]["Age"],
      //           style: const TextStyle(
      //             fontSize: 14,
      //             color: Colors.grey,
      //           ),
      //         ),
      //         trailing: const Icon(
      //           Icons.favorite,
      //           color: Colors.pinkAccent,
      //         ),
      //       ),
      //     );
      //   },
      // ),

      body: FutureBuilder(
        future: fetchFav(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          //// future function nte akath ulla recent interaction -sanpshot
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            var datas = snapshot.data!.docs;
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: datas.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(12),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(datas[index]['Image']),
                    ),
                    title: Text(
                      datas[index]["Firstname"],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      datas[index]["DOB"],
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        var did = datas[index].id;
                        deletefav(did);
                        setState(() {});
                      },
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.pinkAccent,
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(
              child: Text("Empty.."),
            );
          }
        },
      ),
    );
  }

  fetchFav() async {
    try {
      var db = FirebaseFirestore.instance;
      var auth = FirebaseAuth.instance;

      var uid = auth.currentUser!.uid;

      //doc - to get single document data in a collection
      var fetchresult = await db
          .collection("userdetails")
          .doc(uid)
          .collection("favorite")
          .get();
      return fetchresult;
    } catch (e) {
      Exception("Error");
    }
  }

  deletefav(docid) async {
    try {
      var dlt = FirebaseFirestore.instance;
      var loginedUid = FirebaseAuth.instance.currentUser!.uid;
      await dlt
          .collection("userdetails")
          .doc(loginedUid)
          .collection("favorite")
          .doc(docid)
          .delete();
    } catch (e) {}
  }
}
