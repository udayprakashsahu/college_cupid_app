//onboarding.dart
import 'package:couplecupid/signup.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<String> headings = ["Discover", "Connect", "Bond"];
  List<String> descriptions = [
    "Discover new and exciting people around you.",
    "Connect and chat with people who share your interests.",
    "Find meaningful connections and build lasting Bonding."
  ];

  List<String> animationFiles = ["assets/1.json", "assets/2.json", "assets/3.json"];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double fem = 1.0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xff000000),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: 400 * fem,
              height: 170 * fem,
            ),
            Center(
              child: SizedBox(
                width: 400 * fem,
                height: 400 * fem,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: headings.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Center(
                      child: Align(
                        alignment: Alignment.center,
                        child: Lottie.asset(
                          animationFiles[index], // Use the appropriate animation file
                          height: 400 * fem,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 5),
            Container(
              padding: EdgeInsets.fromLTRB(
                  40 * fem, 10 * fem, 40 * fem, 40 * fem),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          headings[_currentPage],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Sk-Modernist',
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            height: 1.5,
                            color: Color(0xffffffff),
                          ),
                        ),
                        SizedBox(height: 10 * fem),
                        Text(
                          descriptions[_currentPage],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Sk-Modernist',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                            color: Color(0xffffffff),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 26.07 * fem),
                  _buildPageIndicator(),
                  const SizedBox(height: 16.0),
                  TextButton(
                    onPressed: () {
                      if (_currentPage == headings.length - 1) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Signup()),
                        );
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                    ),
                    child: Container(
                      width: double.infinity,
                      height: 55.52 * fem,
                      decoration: BoxDecoration(
                        color: const Color(0xffcc323f),
                        borderRadius: BorderRadius.circular(15 * fem),
                      ),
                      child: Center(
                        child: Text(
                          _currentPage == headings.length - 1
                              ? 'Create an account'
                              : 'Next',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'Sk-Modernist',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            height: 1.5,
                            color: Color(0xffc2cad7),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(headings.length, (index) {
        return Container(
          width: 10,
          height: 10,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == index ? Colors.redAccent : Colors.grey,
          ),
        );
      }),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Onboarding(),
    );
  }
}