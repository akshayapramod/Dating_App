import 'package:flutter/material.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.network(
              'https://cdn.pixabay.com/photo/2024/03/17/18/04/ai-generated-8639493_1280.jpg', // Replace with your image URL
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
                  child: Icon(Icons.cancel_outlined, color: Colors.white),
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
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items:const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
