import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';

class MoreContainer extends StatefulWidget {
  final String catagoryname;
  final String image;
  final String catagorytitle;
  final String textbutton;
  final VoidCallback onpress;

  const MoreContainer(
      {super.key,
      required this.catagoryname,
      required this.image,
      required this.catagorytitle,
      required this.textbutton,
      required this.onpress});

  @override
  State<MoreContainer> createState() => _MoreContainerState();
}

class _MoreContainerState extends State<MoreContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyUtility(context).width / 5.5,
      height: MyUtility(context).height * 0.28,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Color(0xFFD1D1D1),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.catagoryname,
                  style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFF174486),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: MyUtility(context).height * 0.02,
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      image: DecorationImage(
                        image: AssetImage(widget.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Text(
                  widget.catagorytitle,
                  style: TextStyle(
                      color: Colors.grey.shade600,
                      letterSpacing: -0.05,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0),
                ),
              ],
            ),
            SizedBox(
              height: MyUtility(context).height * 0.025,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                onTap: widget.onpress,
                behavior: HitTestBehavior.translucent,
                child: Text(
                  widget.textbutton,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    letterSpacing: -0.05,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.5,
                    decoration: TextDecoration.underline, // Underline text
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
