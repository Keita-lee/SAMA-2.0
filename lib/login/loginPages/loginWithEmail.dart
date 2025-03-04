import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/Login/loginPages/register.dart';
import 'package:sama/Login/popups/validateDialog.dart';
import 'package:sama/components/email/sendBugReport.dart';

import 'package:sama/components/email/sendOtp.dart';
import 'package:sama/components/email/sendPasswordResetLink.dart';
import 'package:sama/components/mobile/components/Themes/font_text.dart';
import 'package:sama/components/mobile/Navbar/footer.dart';
import 'package:sama/components/mobile/Navbar/navbar.dart';
import 'package:sama/components/passwordStrengthMeter.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/components/styleTextfield.dart';

import 'package:sama/components/utility.dart';
import 'package:password_strength_checker/password_strength_checker.dart';
import 'package:sama/homePage/PostLoginLandingPage.dart';
import 'package:sama/login/loginPages.dart';
import 'package:sama/login/registerFullProfile.dart';
import 'package:sama/utils/tokenManager.dart';
import 'package:http/http.dart' as http;

import '../../components/email/payments/onlinePayment.dart';
import 'package:sama/utils/trustedEmailsUtil.dart';

enum SingingCharacter { memberNumber, email }

class LoginWithEmail extends StatefulWidget {
  final Function(Map<String, dynamic>) updateMemberData;
  final Function(int) changePage;
  final Function(String) getEmail;
  final Function(String) getEmailChangeType;
  const LoginWithEmail(
      {super.key,
      required this.changePage,
      required this.getEmail,
      required this.updateMemberData,
      required this.getEmailChangeType});

  @override
  State<LoginWithEmail> createState() => _LoginWithEmailState();
}

class _LoginWithEmailState extends State<LoginWithEmail> {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  // Text controllers
  final email = TextEditingController(text: '');
  bool isLoading = false;

  String validateText = "";

  bool showRegisterBorder = false;
  bool showForgotPasswordBorder = false;
  bool showForgotSamaBorder = false;
  bool showNonMemberBorder = false;
  bool showSamaAccountCreate = false;

  BuildContext? dialogContext;

//Update state of text
  updateStateText(value) {
    setState(() {
      validateText = value;
    });
  }

  //Dialog for validate  form
  Future openValidateDialog() => showDialog(
      context: context,
      builder: (context) {
        dialogContext = context;
        return Dialog(
            child: ValidateDialog(
                description: "User does not exist",
                closeDialog: () => Navigator.pop(dialogContext!)));
      });

  //Dialog for validate  form
  Future openPasswordResetDialog() => showDialog(
        context: context,
        builder: (context) {
          dialogContext = context;
          return Dialog(
            child: ValidateDialog(
              description:
                  "We see you have not logged in on our platform yet. Please click 'OK' to reset your password.",
              closeDialog: () {
                Navigator.pop(dialogContext!);
                widget.changePage(14);
              },
            ),
          );
        },
      );

  Future<String?> createUser(Map<String, dynamic> memberData) async {
    try {
      UserCredential userDocRef = await auth.createUserWithEmailAndPassword(
          email: memberData['email_sama'], password: 'Cp123456');

      await firestore.collection('users').doc(userDocRef.user!.uid).set({
        "id": userDocRef.user!.uid,
        "title": memberData['title'],
        "initials": memberData['init'],
        "landline": '',
        "profilePic":
            'https://firebasestorage.googleapis.com/v0/b/sama-959a2.appspot.com/o/images%2Fistockphoto-1495088043-612x612.jpg?alt=media&token=6355d1a2-7572-4221-99a3-a2823af52372',
        "gender": '',
        "race": '',
        "dob": '',
        "passportNumber": '',
        "practiceNumber": '',
        "univercityQualification": '',
        "univercityName": '',
        "qualificationYear": '',
        "qualificationMonth": '',
        "password": '',
        "userType": "user",
        "membershipAdded": false,
        "profilePicView": '',
        "profileView": '',
        'firstName': memberData['first_name'],
        'lastName': memberData['surname'],
        'mobileNo': memberData['cell_no'],
        'email': memberData['email_sama'],
        'samaNo': int.parse(memberData['sama_no']),
        'idNumber': memberData['id_no'],
        'hpcsaNumber': memberData['hpc_full_no'],
        'membershipPaid': memberData['membership_paid'],
        'samaMember': memberData['sama_member'],
        'brnchCde': memberData['brnch_cde'],
        'brnchName': memberData['brnch_name'],
        'status': 'Active',
        'loggedIn': true
      });

      return userDocRef.user!.uid;
    } catch (e) {
      print('Error creating user: $e');
      updateStateText('Record not found. Please try again');
      return null;
    }
  }

  Future<void> loginUserFirstTime(String? id) async {
    widget.getEmail((email.text).toLowerCase());
    widget.getEmailChangeType('passwordResetPage');
    String randomOtp = Random().nextInt(999999).toString().padLeft(6, '0');
    await sendOtp(otp: randomOtp, email: (email.text).toLowerCase());

    if (id != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .update({'loggedIn': true});
    }

    setState(() {
      isLoading = false;
    });
    // redirect user to reset password
    // widget.changePage(14);
    openPasswordResetDialog();
  }

  Future<Map<String, dynamic>> checkOracleDb(String email) async {
    final TokenManager tokenManager = TokenManager();
    String basicAuth = tokenManager.basicAuth();

    http.Response response = await http.get(
        Uri.parse(
            'https://sama-api.onrender.com/get-clients?email_sama=$email'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': basicAuth,
        });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data.isNotEmpty) {
        List items = data['items'];
        if (items.isNotEmpty) {
          print(items[0]);
          return items[0];
        } else {
          return {};
        }
      } else {
        return {};
      }
    }

    return {};
  }

  Future<Map<String, dynamic>> checkSamaNo(String samaNo) async {
    final TokenManager tokenManager = TokenManager();
    String basicAuth = tokenManager.basicAuth();

    http.Response response = await http.get(
        Uri.parse('https://sama-api.onrender.com/get-client/$samaNo'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': basicAuth,
        });

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    return {};
  }

  sendResetEmail(String email, String name) async {
    TokenManager tokenManager = TokenManager();
    String basicAuth = tokenManager.basicAuth();
    String resetLink = '';
    // Get reset password email
    http.Response response = await http.get(
        Uri.parse(
            'https://sama-api.onrender.com/get-reset-link?email=${email}'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': basicAuth,
        });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      resetLink = data['resetLink'];

      sendPasswordResetLink(email: email, name: name, resetLink: resetLink);
      print(resetLink);
    }
  }

//Check if email exists and continue
  checkEmail() async {
    if (isLoading) return;
    try {
      setState(() {
        isLoading = true;
      });

      final firestore = FirebaseFirestore.instance;
      widget.getEmail((email.text).toLowerCase());
      updateStateText("");
      final users = await firestore
          .collection('users')
          .where('email', isEqualTo: (email.text).toLowerCase())
          .get();

      bool isTrustedEmail = TrustedEmails.emails.contains(email.text);
      if (isTrustedEmail) {
        return await widget.changePage(1);
      }
      //Check if user exists in Oracle Db and Firestore
      Map<String, dynamic> oracleUser =
          await checkOracleDb((email.text).toLowerCase());
      bool foundOnOracleDb = oracleUser.isNotEmpty;
      bool foundInFirebase = users.docs.isNotEmpty;

      //If admin by pass all validators
      if (foundInFirebase) {
        if (users.docs[0].data().containsKey('userType')) {
          if (users.docs[0]['userType'] == "Admin" ||
              users.docs[0]['userType'] == "NonMember") {
            return await widget.changePage(1);
          }
        }
      }

      print(
          'foundOnOracleDb: $foundOnOracleDb, foundInFirebase: $foundInFirebase');

      // user is in firebase and is sama member
      if (foundInFirebase && email.text != "" && foundOnOracleDb) {
        if (users.docs.first.data()['status'] == 'Active') {
          if (users.docs.first.data()['loggedIn'] == true) {
            widget.changePage(1);
          } else {
            // Send reset password email
            // sendResetEmail(email.text,
            //     '${users.docs.first.data()['firstName']} ${users.docs.first.data()['lastName']}');
            loginUserFirstTime(users.docs.first.id);
          }
        } else {
          updateStateText(
              "Your account is pending approval. You will receive an email once approved");
        }
      }
      //user is in firebase and is not sama member - treated as non-member
      else if (foundInFirebase && !foundOnOracleDb) {
        updateStateText('Record not found, please try again.');
      }
      // user is in not firebase but is a sama member - needs to create an account
      else if (!foundInFirebase && foundOnOracleDb) {
        // updateStateText(
        //     "You are not registered on this site yet. Please register and try again.");
        String? id = await createUser(oracleUser);
        await loginUserFirstTime(id);
        // widget.updateMemberData({
        //   "title": oracleUser['title'] ?? '',
        //   "email": email.text,
        //   "firstName": '',
        //   "lastName": '',
        //   "cell": "",
        //   "samaNo": "",
        //   "idNo": "",
        //   "hpcsa": "",
        // });
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => Material(
        //       child: LoginPages(
        //         pageIndex: 19,
        //       ),
        //     ),
        //   ),
        // );
        // setState(() {
        //   showSamaAccountCreate = true;
        // });
      }
      // user is in not firebase and is not sama member - needs to create an account
      else if (!foundInFirebase && !foundOnOracleDb) {
        updateStateText("Record not found, please try again.");
      } else {
        updateStateText(
            "Error: Unknown email address. Check again or try using your SAMA member number.");
        // openValidateDialog();
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('error login: $e');
    }
  }

  //Check if member exists and continue
  checkMemberNumber() async {
    if (isLoading) return;

    updateStateText("");
    setState(() {
      isLoading = true;
    });

    Map<String, dynamic> member = await checkSamaNo(email.text);
    if (member.isEmpty) {
      setState(() {
        isLoading = false;
      });
      updateStateText(
          "The SAMA member number ${email.text} is not registered on this site. If you are unsure of your SAMA member number, try your email address instead.");
      return;
    }
    List data = member['items'];
    print(data.first);

    final users = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: (data[0]['email_sama']).toLowerCase())
        .get();

    updateStateText("");

    widget.getEmail(data.first['email_sama'].toLowerCase());

    bool foundonOracleDb = data.isNotEmpty;
    bool foundInFirebase = users.docs.isNotEmpty;
    print(
        'foundOnOracleDb: $foundonOracleDb, foundInFirebase: $foundInFirebase');

    if (!foundInFirebase) {
      setState(() {
        isLoading = false;
      });
      String? id = await createUser(data.first);
      await loginUserFirstTime(id);
      return;
    }

    if (foundonOracleDb &&
        foundInFirebase &&
        users.docs.first['status'] == 'Active') {
      if (users.docs.first.data()['loggedIn'] == true) {
        widget.changePage(1);
      } else {
        // Send email with reset link
        // sendResetEmail(users.docs.first['email'],
        //     '${data.first['firstName']} ${data.first['surname']}');

        loginUserFirstTime(users.docs.first.id);
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  getUserDetails() async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (doc.exists) {
      if (doc.get('hpcsaNumber') != null && doc.get('status') == "Active") {
        setState(() {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Material(
                        child: Material(
                            child: PostLoginLandingPage(
                          userId: FirebaseAuth.instance.currentUser!.uid,
                          activeIndex: 0,
                        )),
                      )));
        });
      } else {
        FirebaseAuth.instance.signOut();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Material(
                      child: Material(child: LoginPages()),
                    )));
      }
    }
  }

//Check firebase if user valid
  checkUserState() async {
    getUserDetails();
  }

  @override
  void initState() {
    checkUserState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (MyUtility(context).width < 600) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Navbar(
                userType: "",
                onButton1Pressed: (value) {},
                onButton2Pressed: (value) {},
                onDropdownChanged: (value) {},
                visible: false,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Text(
                    'Login',
                    style: FontText(context).mediumBlue,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MyUtility(context).width - 25,
                    child: TextFieldStyling(
                      hintText: 'Please add SAMA number or email Address',
                      textfieldController: email,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: StyleButton(
                      waiting: isLoading,
                      description: "PROCEED",
                      height: 45,
                      width: 85,
                      onTap: () {
                        if (email.text.contains("@")) {
                          checkEmail();
                        } else {
                          checkMemberNumber();
                        }
                      },
                    ),
                  ),
                  Text(
                    validateText,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    "Need help?",
                    style: FontText(context).bodyMediumBlack,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      widget.changePage(11);
                    },
                    child: Text("Help me retrieve my SAMA Number ",
                        style: FontText(context).mediumlinksBlue),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      widget.changePage(2);
                    },
                    child: Text("Reset my password ",
                        style: FontText(context).mediumlinksBlue),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Are you a member and dont have a profile ?",
                    style: FontText(context).bodyMediumBlack,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      widget.changePage(9);
                    },
                    child: Text("Create one here",
                        style: FontText(context).mediumlinksBlue),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Footer(),
            ],
          ),
        ),
      );
    } else {
      return Container(
        width: MyUtility(context).width / 1.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                text: "Login using your ",
                style: GoogleFonts.openSans(
                  fontSize: 16,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.5,
                ),
                children: [
                  TextSpan(
                    text: "SAMA number",
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: -0.5,
                    ),
                  ),
                  TextSpan(
                    text: " or ",
                    style: GoogleFonts.openSans(
                      fontSize: 16,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.5,
                    ),
                  ),
                  TextSpan(
                    text: "Email address",
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: -0.5,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Focus(
                onKeyEvent: (node, event) {
                  if (event.logicalKey == LogicalKeyboardKey.enter) {
                    if (email.text.contains("@")) {
                      return checkEmail();
                    } else {
                      return checkMemberNumber();
                    }
                  } else {
                    return KeyEventResult.ignored;
                  }
                },
                child: Row(
                  children: [
                    SizedBox(
                      width: MyUtility(context).width * 0.3,
                      child: TextFieldStyling(
                        hintText: 'Please add SAMA number or email Address',
                        textfieldController: email,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: StyleButton(
                        waiting: isLoading,
                        description: "PROCEED",
                        height: 55,
                        width: 100,
                        onTap: () {
                          if (email.text.contains("@")) {
                            checkEmail();
                          } else {
                            checkMemberNumber();
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              validateText,
              style: TextStyle(
                fontSize: 14,
                color: Colors.red,
              ),
            ),
            showSamaAccountCreate
                ? Container(
                    margin: const EdgeInsets.only(bottom: 10.0, top: 10.0),
                    child: Column(
                      children: [
                        const Text('You are not registered on this site yet.'),
                        const SizedBox(height: 15.0),
                        Row(
                          children: [
                            Text('Click',
                                style: GoogleFonts.openSans(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.5,
                                )),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Material(
                                                child: LoginPages(
                                              pageIndex: 19,
                                            ))));
                              },
                              child: Text(
                                " here ",
                                style: GoogleFonts.openSans(
                                  decoration: showNonMemberBorder == true
                                      ? TextDecoration.underline
                                      : TextDecoration.none,
                                  decorationColor:
                                      Color.fromRGBO(0, 159, 158, 1),
                                  decorationThickness: 2,
                                  letterSpacing: -0.5,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: const Color.fromRGBO(0, 159, 158, 1),
                                ),
                              ),
                            ),
                            Text('to continue your registration process',
                                style: GoogleFonts.openSans(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: -0.5,
                                )),
                          ],
                        ),
                      ],
                    ),
                  )
                : SizedBox.shrink(),
            Text(
              "Need help?",
              style: GoogleFonts.openSans(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                letterSpacing: -0.5,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            InkWell(
              onTap: () {
                widget.changePage(11);
              },
              onHover: (hovered) {
                setState(() {
                  showForgotSamaBorder = hovered;
                });
              },
              child: Text(
                "Help me retrieve my SAMA Number",
                style: GoogleFonts.openSans(
                  decoration: showForgotSamaBorder == true
                      ? TextDecoration.underline
                      : TextDecoration.none,
                  decorationColor: Color.fromRGBO(0, 159, 158, 1),
                  decorationThickness: 2,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.5,
                  fontSize: 16,
                  color: const Color.fromRGBO(0, 159, 158, 1),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                widget.changePage(2);
              },
              onHover: (hovered) {
                setState(() {
                  showForgotPasswordBorder = hovered;
                });
              },
              child: Text(
                "Reset my password",
                style: GoogleFonts.openSans(
                  decoration: showForgotPasswordBorder == true
                      ? TextDecoration.underline
                      : TextDecoration.none,
                  decorationColor: Color.fromRGBO(0, 159, 158, 1),
                  decorationThickness: 2,
                  fontWeight: FontWeight.w500,
                  letterSpacing: -0.5,
                  fontSize: 16,
                  color: const Color.fromRGBO(0, 159, 158, 1),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Text(
                  'Never logged in before? ',
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.5,
                  ),
                ),
                InkWell(
                  onTap: () {
                    widget.changePage(9);
                  },
                  onHover: (hovered) {
                    setState(() {
                      showNonMemberBorder = hovered;
                    });
                  },
                  child: Text(
                    "Register here",
                    style: GoogleFonts.openSans(
                      decoration: showNonMemberBorder == true
                          ? TextDecoration.underline
                          : TextDecoration.none,
                      decorationColor: Color.fromRGBO(0, 159, 158, 1),
                      decorationThickness: 2,
                      letterSpacing: -0.5,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: const Color.fromRGBO(0, 159, 158, 1),
                    ),
                  ),
                ),
                Text(
                  'to create a profile.',
                  style: GoogleFonts.openSans(
                    fontSize: 16,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            const Text(
              'v1.0.1.3',
              style: TextStyle(
                  fontSize: 12, color: Color.fromARGB(255, 122, 122, 122)),
            )
          ],
        ),
      );
    }
  }
}
