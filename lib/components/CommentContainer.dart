import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';

class CommentContainer extends StatefulWidget {
  final String image;
  final String username;
  final String time;
  final String date;
  final String comment;
  final Color? backgroundColor;

  const CommentContainer({
    super.key,
    required this.image,
    required this.username,
    required this.time,
    required this.date,
    required this.comment,
    this.backgroundColor,
  });

  @override
  State<CommentContainer> createState() => _CommentContainerState();
}

class _CommentContainerState extends State<CommentContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 1.2,
      height: MediaQuery.of(context).size.height * 0.2,
      color: widget.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SizedBox(
              width: MyUtility(context).width * 0.13,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(widget.image),
                  ),
                  Row(
                    children: [
                      Text(
                        'By ',
                        style: TextStyle(
                          color: Color(0xFF3D3D3D),
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        widget.username,
                        style: TextStyle(
                          color: Color(0xFF174486),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        widget.time,
                        style: TextStyle(
                          color: Color(0xFF3D3D3D),
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        ' | ',
                        style: TextStyle(
                          color: Color(0xFF3D3D3D),
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        widget.date,
                        style: TextStyle(
                          color: Color(0xFF3D3D3D),
                          fontSize: 16,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: SizedBox(
                  width: MyUtility(context).width / 1.75,
                  child: Text(
                    widget.comment,
                    style: TextStyle(color: Color(0xFF3D3D3D), fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
