import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/AdminTable.dart';
import 'package:sama/components/myutility.dart';
import 'package:google_fonts/google_fonts.dart';

class ManageLicense extends StatefulWidget {
  Map<String, dynamic> customerData;
  List<Map<String, dynamic>> licenses;
  Function closeDialog;
  ManageLicense(
      {super.key,
      required this.licenses,
      required this.customerData,
      required this.closeDialog});

  @override
  State<ManageLicense> createState() => _ManageLicenseState();
}

class _ManageLicenseState extends State<ManageLicense> {
  final firestore = FirebaseFirestore.instance;
  BuildContext? dialogContext;
  void resendLicense() {}

  void resetLicense() {}

  void showDynamicDialog({
    required BuildContext context,
    required String title,
    required String content,
    required VoidCallback onContinue,
    required VoidCallback onCancel,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        dialogContext = context;
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              onPressed: onCancel,
              child: const Text(
                'Cancel',
                style: TextStyle(color: Color(0xFF174486)),
              ),
            ),
            ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll<Color>(Color(0xFF174486))),
              onPressed: onContinue,
              child: const Text(
                'Continue',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MyUtility(context).width * 0.745,
        height: 680,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15), color: Colors.white),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Manage Licence',
                            style: GoogleFonts.openSans(
                                fontSize: 35,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            widget.customerData['name'],
                            style: const TextStyle(
                                fontSize: 20, color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        widget.closeDialog();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 25.0,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20.0),
                AdminTable(
                  columnHeaders: const ['Product Name', 'Qty', 'Amount'],
                  dataList: widget.licenses,
                  actions: [
                    (data) => PopupMenuButton<String>(
                          icon: const Icon(Icons.more_vert),
                          onSelected: (String result) {
                            switch (result) {
                              case 'resend':
                                showDynamicDialog(
                                  context: context,
                                  title: 'Confirmation',
                                  content:
                                      'Are you sure you want to resend the license to this user?',
                                  onContinue: () {
                                    resendLicense();
                                    Navigator.of(context).pop();
                                  },
                                  onCancel: () {
                                    Navigator.of(context).pop();
                                  },
                                );
                                break;
                              case 'reset':
                                showDynamicDialog(
                                  context: context,
                                  title: 'Confirmation',
                                  content:
                                      'Are you sure you want to reset the license for this product?',
                                  onContinue: () {
                                    resetLicense();
                                    Navigator.of(context).pop();
                                  },
                                  onCancel: () {
                                    Navigator.of(context).pop();
                                  },
                                );
                                break;
                            }
                          },
                          itemBuilder: (BuildContext context) {
                            List<PopupMenuEntry<String>> menuItems = [];
                            menuItems.add(const PopupMenuItem<String>(
                              value: 'resend',
                              child: Text('Resend License'),
                            ));
                            menuItems.add(const PopupMenuItem<String>(
                              value: 'reset',
                              child: Text('Reset License'),
                            ));
                            return menuItems;
                          },
                        )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
