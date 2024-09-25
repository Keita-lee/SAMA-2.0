import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/components/email/sendOrderTrackingDetails.dart';
import 'package:sama/components/profileTextField.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/components/utility.dart';
import 'package:sama/login/popups/validateDialog.dart';

class AddTrackingDetails extends StatefulWidget {
  List<Map<String, dynamic>> products;
  String transactionId;
  Function(String, String) updateTrackingNumber;
  String trackingNumber;
  Map<String, dynamic> customerData;
  VoidCallback closeDialog;
  String orderRef;
  AddTrackingDetails({
    super.key,
    required this.products,
    required this.transactionId,
    required this.trackingNumber,
    required this.updateTrackingNumber,
    required this.customerData,
    required this.closeDialog,
    required this.orderRef,
  });

  @override
  State<AddTrackingDetails> createState() => _AddTrackingDetailsState();
}

class _AddTrackingDetailsState extends State<AddTrackingDetails> {
  final firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController trackingNmrController = TextEditingController();
  bool isLoading = false;
  BuildContext? dialogContext;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.trackingNumber.isNotEmpty) {
      trackingNmrController.text = widget.trackingNumber;
    }
  }

  Future openValidateDialog(String message) => showDialog(
      context: context,
      builder: (context) {
        dialogContext = context;
        return Dialog(
            child: ValidateDialog(
                description: message,
                closeDialog: () => Navigator.pop(dialogContext!)));
      });

  Future<void> saveTrackingNumber() async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() {
          isLoading = true;
        });
        DocumentReference transactionRef = await firestore
            .collection('storeHistory')
            .doc(widget.transactionId);

        // Update the whole products array back in Firestore
        await transactionRef
            .update({'trackingNmr': trackingNmrController.text});

        openValidateDialog('Tracking number saved');
        widget.updateTrackingNumber(
            widget.transactionId, trackingNmrController.text);

        // sendOrderTrackingDetails(
        //     email: widget.customerData['email'],
        //     trackingNmr: trackingNmrController.text,
        //     title: widget.customerData['title'],
        //     name: widget.customerData['name']);

        setState(() {
          isLoading = false;
        });
      } catch (e) {
        print('error saving tracking number: $e');
        openValidateDialog('Something went wrong. Please try again.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MyUtility(context).width * 0.45,
      height: 500,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MyUtility(context).width * 0.35,
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
              const SizedBox(
                height: 20,
              ),
              Text(
                'Tracking Details',
                style: GoogleFonts.openSans(
                    fontSize: 24,
                    color: const Color(0xFF174486),
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                '${widget.customerData['name'].split('\n')[0]}, ${widget.customerData['name'].split('\n')[1]}',
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Order: ${widget.orderRef}',
                style: GoogleFonts.openSans(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    ProfileTextField(
                        customSize: MyUtility(context).width / 6,
                        description: "Tracking Number:",
                        textfieldController: trackingNmrController,
                        textFieldType: "stringType"),
                    SizedBox(
                      height: 15,
                    ),
                    StyleButton(
                      waiting: isLoading,
                      description: "Save",
                      height: 55,
                      width: 125,
                      onTap: () {
                        saveTrackingNumber();
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
