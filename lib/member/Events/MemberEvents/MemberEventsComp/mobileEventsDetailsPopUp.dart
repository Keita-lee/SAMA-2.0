import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';

import '../../../../commonColors/SamaColors.dart';

class MobileEventsDetailsPopup extends StatefulWidget {
  final String eventName;
  final String eventDate;
  final String eventTime;
  final String eventDescription;

  const MobileEventsDetailsPopup(
      {super.key,
      required this.eventName,
      required this.eventDate,
      required this.eventTime,
      required this.eventDescription});

  @override
  State<MobileEventsDetailsPopup> createState() =>
      _MobileEventsDetailsPopupState();
}

class _MobileEventsDetailsPopupState extends State<MobileEventsDetailsPopup> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey, width: 0.8),
      ),
      width: MyUtility(context).width * 0.95,
      height: MyUtility(context).height * 0.75,
      child: Column(
        children: [
          Container(
            width: MyUtility(context).width * 0.95,
            height: MyUtility(context).height * 0.25,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5), topRight: Radius.circular(5)),
              image: DecorationImage(
                  image: AssetImage('images/coffee.jpg'), fit: BoxFit.cover),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 10, bottom: 5),
                  child: InkWell(
                    onTap: () => Navigator.pop,
                    child: Container(
                      decoration: ShapeDecoration(
                          color: SamaColors().darkBlue, shape: CircleBorder()),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              width: MyUtility(context).width * 0.95,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.eventName,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  Text.rich(
                    TextSpan(
                      style: TextStyle(color: SamaColors().teal, fontSize: 12),
                      children: [
                        TextSpan(
                          text: widget.eventDate,
                        ),
                        TextSpan(text: ' | ${widget.eventTime}')
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.eventDescription,
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
