import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';

class Test extends StatefulWidget {
  final VoidCallback closeDialog;
  final String id;
  Test({super.key, required this.closeDialog, required this.id});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MyUtility(context).width / 5,
        height: MyUtility(context).height / 2,
        decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Color.fromARGB(255, 8, 55, 145),
                width: 2.0,
              ),
            ),
            borderRadius: BorderRadius.circular(15),
            color: Color.fromARGB(255, 255, 255, 255)),
        child: SingleChildScrollView(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                Text(
                  'Media & Podcast',
                  style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF174486),
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      widget.closeDialog();
                    },
                    child: Icon(Icons.cancel),
                  ),
                ),
              ],
            ),
          ),
        ])));
  }
}
