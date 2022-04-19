import 'dart:math';
import 'package:audio_manager/audio_manager.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

const heading1 = TextStyle(
    color: Color(0xFF352852),
    fontWeight: FontWeight.w200,
    fontFamily: 'Garamond',
    letterSpacing: 1,
    fontSize: 30,
    height: 2,
    decoration: TextDecoration.none);

const heading2 = TextStyle(
    color: Color(0xFF352852),
    fontWeight: FontWeight.w200,
    fontFamily: 'Garamond',
    letterSpacing: 1,
    fontSize: 20,
    height: 2,
    decoration: TextDecoration.none);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'P_project Demo',
      home: const BreathExcersise(),
    );
  }
}

class BreathExcersise extends StatefulWidget {
  const BreathExcersise({Key? key}) : super(key: key);

  @override
  State<BreathExcersise> createState() => _BreathExcersiseState();
}

class _BreathExcersiseState extends State<BreathExcersise>
    with TickerProviderStateMixin {
  late AnimationController anime;
  late Animation movement;
  AudioPlayer audioPlayer = AudioPlayer();
  PlayerState audioState = PlayerState.PAUSED;
  late AudioCache audioCache;
  String path = 'music/Looping.mp3';

  @override
  void initState() {
    super.initState();
    anime =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    audioCache = AudioCache(fixedPlayer: audioPlayer);
    audioPlayer.onPlayerStateChanged.listen((PlayerState s) {
      audioState = s;
    });
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.release();
    audioPlayer.dispose();
    audioCache.clearAll();
  }

  playMusic() async {
    await audioCache.play(path);
}
  resetMusic() async {
    await audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.asset(
            'images/background.jpg',
            fit: BoxFit.fill,
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            alignment: Alignment(0, -0.8),
            child: Container(
              width: screenWidth / 1.3,
              child: RichText(
                text: const TextSpan(text: 'Calm your mind', style: heading1),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          AnimatedBuilder(
            animation: anime,
            builder: (context, _) {
              return Container(
                alignment: Alignment.center,
                child: Container(
                  width: screenWidth / 1.5,
                  alignment: Alignment.center,
                  child: Stack(children: [
                    Container(
                      alignment: Alignment.center,
                      child: Transform.scale(
                        scale: 1.0 - 0.3 * anime.value,
                        child: Transform.rotate(
                          angle: -2 * pi * anime.value,
                          child: Image.asset(
                            'images/circle.png',
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Container(
                        alignment: Alignment.center,
                        child: Text(
                          (anime.status != AnimationStatus.reverse)
                              ? 'Breath In'
                              : 'Breath out',
                          style: heading2,
                        )),
                  ]),
                ),
              );
            },
          ),
          Positioned(
              bottom: 50,
              left: (screenWidth - 200) / 2,
              child: Container(
                width: 200,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed))
                        return const Color(0xFFfeba94);
                      return Color(0xFFfeba94);
                    }),
                  ),
                  onPressed: () => {
                    (anime.status == AnimationStatus.dismissed)
                        ? anime.repeat(reverse: true)
                        : anime.reset(),
                    (audioState == PlayerState.PLAYING) ? resetMusic() : playMusic(),
                  },
                  child: Text('Press me', style: heading2),
                ),
              ))
        ],
      ),
    ));
  }
}
