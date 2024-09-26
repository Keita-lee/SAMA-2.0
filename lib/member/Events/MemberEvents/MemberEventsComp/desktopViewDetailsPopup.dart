import 'package:flutter/material.dart';
import 'package:sama/commonColors/SamaColors.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/member/Events/MemberEvents/MemberEventsComp/eventViewDeatilsButton.dart';

class DesktopViewDetailsPopup extends StatefulWidget {
  const DesktopViewDetailsPopup({super.key});

  @override
  State<DesktopViewDetailsPopup> createState() =>
      _DesktopViewDetailsPopupState();
}

class _DesktopViewDetailsPopupState extends State<DesktopViewDetailsPopup> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MyUtility(context).height * 0.70,
      width: 800,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey, width: 0.8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 10, bottom: 5),
            child: InkWell(
              onTap: () => Navigator.pop(context),
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
          EventViewDeatailsButton(
              eventName: 'Example Event',
              eventDate: '12 November 2024',
              eventTime: '18:00',
              onTap: () {})
        ],
      ),
    );
  }
}
