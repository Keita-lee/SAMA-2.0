import 'package:flutter/material.dart';
import 'package:sama/admin/ElectionsAdmin/ElectionSetup/ElectionSetupComp/BranchSelect.dart';
import 'package:sama/admin/ElectionsAdmin/ElectionsMange/ElectrionsManageComp/NominatedMembers.dart';
import 'package:sama/components/myutility.dart';

class ElectionsManageEvent extends StatefulWidget {
  const ElectionsManageEvent({super.key});

  @override
  State<ElectionsManageEvent> createState() => _ElectionsManageEventState();
}

class _ElectionsManageEventState extends State<ElectionsManageEvent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyUtility(context).width * 0.75,
      height: MyUtility(context).height * 1.1,
      child: Column(
        children: [
          SizedBox(
            width: MyUtility(context).width,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  'Areas Currently in Election',
                  style: TextStyle(
                    fontSize: 32,
                    color: Color(0xFF3D3D3D),
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: SizedBox(
              width: MyUtility(context).width * 0.72,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: BranchSelect(),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(
                        'Round 1 Elections',
                        style: TextStyle(
                          fontSize: 24,
                          color: Color(0xFF3D3D3D),
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Container(
                      width: MyUtility(context).width * 0.55,
                      height: MyUtility(context).height * 0.06,
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
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12, right: 12),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Branch',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFF3D3D3D),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'EXP Data: 12/05/2020',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFF3D3D3D),
                                  fontWeight: FontWeight.normal,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '21 Days Left',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xFF3D3D3D),
                                  fontWeight: FontWeight.normal,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: MyUtility(context).width * 0.72,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  'Nominated Members',
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFF3D3D3D),
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
              width: MyUtility(context).width * 0.74,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  NominatedMembers(),
                ],
              ))
        ],
      ),
    );
  }
}
