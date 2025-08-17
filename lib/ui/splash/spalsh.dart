import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yuukfokus/helper/assets_url.dart';
import 'package:yuukfokus/ui/home/view/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // Future.delayed(Duration(seconds: 2)).then(
    //   (value) => Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => HomePage()),
    //   ),
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetsUrl.backround),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AssetsUrl.icon, height: 200),
              Text(
                "YUK FOKUS",
                style: GoogleFonts.pixelifySans(
                  textStyle: TextStyle(fontSize: 60),
                  color: Colors.white,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: Image.asset(AssetsUrl.start, height: 50),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
