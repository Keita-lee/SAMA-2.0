import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';

class AdminEventContainer extends StatelessWidget {
  final String memberName;
  final String area;

  const AdminEventContainer({
    Key? key,
    required this.memberName,
    required this.area,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Container(
        width: MyUtility(context).width * 0.75,
        height: MyUtility(context).height * 0.05,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 218, 218, 218),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                memberName,
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF3D3D3D),
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                width: MyUtility(context).width * 0.15,
                child: Text(
                  area,
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF3D3D3D),
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
