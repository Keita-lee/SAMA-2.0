import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';
import 'package:video_player/video_player.dart';

class VideoContainer extends StatefulWidget {
  final String subjectName;
  final String duration;
  final String releaseDate;
  final String videoUrl;

  VideoContainer({
    required this.subjectName,
    required this.duration,
    required this.releaseDate,
    required this.videoUrl,
  });

  @override
  _VideoContainerState createState() => _VideoContainerState();
}

class _VideoContainerState extends State<VideoContainer> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  double _volume = 1.0;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..addListener(() {
        setState(() {});
      });
    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    return duration.toString().split('.').first;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyUtility(context).width * 0.55,
      height: MyUtility(context).height * 0.6,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            spreadRadius: 2,
          )
        ],
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.subjectName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Release Date: ${widget.releaseDate}',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            Container(
              width: MyUtility(context).width * 0.5,
              height: MyUtility(context).height * 0.4,
              color: Colors.black,
              child: Stack(
                children: [
                  FutureBuilder(
                    future: _initializeVideoPlayerFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        );
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                  Center(
                    child: IconButton(
                      icon: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        size: 50.0,
                      ),
                      onPressed: () {
                        setState(() {
                          if (_controller.value.isPlaying) {
                            _controller.pause();
                          } else {
                            _controller.play();
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    _controller.value.volume == 0
                        ? Icons.volume_off
                        : Icons.volume_up,
                  ),
                  onPressed: () {
                    setState(() {
                      _volume = _controller.value.volume == 0 ? 1 : 0;
                      _controller.setVolume(_volume);
                    });
                  },
                ),
                SizedBox(
                  width: MyUtility(context).width * 0.2,
                  child: Expanded(
                    child: Slider(
                      value: _volume,
                      onChanged: (newValue) {
                        setState(() {
                          _volume = newValue;
                          _controller.setVolume(newValue);
                        });
                      },
                      min: 0,
                      max: 1,
                      divisions: 10,
                      label: _volume.toStringAsFixed(1),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  _formatDuration(
                      _controller.value.duration - _controller.value.position),
                ),
              ],
            ),
            Text(
              'Duration: ${widget.duration}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
