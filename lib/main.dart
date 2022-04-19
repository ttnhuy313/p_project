import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'NoPon'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //final String? youtubeURL;
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  //const MyHomePage(this.youtubeURL, this.title);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  //_MyHomePageStage createState() => _MyHomePageState();
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late YoutubePlayerController _controller;
  int _counter = 0;
  var today = DateTime.now();
  var saved_day = "2022-03-18 13:27:00";

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      //_counter++;
      print(saved_day);
      print(today);
      _counter = today.difference(DateTime.parse(saved_day)).inDays;
    });
  }

  @override

  void initState(){
    today = DateTime.now();
    _incrementCounter;
    
    // _controller = YoutubePlayerController(
    //     initialVideoId: YoutubePlayerController.convertUrlToId("https://www.youtube.com/watch?v=5FCcXCchXDk"!)!,
    //     params: const YoutubePlayerParams(
    //       loop: true,
    //       color: 'transparent',
    //       strictRelatedVideos: true,
    //       showFullscreenButton: !kIsWeb,
    //     )
    // );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            const Text(
              'Number of days No Nuts:',
            ),
            Text(
              //'$today',
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),

      // child: YoutubePlayerControllerProvider(
      //     controller: _controller,
      //     child: YoutubePlayerIFrame(
      //       controller: _controller,
      //     )
      // );

      floatingActionButton: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: 80,
            bottom: 80,
            child: FloatingActionButton(
              heroTag: 'back',
              onPressed: _incrementCounter,
              child: const Icon(
                Icons.autorenew_sharp,
                size: 40,
              ),
              //shape: RoundedRectangleBorder(
                //borderRadius: BorderRadius.circular(10),
              //),
            ),
          ),
          Positioned(
            bottom: 80,
            right: 80,
            child: FloatingActionButton(
              heroTag: 'next',
              onPressed: () {/* Do something */},
              child: const Icon(
                Icons.admin_panel_settings,
                size: 40,
              ),
              //shape: RoundedRectangleBorder(
                //borderRadius: BorderRadius.circular(10),
              //),
            ),
          ),
          // Add more floating buttons if you want
          // There is no limit
        ],
      ),

    );
  }
}
