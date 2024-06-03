import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';

import 'package:sama/member/media/mediaPopup/ui/VideoPlayer.dart'; // Adjusted import

class MediaPopup extends StatefulWidget {
  final Function closeDialog;
  String id;
  MediaPopup({
    Key? key,
    required this.closeDialog,
    required this.id,
  }) : super(key: key);

  @override
  _MediaPopupState createState() => _MediaPopupState();
}

class Video {
  final String subjectName;
  final String duration;
  final String releaseDate;
  final String videoUrl;

  Video({
    required this.subjectName,
    required this.duration,
    required this.releaseDate,
    required this.videoUrl,
  });
}

class _MediaPopupState extends State<MediaPopup> {
  Future<List<Video>> getVideos() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('media').get();
    return querySnapshot.docs.map((doc) {
      final data = doc.data();
      return Video(
        subjectName: data['title'],
        duration: data['duration'],
        releaseDate: "",
        videoUrl: data['urlLink'],
      );
    }).toList();
  }

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
      body: FutureBuilder<List<Video>>(
        future: getVideos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final videos = snapshot.data!;
            return SizedBox(
              width: MyUtility(context).width * 0.53,
              child: ListView.builder(
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  final video = videos[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      child: VideoContainer(
                        subjectName: video.subjectName,
                        duration: video.duration,
                        releaseDate: video.releaseDate,
                        videoUrl: video.videoUrl,
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
