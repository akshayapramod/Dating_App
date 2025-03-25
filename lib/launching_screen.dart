import 'package:carousel_slider/carousel_slider.dart';
import 'package:dating_app/constant/string_values.dart';
import 'package:dating_app/your_interests.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentIndex = 0;
  final CarouselSliderController myCarousel = CarouselSliderController();
  nextPage() {
    _currentIndex = _currentIndex + 1;
    if (_currentIndex < carouselItems.length) {
      myCarousel.animateToPage(_currentIndex);
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InterestScreen(),
          ));
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ClipRRect(
            //   borderRadius: BorderRadius.circular(20),
            //   child: Image.network(
            //     'https://cdn.pixabay.com/photo/2024/06/25/13/12/beautiful-girl-8852671_1280.jpg',
            //     height: 250,
            //     width: double.infinity,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 150.0),
              child: CarouselSlider.builder(
                itemCount: carouselItems.length,
                carouselController: myCarousel,
                itemBuilder: (context, index, realIndex) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            carouselItems[index]["image"]!,
                            height: 250,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          carouselItems[index]["title"]!,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          carouselItems[index]["description"]!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                options: CarouselOptions(
                    initialPage: _currentIndex,
                    autoPlay: false,
                    enableInfiniteScroll: false,
                    onPageChanged: (index, reason) {
                      _currentIndex = index;
                      setState(() {});
                    },
                    disableCenter: true,
                    height: MediaQuery.sizeOf(context).height * .5,
                    aspectRatio: 1,
                    viewportFraction: 1),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    int lastIndex = carouselItems.length - 1;
                    _currentIndex = lastIndex;
                    myCarousel.animateToPage(lastIndex);
                    setState(() {});
                  },
                  child: const Text("Skip", style: TextStyle(fontSize: 18)),
                ),
                ElevatedButton(
                  onPressed: () {
                    nextPage();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Set background color
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: SizedBox(
                      width: 150,
                      child: Text(
                        'Next',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
