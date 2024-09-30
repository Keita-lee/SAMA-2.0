import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/ToggleSwitch.dart';
import 'package:sama/components/profileTextField.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/components/utility.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/login/popups/validateDialog.dart';

class Createadmin extends StatefulWidget {
  final Function(int) changePageIndex;
  final Map<String, dynamic> memberData;
  const Createadmin(
      {super.key, required this.changePageIndex, required this.memberData});

  @override
  State<Createadmin> createState() => _CreateadminState();
}

class _CreateadminState extends State<Createadmin> {
  final _formKey = GlobalKey<FormState>();
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  bool isLoading = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool showErrorMessage = false;
  List<Map<String, dynamic>> permissions = [
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
    {'name': 'Transactions', 'permission': false},
  ];
  BuildContext? dialogContext;
  List<Map<String, dynamic>> tempPermissions = [];

  Future openDialog(String message) => showDialog(
      context: context,
      builder: (context) {
        dialogContext = context;
        return Dialog(
            child: ValidateDialog(
                description: message,
                closeDialog: () => Navigator.pop(dialogContext!)));
      });

  @override
  void initState() {
    tempPermissions = List.from(permissions);
    setState(() {
      if (widget.memberData.isNotEmpty) {
        tempPermissions = List.from(widget.memberData['permissions']);
        firstNameController.text = widget.memberData['full name'].split(' ')[0];
        lastNameController.text = widget.memberData['full name'].split(' ')[1];
        emailController.text = widget.memberData['email'];
        permissions = List.from(widget.memberData['permissions']);
      } else {
        resetMemberData();
      }
    });

    super.initState();
  }

  void resetMemberData() {
    permissions = [
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
      {'name': 'Transactions', 'permission': false},
    ];
    firstNameController.text = '';
    lastNameController.text = '';
    emailController.text = '';
    passwordController.text = '';
  }

  void submitAdminData() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      setState(() {
        isLoading = true;
        showErrorMessage = false;
      });
      // create new admin
      if (widget.memberData.isEmpty) {
        UserCredential userDocRef = await auth.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        await firestore.collection('users').doc(userDocRef.user!.uid).set({
          'id': userDocRef.user!.uid,
          'userType': 'Admin',
          'firstName': firstNameController.text,
          'lastName': lastNameController.text,
          'email': emailController.text,
          'permissions': permissions,
          'profilePic':
              'https://firebasestorage.googleapis.com/v0/b/sama-959a2.appspot.com/o/images%2Ff06c0480-70e4-11ef-9d61-8de8b2f04cfc.png?alt=media&token=899ec27c-337d-42f3-b6a6-02526cc29066',
        });
        setState(() {
          isLoading = false;
        });

        openDialog('Admin created successfully');
      }
      // update admin
      else {
        await firestore
            .collection('users')
            .doc(widget.memberData['firebaseId'])
            .update({
          'id': widget.memberData['firebaseId'],
          'userType': 'Admin',
          'firstName': firstNameController.text,
          'lastName': lastNameController.text,
          'email': emailController.text,
          'permissions': permissions,
        });
        setState(() {
          isLoading = false;
        });
        openDialog('Admin updated successfully');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        showErrorMessage = true;
      });
      print('Error creating admin: $e');
    }
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
        permissions[index]['permission'] = isActive;
      });
    }
  }

  // Function to toggle all permissions to active/inactive
  void toggleAllPermissions(bool isActive) {
    setState(() {
      tempPermissions = List.from(permissions);
      permissions = [
        {'name': 'Full Access', 'permission': true},
        {'name': 'Centre of Excellences', 'permission': true},
        {'name': 'Member Benefits', 'permission': true},
        {'name': 'Media & Webinars', 'permission': true},
        {'name': 'Professional Development', 'permission': true},
        {'name': 'Events', 'permission': true},
        {'name': 'Communities', 'permission': true},
        {'name': 'Branch Voting', 'permission': true},
        {'name': 'E-store', 'permission': true},
        {'name': 'Member Management', 'permission': true},
        {'name': 'Transactions', 'permission': true},
      ];
    });
  }

  // Function to reset permissions to their original state
  void resetToOriginalState(bool isActive) {
    setState(() {
      permissions = List.from(tempPermissions);
      permissions[0]['permission'] = isActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Admin Details',
                        style: GoogleFonts.openSans(
                            fontSize: 24,
                            color: Color(0xFF174486),
                            fontWeight: FontWeight.bold),
                      ),
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
                      widget.memberData.isEmpty
                          ? ProfileTextField(
                              isRounded: false,
                              isBold: false,
                              hintText: 'Password',
                              description: 'Password',
                              customSize: MyUtility(context).width * 0.32,
                              textFieldType: 'stringType',
                              textfieldController: passwordController)
                          : const SizedBox.shrink(),
                      const SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 50.0,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          'Permissions',
                          style: GoogleFonts.openSans(
                              fontSize: 24,
                              color: Color(0xFF174486),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      ...permissions.map((module) {
                        return Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 10),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ToggleSwitch(
                                  isActive: module['permission'],
                                  onToggle: (isActive) =>
                                      _handleTogglePermission(isActive,
                                          permissions.indexOf(module)),
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
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              StyleButton(
                waiting: isLoading,
                description: "SUBMIT",
                height: 55,
                width: 100,
                onTap: submitAdminData,
              ),
              const SizedBox(
                height: 10.0,
              ),
              showErrorMessage
                  ? const Text(
                      'Something went wrong, please try again. If the problem persists, please contact support.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.red,
                      ),
                    )
                  : const SizedBox.shrink(),
            ],
          )),
    );
  }
}
