import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';

class PageUnderConstruction extends StatefulWidget {
  const PageUnderConstruction({super.key});

  @override
  State<PageUnderConstruction> createState() => _PageUnderConstructionState();
}

class _PageUnderConstructionState extends State<PageUnderConstruction> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color.fromARGB(255, 8, 55, 145),
        width: MyUtility(context).width,
        height: MyUtility(context).height,
        child: Center(
            child: Container(
                width: MyUtility(context).width - 50,
                height: MyUtility(context).height / 1.2,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Column(children: [
                  Image(
                      width: MyUtility(context).width - 80,
                      height: MyUtility(context).height / 1.4,
                      image: AssetImage('images/sama_logo.png')),
                  Text(
                    "Page under contruction",
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                ]))));
  }
}
