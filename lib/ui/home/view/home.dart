import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:yuukfokus/helper/assets_url.dart';
import 'package:yuukfokus/ui/home/controller/home_controller.dart';

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

  final todoC = TextEditingController();
  final waktuC = TextEditingController();
  final controller = Get.put(HomeController());

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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Obx(
                    () => Text(
                      textAlign: TextAlign.center,
                      controller.todo.value,
                      style: GoogleFonts.pixelifySans(
                        textStyle: TextStyle(fontSize: 50),
                        color: Colors.white,
                      ),
                    ),
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
                          controller.isStart.toggle();
                          if (controller.isStart.isTrue) {
                            _streamDuration.resume();
                          } else {
                            _streamDuration.pause();
                          }
                        },
                        child: Obx(
                          () => Image.asset(
                            controller.isStart.isFalse
                                ? AssetsUrl.start
                                : AssetsUrl.pause,
                            height: 50,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _streamDuration.reset();
                          controller.todo.value = "";
                        },
                        child: Image.asset(AssetsUrl.stop, height: 50),
                      ),
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

  Align _addTodo() {
    return Align(
      alignment: Alignment.topRight,
      child: InkWell(
        onTap: () {
          showImageDialog(context);
        },
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

  Future<void> showImageDialog(
    BuildContext context, {
    String? title,
    String? description,
    String primaryActionText = 'OK',
    VoidCallback? onPrimaryAction,
  }) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Close',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (ctx, _, _) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: MediaQuery.of(ctx).size.width * 0.86,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 24,
                        color: Colors.black.withOpacity(0.2),
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header image di dalam Container (bukan langsung Image widget)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 30,
                        ),
                        height: 250,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                          image: DecorationImage(
                            image: AssetImage(AssetsUrl.form),
                          ),
                        ),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: todoC,
                              decoration: InputDecoration(
                                hintText: "Masukkan To do Kamu", // teks hint
                                // teks label di atas
                                border: OutlineInputBorder(
                                  // border kotak
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  // border saat fokus
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  // border normal
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "To Do Tidak boleh kosong";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20.0),
                            TextFormField(
                              controller: waktuC,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                suffix: Text("Menit"),
                                hintText: "Masukkan Waktu kamu ", // teks hint
                                // teks label di atas
                                border: OutlineInputBorder(
                                  // border kotak
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  // border saat fokus
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  // border normal
                                  borderSide: BorderSide(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "To Do Tidak boleh kosong";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10.0),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color.fromARGB(
                                  226,
                                  235,
                                  150,
                                  23,
                                ), // warna background
                                foregroundColor:
                                    Colors.white, // warna teks/icon
                              ),
                              onPressed: () {
                                _streamDuration.add(
                                  Duration(minutes: int.parse(waktuC.text)),
                                );
                                controller.todo.value = todoC.text;
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Yuk Fokuus!",
                                style: GoogleFonts.pixelifySans(
                                  textStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Tombol close melayang
              ],
            ),
          ),
        );
      },
      transitionBuilder: (ctx, anim, _, child) {
        // Animasi scale + fade
        final curved = CurvedAnimation(
          parent: anim,
          curve: Curves.easeOutCubic,
        );
        return FadeTransition(
          opacity: curved,
          child: ScaleTransition(
            scale: Tween(begin: 0.95, end: 1.0).animate(curved),
            child: child,
          ),
        );
      },
    );
  }
}
