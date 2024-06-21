import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Pressed");
        widget.onPressed();
      },
      child: Container(
        width: MyUtility(context).width * 0.22,
        decoration: BoxDecoration(
            color: Color(0xFFF8FAFF),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Color(0xFFF8FAFF),
            )),
        child: Row(
          children: [
            Container(
              height: MyUtility(context).height * 0.1,
              width: 10.0,
              decoration: BoxDecoration(
                color: Colors.blue.shade900,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                ),
              ),
            ),
            SizedBox(
              width: MyUtility(context).width * 0.025,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'SAT\n',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: '5',
                    style: TextStyle(
                      color: Colors.blue.shade900,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MyUtility(context).width * 0.025,
            ),
            /*   Container(
              width: MyUtility(context).width * 0.15,
              height: MyUtility(context).height * 0.22,
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
            ),*/
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: FittedBox(
                fit: BoxFit.contain,
                child: ImageNetwork(
                  image: widget.eventImage,
                  width: MyUtility(context).width * 0.1,
                  height: MyUtility(context).height * 0.1,
                  fitWeb: BoxFitWeb.cover,
                ),
              ),
            ),
            SizedBox(
              width: MyUtility(context).height * 0.025,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MyUtility(context).width * 0.2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: SizedBox(
                        child: Text(
                          '${widget.dateFrom}',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF3D3D3D),
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Container(
                          height: 30,
                          child: Text(
                            widget.eventName,
                            style: TextStyle(
                              fontSize: 20,
                              color: Color(0xFF3D3D3D),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 30,
                      child: Text(
                        widget.location,
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF3D3D3D),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
