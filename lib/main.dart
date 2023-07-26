import 'package:flutter/material.dart';
import 'package:internship_app/constants/constants.dart';
import 'package:internship_app/firebase_options.dart';
import 'package:internship_app/homepage.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    ),
  );
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4)).then(
      (value) => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Image(
            image: AssetImage("assets/images/logo.png"),
            height: 50,
            width: 150,
            fit: BoxFit.fill,
          ),
          const SizedBox(height: 100),
          Center(
            child: Center(
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'Buy & Sell Old, Refurbished & Used Phones Online',
                    textAlign: TextAlign.center,
                    textStyle: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    speed: const Duration(milliseconds: 60),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 100),
          const SpinKitSpinningLines(
            color: kPrimaryColor,
            lineWidth: 5,
            size: 100.0,
          ),
        ],
      ),
    );
  }
}
