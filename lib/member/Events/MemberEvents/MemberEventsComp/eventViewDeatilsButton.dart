import 'package:flutter/material.dart';
import 'package:sama/commonColors/SamaColors.dart';
import 'package:sama/components/myutility.dart';

class EventViewDeatailsButton extends StatefulWidget {
  final String eventName;
  final String eventDate;
  final String eventTime;
  final Function() onTap;
  const EventViewDeatailsButton(
      {super.key,
      required this.eventName,
      required this.eventDate,
      required this.eventTime,
      required this.onTap});

  @override
  State<EventViewDeatailsButton> createState() =>
      _EventViewDeatailsButtonState();
}

class _EventViewDeatailsButtonState extends State<EventViewDeatailsButton> {
  @override
  Widget build(BuildContext context) {
    bool isMobile = MyUtility(context).width < 600 ? true : false;
    return Padding(
      padding: isMobile == true
          ? const EdgeInsets.symmetric(vertical: 10)
          : const EdgeInsets.all(10),
      child: Container(
        width: MyUtility(context).width * 0.95,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey, width: 0.8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.eventName,
                    style: TextStyle(fontWeight: FontWeight.bold),
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
                ],
              ),
              Spacer(),
              Visibility(
                visible: isMobile == false,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(60, 40),
                    backgroundColor: SamaColors().teal,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Text(
                    'View Details',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  onPressed: widget.onTap,
                ),
              ),
              Visibility(
                visible: isMobile == true,
                child: InkWell(
                  onTap: widget.onTap,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: SamaColors().teal,
                    ),
                    child: Icon(
                      Icons.east,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
