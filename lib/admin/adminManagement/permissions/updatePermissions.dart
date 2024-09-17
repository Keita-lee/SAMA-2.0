import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sama/BugReport/reportList/ui/reportHeader.dart';
import 'package:sama/BugReport/reportList/ui/reportItemStyle.dart';
import 'package:sama/components/ToggleSwitch.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/profileTextField.dart';

class UpdatePermissions extends StatefulWidget {
  Map<String, dynamic> member;
  UpdatePermissions({super.key, required this.member});

  @override
  State<UpdatePermissions> createState() => _UpdatePermissionsState();
}

class _UpdatePermissionsState extends State<UpdatePermissions> {
  final _firestore = FirebaseFirestore.instance;
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // Store the original permission state
  List<Map<String, dynamic>> originalPermissionModules = [
    {'name': 'Full Access', 'permission': false},
    {'name': 'Centre of Excellence', 'permission': false},
    {'name': 'Member Benefits', 'permission': false},
    {'name': 'Media & Webinars', 'permission': false},
    {'name': 'Professional Development', 'permission': false},
    {'name': 'Events', 'permission': false},
    {'name': 'Communities', 'permission': false},
    {'name': 'Branch Voting', 'permission': false},
    {'name': 'E-store', 'permission': false},
    {'name': 'Member Management', 'permission': false},
  ];

  // Current permission states that will be toggled
  List<Map<String, dynamic>> permissionModules = [
    {'name': 'Full Access', 'permission': false},
    {'name': 'Centre of Excellence', 'permission': false},
    {'name': 'Member Benefits', 'permission': false},
    {'name': 'Media & Webinars', 'permission': false},
    {'name': 'Professional Development', 'permission': false},
    {'name': 'Events', 'permission': false},
    {'name': 'Communities', 'permission': false},
    {'name': 'Branch Voting', 'permission': false},
    {'name': 'E-store', 'permission': false},
    {'name': 'Member Management', 'permission': false},
  ];

  @override
  void initState() {
    super.initState();
    // Initialize the current permissionModules with a copy of the original
    originalPermissionModules = List.from(widget.member['permissions']);
    permissionModules = List.from(widget.member['permissions']);
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
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileTextField(
                  isRounded: false,
                  isBold: false,
                  hintText: 'First Name',
                  description: 'First Name',
                  customSize: MyUtility(context).width * 0.32,
                  textFieldType: 'stringType',
                  textfieldController: firstNameController),
              const SizedBox(
                height: 10.0,
              ),
              ProfileTextField(
                  isRounded: false,
                  isBold: false,
                  hintText: 'Last Name',
                  description: 'Last Name',
                  customSize: MyUtility(context).width * 0.32,
                  textFieldType: 'stringType',
                  textfieldController: lastNameController),
              const SizedBox(
                height: 10.0,
              ),
              ProfileTextField(
                  isRounded: false,
                  isBold: false,
                  hintText: 'Email',
                  description: 'Email',
                  customSize: MyUtility(context).width * 0.32,
                  textFieldType: 'stringType',
                  textfieldController: emailController),
              const SizedBox(
                height: 10.0,
              ),
              ProfileTextField(
                  isRounded: false,
                  isBold: false,
                  hintText: 'Password',
                  description: 'Password',
                  customSize: MyUtility(context).width * 0.32,
                  textFieldType: 'stringType',
                  textfieldController: passwordController),
              const SizedBox(
                height: 10.0,
              ),
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
      ),
    );
  }
}
