// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:plant_ecommerce/configs/constants/constants.dart';
import 'package:plant_ecommerce/ui/screens/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 242, 247, 242),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            onPageChanged: (int page) {
              setState(() {
                currentIndex = page;
              });
            },
            controller: _pageController,
            children: const [
              CreatePage(
                image: 'assets/images/p1.png',
                title1: 'Best collection of',
                titleWithColor: ' indoor & outdoor',
                title2: 'plants',
                description:
                    'Adipisicing eiusmod sit elit laborum sunt culpa qui labore.',
              ),
              CreatePage(
                image: 'assets/images/p2.png',
                title1: 'Keep your',
                title2: 'plants',
                titleWithColor: ' alive',
                description:
                    'Ex in nisi culpa nostrud proident dolor consectetur commodo labore amet consequat dolor proident veniam.',
              ),
              CreatePage(
                image: 'assets/images/p3.png',
                title1: "Plan a tree &",
                title2: "green the",
                titleWithColor: ' earth',
                description: 'Eiusmod laboris non elit sint elit aliqua.',
              ),
            ],
          ),
          Positioned(
            bottom: 180,
            left: 193,
            child: SmoothPageIndicator(
              controller: _pageController,
              count: 3,
              effect: const JumpingDotEffect(
                dotHeight: 3,
                dotWidth: 3,
                verticalOffset: 10,
                activeDotColor: Color(0xff296e48),
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            left: 30,
            right: 30,
            child: currentIndex == 2
                ? ElevatedButton(
                    onPressed: () {
                      context.go('/login');
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: const Color.fromARGB(255, 75, 142, 75),
                      minimumSize: const Size(double.infinity, 60),
                    ),
                    child: const Text(
                      'Get Started',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )
                : ElevatedButton(
                    onPressed: () {
                      if (currentIndex < 2) {
                        currentIndex++;
                        if (currentIndex < 3) {
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        }
                      } else {
                        context.go('/login');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: const Color.fromARGB(255, 75, 142, 75),
                      minimumSize: const Size(double.infinity, 60),
                    ),
                    child: const Text(
                      'Next',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
          ),
          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
              onPressed: () {
                context.go('/login');
              },
              child: const Text(
                'Skip',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CreatePage extends StatelessWidget {
  final String image;
  final String title1;
  final String titleWithColor;
  final String? title2;
  final String description;

  const CreatePage({
    Key? key,
    required this.image,
    required this.title1,
    required this.titleWithColor,
    this.title2,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 50, right: 50, bottom: 80),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 350,
            child: Image.asset(image),
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              title1,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          RichText(
            text: TextSpan(
              text: title2,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: titleWithColor,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 75, 142, 75),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
