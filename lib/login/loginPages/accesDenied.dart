import 'package:flutter/material.dart';
import 'package:sama/components/utility.dart';

class AccessDenied extends StatefulWidget {
  Function(int) changePage;
  AccessDenied({super.key, required this.changePage});

  @override
  State<AccessDenied> createState() => _AccessDeniedState();
}

class _AccessDeniedState extends State<AccessDenied> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MyUtility(context).width / 3,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Access denied",
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "We're sorry, but access to this service from your IP address has",
                style: TextStyle(fontSize: 17, color: Colors.black),
              ),
              Text(
                "been restricted temporarily. This action may have been taken to",
                style: TextStyle(fontSize: 17, color: Colors.black),
              ),
              Text(
                "protect the security and integrity of our platform.",
                style: TextStyle(fontSize: 17, color: Colors.black),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Need help? CONTACT SAMA",
                style: TextStyle(
                    fontSize: 16, color: const Color.fromARGB(255, 8, 55, 145)),
              ),
            ]));
  }
}
