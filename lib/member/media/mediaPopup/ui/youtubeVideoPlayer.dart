import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class Youtubevideoplayer extends StatefulWidget {
  String id;
  Youtubevideoplayer({super.key, required this.id});

  @override
  State<Youtubevideoplayer> createState() => _YoutubevideoplayerState();
}

class _YoutubevideoplayerState extends State<Youtubevideoplayer> {
  String? videoUrl;
  late YoutubePlayerController _youtubePlayerController;

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
              autoPlay: false,
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
  void initState() {
    super.initState();

    _fetchVideoUrl();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyUtility(context).width / 4.4,
      height: MyUtility(context).height / 4,
      child: YoutubePlayerScaffold(
        controller: _youtubePlayerController,
        aspectRatio: 16 / 9,
        builder: (context, player) {
          return Column(
            children: [
              player,
            ],
          );
        },
      ),
    );
  }
}
