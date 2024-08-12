import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:sama/components/service/commonService.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/components/utility.dart';

class MemberContainer extends StatefulWidget {
  final String eventImage;
  final String eventName;
  final String location;
  final String dateFrom;
  final String dateTill;
  final VoidCallback onPressed;

  const MemberContainer(
      {super.key,
      required this.eventImage,
      required this.eventName,
      required this.location,
      required this.dateFrom,
      required this.dateTill,
      required this.onPressed});

  @override
  State<MemberContainer> createState() => _MemberContainerState();
}

class _MemberContainerState extends State<MemberContainer> {
  //Get days in a month
  getMonthNumber(month) {
    switch (month) {
      case "January":
        return 01;

      case "Febuary":
        return 02;

      case "March":
        return 03;

      case "April":
        return 04;

      case "May":
        return 05;

      case "June":
        return "06";

      case "July":
        return 07;

      case "Augustus":
        return 08;
      case "September":
        return 09;
      case "October":
        return 10;
      case "November":
        return 11;
      case "December":
        return 12;
      default:
        return 0;
    }
  }

  getDayNumber(date) {
    if (date != "") {
      var dateSplit = date.split("-");
      return "${dateSplit[2]}";
    } else {
      return "";
    }
  }

  getDay(date) {
    if (date != "") {
      /* var dateSplit = date.split(" ");

      var newDate = "${dateSplit[2]}-${(dateSplit[1])}-${dateSplit[0]}";*/

      var convertDate = DateTime.parse(date);
      const Map<int, String> weekdayName = {
        1: "Mon",
        2: "Tues",
        3: "Wed",
        4: "Thurs",
        5: "Fri",
        6: "Sat",
        7: "Sun"
      };
      return weekdayName[convertDate.weekday];
    } else {
      return "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyUtility(context).width * 0.22,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Color(0xFFF8FAFF),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*Container(
              height: MyUtility(context).height * 0.1,
              width: 10.0,
              decoration: BoxDecoration(
                color: Colors.blue.shade900,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                ),
              ),
            ),*/
            SizedBox(
              width: 15,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '${getDay(widget.dateTill)}\n',
                    style: TextStyle(
                      color: Color.fromARGB(176, 0, 0, 0),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: '${getDayNumber(widget.dateTill)}',
                    style: TextStyle(
                      color: Color.fromARGB(176, 0, 0, 0),
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Visibility(
              visible: widget.eventImage == "" ? true : false,
              child: ClipRRect(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/imageIcon.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  width: 165,
                  height: 130,
                ),
              ),
            ),
            Visibility(
              visible: widget.eventImage == "" ? false : true,
              child: ClipRRect(
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: ImageNetwork(
                    image: widget.eventImage,
                    width: 165,
                    height: 130,
                    fitWeb: BoxFitWeb.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Container(
              color: Colors.amber,
              width: MyUtility(context).width * 0.58,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: SizedBox(
                      child: Text(
                        '${CommonService().getDateInText(widget.dateFrom)}',
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF3D3D3D),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    child: Container(
                      height: 30,
                      child: Text(
                        widget.eventName,
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(0, 159, 158, 1),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    widget.location,
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF3D3D3D),
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Row(crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        color: Colors.black,
                        height: 60,
                        width: 20,
                      ),
                      Spacer(),
                      StyleButton(
                          description: "View Details",
                          fontSize: 13,
                          height: 38,
                          width: 60,
                          onTap: () {
                            widget.onPressed();
                          }),
                      
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
