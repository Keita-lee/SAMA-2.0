import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:password_strength_checker/password_strength_checker.dart';
import 'package:sama/Login/popups/validateDialog.dart';
import 'package:sama/components/CheckCircle.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/passwordStrengthMeter.dart';

import '../components/styleTextfield.dart';

class Security extends StatefulWidget {
  Function(int) changePage;
  Security({super.key, required this.changePage});

  @override
  State<Security> createState() => _SecurityState();
}

class _SecurityState extends State<Security> {
  @override
  Widget build(BuildContext context) {
    // Text controllers
    final password = TextEditingController();
    final passNotifier = ValueNotifier<CustomPassStrength?>(null);
    final passwordCheck = TextEditingController();

    BuildContext? dialogContext;
    bool isMobile = MyUtility(context).width < 600 ? true : false;

    //Dialog for password Validate
    Future openValidatePasswordDialog() => showDialog(
        context: context,
        builder: (context) {
          dialogContext = context;
          return Dialog(
              child: ValidateDialog(
                  description: "Password not Strong Enough",
                  closeDialog: () => Navigator.pop(dialogContext!)));
        });
    //Dialog for profile Save
    Future openUserPasswordDialog() => showDialog(
        context: context,
        builder: (context) {
          dialogContext = context;
          return Dialog(
              child: ValidateDialog(
                  description: "User Password Saved",
                  closeDialog: () => Navigator.pop(dialogContext!)));
        });

    //Dialog for password match check
    Future openValidatePasswordMatchDialog() => showDialog(
        context: context,
        builder: (context) {
          dialogContext = context;
          return Dialog(
              child: ValidateDialog(
                  description: "Passwords do not match",
                  closeDialog: () => Navigator.pop(dialogContext!)));
        });

    updatePassword() {
      if (password.text.isEmpty || passwordCheck.text.isEmpty) {
        return showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: ValidateDialog(
                description: "Please enter a password.",
                closeDialog: () => Navigator.pop(context),
              ),
            );
          },
        );
      }
      if (password.text != passwordCheck.text) {
        return openValidatePasswordMatchDialog();
      }
      if (passNotifier.value == CustomPassStrength.weak) {
        openValidatePasswordDialog();
      } else {
        final FirebaseAuth _auth = FirebaseAuth.instance;

        _auth.currentUser!
            .updatePassword(password.text)
            .whenComplete(() => openUserPasswordDialog())
            .catchError((e) {});

        FirebaseFirestore.instance
            .collection('users')
            .doc(_auth.currentUser!.uid)
            .update({
          'password': password.text,
        });
      }
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Update Password',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.normal),
            ),
            SizedBox(
              height: MyUtility(context).height * 0.05,
            ),
            /*   Container(
              width: MyUtility(context).width * 0.15,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.black,
                ),
              ),
              child: TextField(
                controller: password,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                ),
              ),
            ),*/
            Container(
              width: isMobile
                  ? MyUtility(context).width
                  : MyUtility(context).width / 4,
              height: 45,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                  border: Border.all(
                    color: const Color.fromARGB(255, 51, 51, 51),
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: TextFormField(
                controller: password,
                style: TextStyle(
                  color: Color.fromARGB(255, 153, 147, 147),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                onChanged: (value) {
                  passNotifier.value =
                      CustomPassStrength.calculate(text: value);
                },
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter Here",
                  hintStyle: TextStyle(
                    color: Color.fromARGB(255, 199, 199, 199),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  contentPadding: EdgeInsets.only(
                      left: 15), // {{ edit_1 }} Added left padding
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: isMobile
                  ? MyUtility(context).width
                  : MyUtility(context).width / 4,
              child: TextFieldStyling(
                hintText: 'Confirm Password',
                textfieldController: passwordCheck,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: isMobile
                  ? MyUtility(context).width
                  : MyUtility(context).width / 4,
              child: PasswordStrengthChecker(
                strength: passNotifier,
              ),
            ),
            SizedBox(
              height: MyUtility(context).height * 0.05,
            ),
            SizedBox(
              width: isMobile ? 250 : MyUtility(context).width / 1.62,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: isMobile ? 100 : MyUtility(context).width * 0.05,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xFF174486),
                  ),
                  child: TextButton(
                    onPressed: () {
                      updatePassword();
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MyUtility(context).height * 0.1,
            )
          ],
        ),
      ),
    );
  }
}
