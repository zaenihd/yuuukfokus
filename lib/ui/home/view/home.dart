import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:yuukfokus/helper/assets_url.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final StreamDuration _streamDuration;

  @override
  void initState() {
    super.initState();
    _streamDuration = StreamDuration(
      config: const StreamDurationConfig(
        countDownConfig: CountDownConfig(duration: Duration(minutes: 0)),
      ),
    );
  }

  @override
  void dispose() {
    _streamDuration.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _backround(context),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "to do",
                  style: GoogleFonts.pixelifySans(
                    textStyle: TextStyle(fontSize: 60),
                    color: Colors.white,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 40),
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.sizeOf(context).width / 1.3,
                  height: MediaQuery.sizeOf(context).height / 4,
                  decoration: BoxDecoration(
                    // color: Colors.amber,
                    image: DecorationImage(
                      image: AssetImage(AssetsUrl.timer),
                      // fit: BoxFit.cover,
                    ),
                  ),
                  child:
                      // Text(
                      //   "22 : 59",
                      //   style: GoogleFonts.pixelifySans(
                      //     textStyle: TextStyle(fontSize: 60),
                      //     color: Colors.black,
                      //   ),
                      // ),
                      SlideCountdownSeparated(
                        decoration: BoxDecoration(),
                        style: GoogleFonts.pixelifySans(
                          textStyle: TextStyle(fontSize: 60),
                          color: Colors.black,
                        ),

                        streamDuration: _streamDuration,
                      ),
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 45),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          _streamDuration.add(const Duration(minutes: 10));
                          _streamDuration.resume();
                        },
                        child: Image.asset(AssetsUrl.start, height: 50),
                      ),
                      Image.asset(AssetsUrl.stop, height: 50),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _addTodo(),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80, left: 40),
              child: Image.asset(AssetsUrl.history, height: 50),
            ),
          ),
        ],
      ),
    );
  }

  DateTime startTimer({int? minute, int? second}) {
    return DateTime.now().add(
      Duration(minutes: minute ?? 0, seconds: second ?? 0),
    );
  }

  Align _addTodo() {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AssetsUrl.add),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Container _backround(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AssetsUrl.backround),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
