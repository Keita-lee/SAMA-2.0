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
    return Container(
      width: MyUtility(context).width * 0.22,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Color(0xFFD1D1D1),
          )),
      child: Container(
        height: 600,
        child: Column(
          children: [
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
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: ImageNetwork(
                    image: widget.eventImage,
                    width: MyUtility(context).width * 0.2,
                    height: MyUtility(context).height * 0.25,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MyUtility(context).height * 0.10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MyUtility(context).width * 0.2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
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
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: SizedBox(
                        child: Container(
                          height: 30,
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
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 30,
              child: Text(
                'TEST',
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF3D3D3D),
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
            StyleButton(
              onTap: () {
                print("Pressed");
                widget.onPressed();
              },
              description: 'Learn More',
              height: 55,
              width: 150,
            ),
          ],
        ),
      ),
    );
  }
}
