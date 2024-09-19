import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:sama/components/myutility.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class MediaPopup extends StatefulWidget {
  final VoidCallback closeDialog;
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
  String title = "";
  String description = "";
  var myJSON;
  QuillController quillController = QuillController.basic();

  late YoutubePlayerController _youtubePlayerController;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    _fetchVideoUrl();
  }

  Future<void> _fetchVideoUrl() async {
    print(widget.id);
    try {
      final doc = await FirebaseFirestore.instance
          .collection('media')
          .doc(widget.id)
          .get();
      if (doc.exists) {
        setState(() {
          videoUrl = doc.get('urlLink');
          title = doc.get('title');
          print(doc.get('urlLink'));
          //  description = doc.docs[0]['description'];

          if (videoUrl != null) {
            _youtubePlayerController = YoutubePlayerController.fromVideoId(
              videoId: YoutubePlayerController.convertUrlToId(videoUrl!)!,
              autoPlay: true,
              params: const YoutubePlayerParams(
                showControls: true,
                showFullscreenButton: true,
              ),
            );
            isLoading = false;
          } /**/
        });
      }
    } catch (e) {
      print('Error fetching video URL: $e');
    }
  }

  @override
  void dispose() {
    // _youtubePlayerController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MyUtility(context).width < 600 ? true : false;
    return Container(
        width:
            isMobile ? MyUtility(context).width : MyUtility(context).width / 2,
        height: isMobile
            ? MyUtility(context).height / 2
            : MyUtility(context).height / 1.4,
        decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Color.fromARGB(255, 8, 55, 145),
                width: 2.0,
              ),
            ),
            borderRadius: BorderRadius.circular(15),
            color: Color.fromARGB(255, 255, 255, 255)),
        child: SingleChildScrollView(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF174486),
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      widget.closeDialog();
                    },
                    child: Icon(Icons.cancel),
                  ),
                ),
              ],
            ),
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                  color: Colors.teal,
                ))
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      width: isMobile
                          ? MyUtility(context).width
                          : MyUtility(context).width / 2.1,
                      // height: MyUtility(context).height / 2.1,
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
                      )),
                ),

          /*   Padding(
            padding: const EdgeInsets.all(25.0),
            child: Container(
              child: QuillEditor.basic(
                configurations: QuillEditorConfigurations(
                  controller: quillController,
                  sharedConfigurations: const QuillSharedConfigurations(),
                ),
              ),
            ),
          ),*/
        ])));

    /* Container(
        width: MyUtility(context).width / 2,
        height: MyUtility(context).height / 2,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Color(0xFFD1D1D1),
            )),
        child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*  Container(
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
                  )*/
                ])));
 */
  }
}
