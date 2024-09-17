import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sama/BugReport/reportList/ui/reportHeader.dart';
import 'package:sama/BugReport/reportList/ui/reportItemStyle.dart';
import 'package:sama/components/ToggleSwitch.dart';
import 'package:sama/components/myutility.dart';

class UpdatePermissions extends StatefulWidget {
  const UpdatePermissions({super.key});

  @override
  State<UpdatePermissions> createState() => _UpdatePermissionsState();
}

class _UpdatePermissionsState extends State<UpdatePermissions> {
  // Store the original permission state
  List<Map<String, dynamic>> originalPermissionModules = [
    {'name': 'Super Admin', 'permission': true},
    {'name': 'Centre of Excellence', 'permission': false},
    {'name': 'Member Benefits', 'permission': true},
    {'name': 'Media & Webinars', 'permission': false},
    {'name': 'Professional Development', 'permission': false},
    {'name': 'Events', 'permission': true},
    {'name': 'Communities', 'permission': false},
    {'name': 'Branch Voting', 'permission': false},
    {'name': 'E-store', 'permission': true},
    {'name': 'Member Management', 'permission': false},
  ];

  // Current permission states that will be toggled
  List<Map<String, dynamic>> permissionModules = [];

  @override
  void initState() {
    super.initState();
    // Initialize the current permissionModules with a copy of the original
    permissionModules = List.from(originalPermissionModules);
  }

  void _handleTogglePermission(bool isActive, int index) {
    print(index);
    if (index == 0) {
      print(isActive);
      // If first item is toggled
      if (isActive) {
        // Activate all permissions
        toggleAllPermissions(true);
      } else {
        // Reset all permissions to their original states
        resetToOriginalState(isActive);
      }
    } else {
      // Toggle only the specific item if it's not the first one
      setState(() {
        permissionModules[index]['permission'] = isActive;
      });
    }
  }

  // Function to toggle all permissions to active/inactive
  void toggleAllPermissions(bool isActive) {
    setState(() {
      permissionModules = [
        {'name': 'Super Admin', 'permission': true},
        {'name': 'Centre of Excellences', 'permission': true},
        {'name': 'Member Benefits', 'permission': true},
        {'name': 'Media & Webinars', 'permission': true},
        {'name': 'Professional Development', 'permission': true},
        {'name': 'Events', 'permission': true},
        {'name': 'Communities', 'permission': true},
        {'name': 'Branch Voting', 'permission': true},
        {'name': 'E-store', 'permission': true},
        {'name': 'Member Management', 'permission': true},
      ];
    });
  }

  // Function to reset permissions to their original state
  void resetToOriginalState(bool isActive) {
    setState(() {
      permissionModules = List.from(originalPermissionModules);
      permissionModules[0]['permission'] = isActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(
              color: Colors.black,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    width: MyUtility(context).width * 0.64,
                    height: 30,
                    child: Text(
                      'Permission',
                      textAlign: TextAlign.start,
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
        ),
        ...permissionModules.map((module) {
          return Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              ToggleSwitch(
                isActive: module['permission'],
                onToggle: (isActive) => _handleTogglePermission(
                    isActive, permissionModules.indexOf(module)),
              ),
              SizedBox(
                width: 20.0,
              ),
              SizedBox(
                width: 250,
                height: 30,
                child: Text(
                  module['name'],
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF3D3D3D),
                  ),
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ]),
          );
        }),
      ],
    );
  }
}
