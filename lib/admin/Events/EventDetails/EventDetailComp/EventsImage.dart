import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';

class EventImage extends StatefulWidget {
  final String eventImage;

  const EventImage({Key? key, required this.eventImage}) : super(key: key);

  @override
  State<EventImage> createState() => _EventImageState();
}

class _EventImageState extends State<EventImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyUtility(context).width * 0.2,
      height: MyUtility(context).height * 0.35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey[300]!,
          width: 1,
        ),
        image: DecorationImage(
          image: AssetImage(widget.eventImage),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
