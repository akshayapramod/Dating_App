import 'package:dating_app/constant/string_values.dart';
import 'package:dating_app/favorites.dart';
import 'package:dating_app/profile.dart';
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

class MySwipe extends StatelessWidget {
  const MySwipe({super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: CardSwiper(
            cardBuilder: (context, index, horizontalOffsetPercentage,
                verticalOffsetPercentage) {
              return Stack(
                children: [
                  // Background Image
                  Positioned.fill(
                    child: Image.network(
                      // 'https://cdn.pixabay.com/photo/2024/03/17/18/04/ai-generated-8639493_1280.jpg', // Replace with your image URL
                      dummyData[index]["Image"],
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
                          onPressed: () {},
                          backgroundColor: Colors.red,
                          child:
                              Icon(Icons.cancel_outlined, color: Colors.white),
                        ),
                        SizedBox(width: 30),
                        // Accept Button
                        FloatingActionButton(
                          onPressed: () {},
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
            cardsCount: dummyData.length));
  }
}
