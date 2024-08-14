import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';

class LastPost extends StatefulWidget {
  final String text;
  final String userImageUrl;
  final String postTime;
  final String userName;

  const LastPost({
    Key? key,
    required this.text,
    required this.userImageUrl,
    required this.postTime,
    required this.userName,
  }) : super(key: key);

  @override
  State<LastPost> createState() => _LastPostState();
}

class _LastPostState extends State<LastPost> {
  @override
  Widget build(BuildContext context) {
    // Truncate the text if necessary
    String truncatedText = widget.text.length > 23
        ? '${widget.text.substring(0, 23)}...'
        : widget.text;

    return Container(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 5, right: 8),
            child: CircleAvatar(
              radius: 35,
              backgroundImage: widget.userImageUrl.isNotEmpty
                  ? NetworkImage(widget.userImageUrl)
                  : null,
              backgroundColor: Colors.grey[200],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                truncatedText,
                style: const TextStyle(
                  fontSize: 19,
                  color: Color.fromARGB(255, 8, 55, 145),
                  fontWeight: FontWeight.w100,
                ),
                textAlign: TextAlign.start,
              ),
              Row(
                children: [
                  Text(
                    widget.postTime,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 8, 55, 145),
                      fontWeight: FontWeight.w100,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(width: 5),
                  Text(
                    widget.userName,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 8, 55, 145),
                      fontWeight: FontWeight.w100,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
