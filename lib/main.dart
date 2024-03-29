import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(),
        useMaterial3: false,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var scController = ScreenshotController();

  var clubs = [
    {"code": "---", "logo": "default.jpg", "name": "- - -"},
    {"code": "ALV", "logo": "ALV.png", "name": "Alaves"},
    {"code": "UDA", "logo": "UDA.png", "name": "Almeria"},
    {"code": "ATB", "logo": "ATB.png", "name": "Athletic Bilbao"},
    {"code": "ATM", "logo": "ATM.png", "name": "Atletico de Madrid"},
    {"code": "FCB", "logo": "FCB.png", "name": "FC Barcelona"},
    {"code": "BET", "logo": "BET.png", "name": "Real Betis"},
    {"code": "CLV", "logo": "CLV.png", "name": "Celta de Vigo"},
    {"code": "CCF", "logo": "CCF.png", "name": "Cadiz"},
    {"code": "GET", "logo": "GET.png", "name": "Getafe"},
    {"code": "GIR", "logo": "GIR.png", "name": "Girona"},
    {"code": "GCF", "logo": "GCF.png", "name": "Granada"},
    {"code": "LAP", "logo": "LAP.png", "name": "Las Palmas"},
    {"code": "RCD", "logo": "RCD.png", "name": "Mallorca"},
    {"code": "OSA", "logo": "OSA.png", "name": "Osasuna"},
    {"code": "SOC", "logo": "SOC.png", "name": "Real Sociedad"},
    {"code": "RAY", "logo": "RAY.png", "name": "Rayo Vallecano"},
    {"code": "MAD", "logo": "MAD.png", "name": "Real Madrid"},
    {"code": "SEV", "logo": "SEV.png", "name": "Sevilla"},
    {"code": "VAL", "logo": "VAL.png", "name": "Valencia"},
    {"code": "VIL", "logo": "VIL.png", "name": "Villarreal"}
  ];

  List<Widget> items() {
    List<Widget> ele = [];
    for (var item in clubs) {
      ele.add(Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: Colors.white),
              ),
              height: 30,
              width: 30,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  "assets/images/${item['logo']}",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 15),
            Text(item.entries.last.value),
          ],
        ),
      ));
    }
    return ele;
  }

  List<Widget> itemsScore() {
    List<Widget> ele = [];
    for (var i = 0; i < 11; i++) {
      ele.add(Center(
        child: Text(i.toString()),
      ));
    }
    return ele;
  }

  var home = "---";
  var homeL = "---";
  var homes = "0";
  var away = "---";
  var awayL = "---";
  var aways = "0";

  bool isClub = true;
  String idx = "0";

  bool animate0 = false;
  bool anime0n = false;
  bool animate1 = false;
  bool anime1n = false;
  bool animate2 = false;
  bool anime2n = false;
  bool animate3 = false;
  bool anime3n = false;

  String imgHome = "default.jpg";
  String imgAway = "default.jpg";

  Timer? checker;
  setTimer() {
    if (checker != null && checker!.isActive) {
    } else {
      createTimer();
    }
  }

  createTimer() {
    checker = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (idx == "0") {
          animate0 = true;
          animate1 = false;
          animate2 = false;
          animate3 = false;
        }
        if (idx == "1") {
          animate1 = true;
          animate0 = false;
          animate2 = false;
          animate3 = false;
        }
        if (idx == "2") {
          animate1 = false;
          animate0 = false;
          animate2 = true;
          animate3 = false;
        }
        if (idx == "3") {
          animate1 = false;
          animate0 = false;
          animate2 = false;
          animate3 = true;
        }

        if (animate0) {
          anime0n = !anime0n;
        }

        if (animate1) {
          anime1n = !anime1n;
        }

        if (animate2) {
          anime2n = !anime2n;
        }

        if (animate3) {
          anime3n = !anime3n;
        }
      });
    });
  }

  cancelTimer() {
    setState(() {
      animate0 = false;
      anime0n = false;
      animate1 = false;
      anime1n = false;
      animate2 = false;
      anime2n = false;
      animate3 = false;
      anime3n = false;
    });
    checker?.cancel();
  }

  String winInfo = "";
  String winInfoDesc = "";

  @override
  void initState() {
    super.initState();
    setTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 100),
            Container(
              padding: const EdgeInsets.all(10),
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Colors.white),
                    ),
                    height: 80,
                    width: 80,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        "assets/images/$imgHome",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Goal Guess",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text("Football Score Predictor"),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Colors.white),
                    ),
                    height: 80,
                    width: 80,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        "assets/images/$imgAway",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   width: double.infinity,
            //   color: Colors.black,
            //   padding: const EdgeInsets.all(8.0),
            //   child: const Text(
            //     "SPANISH LALIGA",
            //     textAlign: TextAlign.center,
            //     style: TextStyle(fontWeight: FontWeight.bold),
            //   ),
            // ),
            Column(
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.black,
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 3,
                      color: Colors.white,
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "FULL TIME",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            idx = "0";
                            isClub = true;
                            setTimer();
                          });
                        },
                        child: Container(
                          decoration: animate0 && anime0n
                              ? const CustomDecoration(
                                  frameSFactor: .1,
                                  gap: 5,
                                  backgroundColor: Colors.red,
                                )
                              : const BoxDecoration(color: Colors.red),
                          height: 100,
                          child: Center(
                              child: Text(
                            home,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          )),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Colors.black,
                        height: 100,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isClub = false;
                                    idx = "1";
                                    setTimer();
                                  });
                                },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  alignment: Alignment.center,
                                  decoration: animate1 && anime1n
                                      ? const CustomDecoration(
                                          frameSFactor: 0.1,
                                          gap: 5,
                                        )
                                      : const BoxDecoration(),
                                  child: Text(
                                    homes,
                                    style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 20),
                                child: Text(
                                  "_",
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    isClub = false;
                                    idx = "2";
                                    setTimer();
                                  });
                                },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  alignment: Alignment.center,
                                  decoration: animate2 && anime2n
                                      ? const CustomDecoration(
                                          frameSFactor: 0.1,
                                          gap: 5,
                                        )
                                      : const BoxDecoration(),
                                  child: Text(
                                    aways,
                                    style: const TextStyle(
                                      fontSize: 32,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isClub = true;
                            idx = "3";
                            setTimer();
                          });
                        },
                        child: Container(
                          decoration: animate3 && anime3n
                              ? const CustomDecoration(
                                  frameSFactor: 0.1,
                                  gap: 5,
                                )
                              : const BoxDecoration(
                                  // gradient: LinearGradient(
                                  //   stops: [0, 1],
                                  //   begin: Alignment.topLeft,
                                  //   end: Alignment.bottomRight,
                                  //   colors: [Colors.white, Colors.black],
                                  // ),
                                  ),
                          height: 100,
                          child: Center(
                            child: Text(
                              away,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            InkWell(
              onTap: () {
                cancelTimer();
                var win = homeL;
                var lose = awayL;
                var winS = homes;
                var loseS = aways;
                if (int.parse(homes) < int.parse(aways)) {
                  win = awayL;
                  lose = homeL;
                  winS = aways;
                  loseS = homes;
                }

                setState(() {
                  winInfo =
                      "I predict $win will win againts $lose $winS - $loseS at full-time";
                  winInfoDesc = "Predict football scores with US";
                });

                scController
                    .captureFromWidget(
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.black,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(color: Colors.white),
                              ),
                              height: 80,
                              width: 80,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset(
                                  "assets/images/$imgHome",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Goal Guess",
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text("Football Score Predictor"),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(color: Colors.white),
                              ),
                              height: 80,
                              width: 80,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset(
                                  "assets/images/$imgAway",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black,
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 3,
                            color: Colors.white,
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "FULL TIME",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Container(
                              decoration:
                                  const BoxDecoration(color: Colors.red),
                              height: 100,
                              child: Center(
                                  child: Text(
                                home,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              )),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.black,
                              height: 50,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      alignment: Alignment.center,
                                      child: Text(
                                        homes,
                                        style: const TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 20),
                                      child: Text(
                                        "_",
                                        style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      width: 50,
                                      alignment: Alignment.center,
                                      child: Text(
                                        aways,
                                        style: const TextStyle(
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  stops: [0, 1],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Colors.white, Colors.black],
                                ),
                              ),
                              height: 100,
                              child: Center(
                                child: Text(
                                  away,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(winInfo),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Text(winInfoDesc),
                      ),
                    ],
                  ),
                )
                    .then((image) async {
                  final directory = await getExternalStorageDirectory();
                  final imagePath =
                      await File('${directory!.absolute.path}/image.png')
                          .create();
                  await imagePath.writeAsBytes(image);

                  /// Share Plugin
                  // await FlutterShare.shareFile(
                  //   title: "title nya",
                  //   filePath: imagePath.path,
                  // );

                  XFile img = XFile(imagePath.path);
                  List<XFile> files = [img];
                  Share.shareXFiles(files);
                });
              },
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xffe52d27), Color(0xffb31217)],
                    stops: [0, 1],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                alignment: Alignment.center,
                height: 50,
                width: double.infinity,
                child: const Text("SEND"),
              ),
            ),
            SizedBox(
              height: 300,
              child: isClub
                  ? CupertinoPicker(
                      itemExtent: 48,
                      onSelectedItemChanged: (int value) {
                        setState(() {
                          if (idx == "0") {
                            home = clubs[value].entries.last.value;
                            homeL = clubs[value].entries.last.value;
                            imgHome = clubs[value]['logo']!;
                          }
                          if (idx == "3") {
                            away = clubs[value].entries.last.value;
                            awayL = clubs[value].entries.last.value;
                            imgAway = clubs[value]['logo']!;
                          }
                        });
                      },
                      children: items(),
                    )
                  : CupertinoPicker(
                      itemExtent: 48,
                      onSelectedItemChanged: (int value) {
                        setState(() {
                          if (idx == "1") {
                            homes = value.toString();
                          }
                          if (idx == "2") {
                            aways = value.toString();
                          }
                        });
                      },
                      children: itemsScore(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomDecoration extends Decoration {
  final Color? backgroundColor;
  final double frameSFactor;
  final double gap;

  const CustomDecoration({
    this.backgroundColor = Colors.transparent,
    required this.frameSFactor,
    required this.gap,
  });
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return CustomDecorationPainter(
        backgroundColor: backgroundColor!,
        frameSFactor: frameSFactor,
        padding: gap);
  }
}

class CustomDecorationPainter extends BoxPainter {
  final Color backgroundColor;
  final double frameSFactor;
  final double padding;

  CustomDecorationPainter({
    required this.backgroundColor,
    required this.frameSFactor,
    required this.padding,
  });

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final Rect bounds = offset & configuration.size!;
    final frameHWidth = configuration.size!.width * frameSFactor;

    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..strokeWidth = 4;

    /// background
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        bounds,
        const Radius.circular(0),
      ),
      paint..color = backgroundColor,
    );

    paint.color = Colors.yellow;

    /// top left
    canvas.drawLine(
      bounds.topLeft + Offset(padding, padding),
      Offset(bounds.topLeft.dx + frameHWidth, bounds.topLeft.dy) +
          Offset(padding, padding),
      paint,
    );
    canvas.drawLine(
      bounds.topLeft + Offset(padding, padding),
      Offset(bounds.topLeft.dx, bounds.topLeft.dy + frameHWidth) +
          Offset(padding, padding),
      paint,
    );

    //top Right
    canvas.drawLine(
      Offset(bounds.topRight.dx - padding, bounds.topRight.dy + padding),
      Offset(bounds.topRight.dx - padding - frameHWidth,
          bounds.topRight.dy + padding),
      paint,
    );
    canvas.drawLine(
      Offset(bounds.topRight.dx - padding, bounds.topRight.dy + padding),
      Offset(bounds.topRight.dx - padding,
          bounds.topRight.dy + padding + frameHWidth),
      paint..color,
    );

    //bottom Right
    canvas.drawLine(
      Offset(bounds.bottomRight.dx - padding, bounds.bottomRight.dy - padding),
      Offset(bounds.bottomRight.dx - padding,
          bounds.bottomRight.dy - padding - frameHWidth),
      paint,
    );
    canvas.drawLine(
      Offset(bounds.bottomRight.dx - padding, bounds.bottomRight.dy - padding),
      Offset(bounds.bottomRight.dx - padding - frameHWidth,
          bounds.bottomRight.dy - padding),
      paint,
    );
//bottom Left
    canvas.drawLine(
      Offset(bounds.bottomLeft.dx + padding, bounds.bottomLeft.dy - padding),
      Offset(bounds.bottomLeft.dx + padding,
          bounds.bottomLeft.dy - padding - frameHWidth),
      paint,
    );
    canvas.drawLine(
      Offset(bounds.bottomLeft.dx + padding, bounds.bottomLeft.dy - padding),
      Offset(bounds.bottomLeft.dx + padding + frameHWidth,
          bounds.bottomLeft.dy - padding),
      paint,
    );
  }
}
