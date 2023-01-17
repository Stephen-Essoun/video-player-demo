import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Video Player Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late VideoPlayerController _playerController;
  @override
  void initState() {
    super.initState();
    _playerController = VideoPlayerController.asset('assets/videos/picfram.mp4')
      ..initialize().then((value) => () {
            setState(() {});
          });
  }

  // @override
  // void dispose() {
  //   _playerController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Video Player in Flutter"),
        backgroundColor: Colors.redAccent,
      ),
      body: Column(children: [
        AspectRatio(
          aspectRatio: _playerController.value.aspectRatio,
          child: VideoPlayer(_playerController),
        ),
        Text("Total Duration:${_playerController.value.duration.toString()}"),
        VideoProgressIndicator(_playerController,
            allowScrubbing: true,
            colors: const VideoProgressColors(
              backgroundColor: Colors.redAccent,
              playedColor: Colors.green,
              bufferedColor: Colors.purple,
            )),
        Row(
          children: [
            IconButton(
                onPressed: () {
                  if (_playerController.value.isPlaying) {
                    _playerController.pause();
                  } else {
                    _playerController.play();
                  }

                  setState(() {});
                },
                icon: Icon(_playerController.value.isPlaying
                    ? Icons.pause
                    : Icons.play_arrow)),
            IconButton(
                onPressed: () {
                  _playerController.seekTo(const Duration(seconds: 0));

                  setState(() {});
                },
                icon: const Icon(Icons.stop))
          ],
        )
      ]),
    );
  }
}
