import 'package:flutter/material.dart';
import 'package:sama/admin/ElectionsAdmin/ElectionSetup/ElectionSetupComp/BranchSelect.dart';
import 'package:sama/admin/ElectionsAdmin/ElectionSetup/UI/Round1.dart';
import 'package:sama/admin/ElectionsAdmin/ElectionSetup/UI/Round2.dart';
import 'package:sama/admin/ElectionsAdmin/ElectionSetup/UI/Round3.dart';
import 'package:sama/components/utility.dart';

class ElectionSetup extends StatefulWidget {
  const ElectionSetup({super.key});

  @override
  State<ElectionSetup> createState() => _ElectionSetupState();
}

class _ElectionSetupState extends State<ElectionSetup> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyUtility(context).width * 0.75,
      height: MyUtility(context).height * 0.85,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BranchSelect(),
          Round1(),
          Round2(),
          Round3(),
          SizedBox(
            width: MyUtility(context).width * 0.65,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 8, 55, 145),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Text(
                      'Submit for Voting',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
