import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/admin/transactions/manageProducts/addTrackingDetails.dart';
import 'package:sama/admin/transactions/manageProducts/manageLicense.dart';
import 'package:sama/components/AdminTable.dart';
import 'package:sama/components/email/sendLicenses.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/styleButton.dart';
import 'package:uuid/uuid.dart';

class ViewOrder extends StatefulWidget {
  Map<String, dynamic> customerData;
  List<Map<String, dynamic>> products;
  Function closeDialog;

  ViewOrder({
    super.key,
    required this.customerData,
    required this.closeDialog,
    required this.products,
  });

  @override
  State<ViewOrder> createState() => _ViewOrderState();
}

class _ViewOrderState extends State<ViewOrder> {
  BuildContext? dialogContext;
  final firestore = FirebaseFirestore.instance;
  int activeIndex = 0;
  List<Map<String, dynamic>> licenses = [];
  Map<String, dynamic> selectedProduct = {};
  String selectedTrackingNmr = '';

  void changePageIndex(int index) {
    setState(() {
      activeIndex = index;
    });
  }

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

  Future openLicenseManagement(String id, List<Map<String, dynamic>> licenses,
          String customerName, String customerEmail) =>
      showDialog(
          context: context,
          builder: (context) {
            Map<String, dynamic> selectedTransactionCustomer = {
              'name': customerName,
              'email': customerEmail
            };
            dialogContext = context;
            return Dialog(
                child: ManageLicense(
              customerData: selectedTransactionCustomer,
              licenses: licenses,
              closeDialog: () => Navigator.pop(context),
            ));
          });

  Future<List<Map<String, dynamic>>> getLicenses(
      String productName, String id) async {
    print('getting licenses: ${id}');
    late QuerySnapshot<Map<String, dynamic>> licensesSnapshot;
    String licenseCollection = '';
    if (productName.toLowerCase().contains('ccsa')) {
      licensesSnapshot = await firestore
          .collection('ccsaLicenses')
          .where('accTxid', isEqualTo: id)
          .get();
      licenseCollection = 'ccsaLicenses';
    } else if (productName.toLowerCase().contains('icd10')) {
      licensesSnapshot = await firestore
          .collection('icd10Licenses')
          .where('accTxid', isEqualTo: id)
          .get();
      licenseCollection = 'icd10Licenses';
    } else if (productName.toLowerCase().contains('emdcm')) {
      licensesSnapshot = await firestore
          .collection('emdcmLicenses')
          .where('accTxid', isEqualTo: id)
          .get();
      licenseCollection = 'emdcmLicenses';
    }

    if (licensesSnapshot.docs.isNotEmpty) {
      return licensesSnapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'product license': doc.data()['licencekey'],
          'computer code': doc.data()['computercode'],
          'expiry date': doc.data()['expiryDate'],
          'license collection': licenseCollection
        };
      }).toList();
    } else {
      return [];
    }
  }

  void resendLicense(
      String licenseKey, String productName, String downloadLink) {
    print('resending license: $licenseKey');
    sendLicenses(
        email: 'jessedev07@gmail.com',
        name: widget.customerData['name'].split('\n')[0],
        title: widget.customerData['title'],
        link: downloadLink,
        licenses: licenseKey,
        product: productName);
  }

  void resetLicense(String licenseKey, String id, String collection,
      String productName, String downloadLink) async {
    print('resetting license...');
    try {
      await firestore.collection(collection).doc(id).update({
        'computercode': '',
        'installdate': '',
        'installcount': 0,
      });

      setState(() {
        licenses
            .where((license) => license['licencekey'] == licenseKey)
            .first['computercode'] = '';
      });
    } catch (e) {
      print('error resetting license: $e');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  void redirectToManageLicense(
      String productName, String downloadLink, String id) async {
    try {
      List<Map<String, dynamic>> newLicenses =
          await getLicenses(productName, id);
      setState(() {
        licenses = newLicenses;
        selectedProduct = {'name': productName, 'downloadLink': downloadLink};
      });

      changePageIndex(1);
    } catch (e) {
      print('error getting licenses: $e');
    }
  }

  void redirectToManagePhysical(String productName, String trackingNmr,
      String transactionId, int productId) {
    try {
      print(
          'redirecting to manage physical: firebaseID: $transactionId productId: $productId tracking number: $trackingNmr product name: $productName');
      setState(() {
        selectedProduct = {
          'name': productName,
          'trackingNmr': trackingNmr,
          'firebaseId': transactionId,
          'productId': productId
        };
      });

      changePageIndex(2);
    } catch (e) {
      print('error getting licenses: $e');
    }
  }

  void updateTrackingNumber(String trackingNmr) {
    setState(() {
      selectedProduct['trackingNmr'] = trackingNmr;
    });
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Visibility(
                          visible: activeIndex == 0,
                          child: Text(
                            'View Order',
                            style: GoogleFonts.openSans(
                                fontSize: 35,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Visibility(
                          visible: activeIndex == 1,
                          child: Text(
                            'Manage Product',
                            style: GoogleFonts.openSans(
                                fontSize: 35,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          '${widget.customerData['name'].split('\n')[0]}, ${widget.customerData['name'].split('\n')[1]}',
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
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
              Visibility(
                visible: activeIndex == 0,
                child: AdminTable(
                  columnHeaders: const [
                    'Product Name',
                    'Product Type',
                    'Qty',
                    'Amount'
                  ],
                  dataList: widget.products,
                  actions: [
                    (data) => PopupMenuButton<String>(
                          icon: const Icon(Icons.more_vert),
                          onSelected: (String result) async {
                            switch (result) {
                              case 'manage license':
                                print('redirecting to manage license: $data');
                                redirectToManageLicense(data['product name'],
                                    data['download link'], data['firebaseId']);
                                break;
                              case 'manage product':
                                try {
                                  print(
                                      'redirecting to manage physical poduct: product name ${data['product name']} tracking number: ${data['tracking number']} firebaseId: ${data['firebaseId']} index: ${data['index']}');
                                  redirectToManagePhysical(
                                    data['product name'],
                                    data['tracking number'],
                                    data['firebaseId'],
                                    data['index'],
                                  );
                                } catch (e) {
                                  print(e);
                                }

                                break;
                            }
                          },
                          itemBuilder: (BuildContext context) {
                            List<PopupMenuEntry<String>> menuItems = [];
                            // // Dynamically add menu items based on the user's status
                            if (data['product type'] == 'Licensed Product') {
                              menuItems.add(
                                const PopupMenuItem<String>(
                                  value: 'manage license',
                                  child: Text('Manage License'),
                                ),
                              );
                            }
                            if (data['product type'] == 'Physical Product') {
                              menuItems.add(
                                const PopupMenuItem<String>(
                                  value: 'manage product',
                                  child: Text('Add Tracking Details'),
                                ),
                              );
                            }
                            return menuItems;
                          },
                        )
                  ],
                ),
              ),
              Visibility(
                  visible: activeIndex != 0,
                  child: SizedBox(
                    width: MyUtility(context).width * 0.74,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        StyleButton(
                          description: "BACK",
                          height: 40,
                          width: 80,
                          onTap: () {
                            changePageIndex(0);
                          },
                        ),
                      ],
                    ),
                  )),
              Visibility(
                visible: activeIndex == 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const SizedBox(height: 20.0),
                    AdminTable(
                      columnHeaders: const [
                        'Product License',
                        'Computer Code',
                        'Expiry Date'
                      ],
                      dataList: licenses,
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
                                        resendLicense(
                                            data['product license'],
                                            selectedProduct['name'],
                                            selectedProduct['downloadLink']);
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
                                        print('resetting license: $data');
                                        resetLicense(
                                            data['product license'],
                                            data['id'],
                                            data['license collection'],
                                            selectedProduct['name'],
                                            selectedProduct['downloadLink']);
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
                                menuItems.add(
                                  const PopupMenuItem<String>(
                                    value: 'resend',
                                    child: Text('Resend License'),
                                  ),
                                );
                                if (data['computer code'])
                                  menuItems.add(
                                    const PopupMenuItem<String>(
                                      value: 'reset',
                                      child: Text('Reset License'),
                                    ),
                                  );
                                return menuItems;
                              },
                            )
                      ],
                    ),
                  ],
                ),
              ),
              // Visibility(
              //   visible: activeIndex == 2,
              //   child: AddTrackingDetails(
              //     licenses: licenses,
              //     selectedProduct: selectedProduct,
              //     updateTrackingNumber: updateTrackingNumber,
              //     customerData: widget.customerData,
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
