import 'package:flutter/material.dart';
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, right: 10),
      child: Container(
        width: MyUtility(context).width * 0.4,
        height: MyUtility(context).height * 0.2,
        decoration: ShapeDecoration(
          color: Color(0xFFFFF5F5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          shadows: [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Container(
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
              ),
              SizedBox(
                width: MyUtility(context).width * 0.01,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        widget.eventName,
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF3D3D3D),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        widget.location,
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF3D3D3D),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Text(
                      '${widget.dateFrom} - ${widget.dateTill}',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF3D3D3D),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: widget.onPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      'Learn More',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF3D3D3D),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
