import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';

import 'package:sama/member/media/mediaPopup/ui/VideoPlayer.dart'; // Adjusted import

class MediaPopup extends StatefulWidget {
  final Function closeDialog;
  MediaPopup({Key? key, required this.closeDialog}) : super(key: key);

  @override
  _MediaPopupState createState() => _MediaPopupState();
}

class _MediaPopupState extends State<MediaPopup> {
  final List<Map<String, String>> videos = [
    {
      'subjectName': 'Flutter Tutorial',
      'duration': '10:00',
      'releaseDate': '1 Jan 2024',
      'videoUrl': 'https://www.example.com/video1.mp4',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video List'),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => widget.closeDialog(),
        ),
      ),
      body: SizedBox(
        width: MyUtility(context).width * 0.53,
        child: ListView.builder(
          itemCount: videos.length,
          itemBuilder: (context, index) {
            final video = videos[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                child: VideoContainer(
                  subjectName: video['subjectName']!,
                  duration: video['duration']!,
                  releaseDate: video['releaseDate']!,
                  videoUrl: video['videoUrl']!,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
