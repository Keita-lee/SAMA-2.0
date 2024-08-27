import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';

class CpdHeader extends StatelessWidget {
  const CpdHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          color: Colors.black,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 80,
                height: 30,
                child: Text(
                  'State',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF3D3D3D),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: MyUtility(context).width * 0.27,
                height: 30,
                child: Text(
                  'Title',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF3D3D3D),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Spacer(),
              SizedBox(
                width: 140,
                height: 30,
                child: Text(
                  'Actions',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF3D3D3D),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Divider(
          color: Colors.black,
        ),
      ],
    );
  }
}
