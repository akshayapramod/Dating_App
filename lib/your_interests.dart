import 'package:dating_app/login_screen.dart';
import 'package:flutter/material.dart';

class InterestScreen extends StatefulWidget {
  const InterestScreen({super.key});

  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  final List<String> choices = [
    'Movies',
    'Cooking',
    'Design',
    'Gambling',
    'Video Games',
    'Book Nerd',
    'Booting',
    'Travel',
    'Athlete',
    'Technology',
    'Shopping',
    'Swimming',
    'Videography',
    'Music Enthusiast',
    'Arts',
    'Dancing'
  ];

  List<String> selectedValues = [];

  void setSelectedValues(String value) {
    setState(() {
      if (selectedValues.contains(value)) {
        selectedValues.remove(value);
      } else {
        selectedValues.add(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Custom AppBar with Shadow and Underline
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Text(
                  "Apes",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          // Underline effect
          Container(
            height: 2,
            width: double.infinity,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 15),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Create your \n account',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Select a few of your interests',
              style: TextStyle(fontWeight: FontWeight.w300, fontSize: 20),
            ),
          ),
          const SizedBox(height: 30),

          // Multi-Select Chips (Grid Layout with 2 items per row)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GridView.builder(
                itemCount: choices.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 chips per row
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3, // Controls chip height
                ),
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: double.infinity,
                    height: 50, // Ensure fixed height
                    child: ElevatedButton(
                      onPressed: () => setSelectedValues(choices[index]),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedValues.contains(choices[index])
                            ? Colors.red
                            : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: selectedValues.contains(choices[index])
                                ? Colors.red
                                : Colors.grey,
                          ),
                        ),
                      ),
                      child: Text(
                        choices[index],
                        style: TextStyle(
                          color: selectedValues.contains(choices[index])
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Continue Button at the Bottom
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: SizedBox(
              width: double.infinity,
              height: 50, // Same height as choice buttons
              child: ElevatedButton(
                onPressed: selectedValues.isNotEmpty
                    ? () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      } // Navigate to next screen
                    : null, // Disable if no selection
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  disabledBackgroundColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  "Continue",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
