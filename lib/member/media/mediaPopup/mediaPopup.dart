import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class MediaPopup extends StatefulWidget {
  final Function closeDialog;
  final String id;

  MediaPopup({
    Key? key,
    required this.closeDialog,
    required this.id,
  }) : super(key: key);

  @override
  _MediaPopupState createState() => _MediaPopupState();
}

class _MediaPopupState extends State<MediaPopup> {
  String? videoUrl;
  late YoutubePlayerController _youtubePlayerController;

  @override
  void initState() {
    super.initState();
    _fetchVideoUrl();
  }

  Future<void> _fetchVideoUrl() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('media')
          .doc(widget.id)
          .get();
      if (doc.exists) {
        setState(() {
          videoUrl = doc['urlLink'];
          print('Video URL: $videoUrl');
          if (videoUrl != null) {
            print('this is the vid URL' + videoUrl!);
            print(
                'Video ID: ${YoutubePlayerController.convertUrlToId(videoUrl!)}');
            _youtubePlayerController = YoutubePlayerController.fromVideoId(
              videoId: YoutubePlayerController.convertUrlToId(videoUrl!)!,
              autoPlay: true,
              params: const YoutubePlayerParams(
                showControls: true,
                showFullscreenButton: true,
              ),
            );
          }
        });
      }
    } catch (e) {
      print('Error fetching video URL: $e');
    }
  }

  @override
  void dispose() {
    _youtubePlayerController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('YouTube Player'),
      ),
      body: videoUrl == null
          ? Center(child: CircularProgressIndicator())
          : YoutubePlayerScaffold(
              controller: _youtubePlayerController,
              aspectRatio: 16 / 9,
              builder: (context, player) {
                return Column(
                  children: [
                    player,
                    ElevatedButton(
                      onPressed: () => widget.closeDialog(),
                      child: Text('Close'),
                    ),
                  ],
                );
              },
            ),
    );
  }
}
