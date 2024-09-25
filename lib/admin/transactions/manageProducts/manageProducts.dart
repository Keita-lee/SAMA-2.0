import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sama/admin/transactions/manageProducts/addTrackingDetails.dart';
import 'package:sama/admin/transactions/manageProducts/manageLicense.dart';
import 'package:sama/admin/transactions/manageProducts/viewOrder.dart';
import 'package:sama/components/AdminTable.dart';
import 'package:intl/intl.dart';

class Manageproducts extends StatefulWidget {
  const Manageproducts({super.key});

  @override
  State<Manageproducts> createState() => _ManageproductsState();
}

class _ManageproductsState extends State<Manageproducts> {
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  List<Map<String, dynamic>> transactionList = [];
  List<Map<String, dynamic>> selectedTransactionLicenses = [];
  Map<String, dynamic> selectedTransactionCustomer = {};
  bool isLoading = true;
  String searchResult = '';
  BuildContext? dialogContext;
  @override
  void initState() {
    super.initState();
    getTransactionData();
  }

  Future<void> getTransactionData() async {
    try {
      QuerySnapshot<Map<String, dynamic>> transactionsSnapshot =
          await firestore.collection('storeHistory').get();
      if (transactionsSnapshot.docs.isEmpty) {
        setState(() {
          isLoading = false;
        });
        return;
      } else {
        List<Map<String, dynamic>> tempTransactions = [];

        for (var transaction in transactionsSnapshot.docs) {
          Timestamp timestamp = transaction['date'];
          DateTime date = timestamp.toDate();
          String formattedDate = DateFormat('d MMM yyyy').format(date);
          DocumentSnapshot customer = await firestore
              .collection('users')
              .doc(transaction['user'])
              .get();
          String customerName = customer.exists
              ? '${customer['firstName']} ${customer['lastName']}'
              : '';
          String trackingNumber = transaction.data().containsKey('trackingNmr')
              ? transaction['trackingNmr']
              : '';
          String status = transaction.data().containsKey('status')
              ? transaction['status']
              : 'Active';
          bool hasPhysicalProducts = false;
          // check status
          if (status == 'Active') {
            for (var product in transaction['products']) {
              if (product['productType'] == 'Physical Product') {
                hasPhysicalProducts = true;
                // Check if the product has a tracking number
                if (trackingNumber == '') {
                  // If the product does not have a tracking number, the item has not yet been shipped
                  status = 'Active Not Shipped';
                }
              }
            }
          }

          String email = customer.exists ? customer['email'] : '';
          String mobile = customer.exists ? customer['mobileNo'] : '';
          String title = customer.exists ? customer['title'] : '';

          tempTransactions.add({
            'firebaseId': transaction.id,
            'products':
                List<Map<String, dynamic>>.from(transaction['products']),
            'date': formattedDate,
            'customer': '$customerName \n$email \n$mobile',
            'customerTitle': title,
            'reference': transaction['paymentRef'],
            'hasPhysicalProducts': hasPhysicalProducts,
            'status': status,
            'trackingNmr': trackingNumber,
          });
        }
        setState(() {
          isLoading = false;
          transactionList = tempTransactions;
        });
      }
    } catch (e) {
      print('error fetching transactions: $e');
      setState(() {
        isLoading = false;
      });
    }
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
              child: Text(
                'Cancel',
                style: TextStyle(color: Color(0xFF174486)),
              ),
              onPressed: onCancel,
            ),
            ElevatedButton(
              child: Text(
                'Continue',
                style: TextStyle(color: Colors.white),
              ),
              style: const ButtonStyle(
                  backgroundColor:
                      WidgetStatePropertyAll<Color>(Color(0xFF174486))),
              onPressed: onContinue,
            ),
          ],
        );
      },
    );
  }

  Future openViewOrder(String id, Map<String, dynamic> customerData,
          List<Map<String, dynamic>> products) =>
      showDialog(
          context: context,
          builder: (context) {
            dialogContext = context;

            return Dialog(
                child: ViewOrder(
              customerData: customerData,
              products: products.asMap().entries.map((entry) {
                int index = entry.key; // The current index
                var product = entry.value; // The current product
                print(product);

                Map<String, dynamic> productData = {
                  'index': index,
                  'firebaseId': id,
                  'product name': product['productName'],
                  'qty': product['quantity'].toString(),
                  'amount': product['productPrice'],
                  'product type': product['productType'],
                  'download link': product['downloadLink'],
                };

                return productData;
              }).toList(),
              closeDialog: () => Navigator.pop(context),
            ));
          });

  void updateTracking(String id, String trackingNmr) {
    var transactionToUpdate = transactionList
        .firstWhere((transaction) => transaction['firebaseId'] == id);
    setState(() {
      transactionToUpdate['trackingNmr'] = trackingNmr;
      transactionToUpdate['status'] = 'Active';
    });
  }

  Future openAddTracking(
          String id,
          Map<String, dynamic> customerData,
          List<Map<String, dynamic>> products,
          String ref,
          String trackingNmr) =>
      showDialog(
          context: context,
          builder: (context) {
            dialogContext = context;

            return Dialog(
                child: AddTrackingDetails(
              updateTrackingNumber: updateTracking,
              trackingNumber: trackingNmr,
              transactionId: id,
              orderRef: ref,
              customerData: customerData,
              products: products.asMap().entries.map((entry) {
                int index = entry.key;
                var product = entry.value;
                Map<String, dynamic> productData = {
                  'index': index,
                  'firebaseId': id,
                  'product name': product['productName'],
                  'qty': product['quantity'].toString(),
                  'amount': product['productPrice'],
                  'product type': product['productType'],
                  'download link': product['downloadLink'],
                };

                if (product.containsKey('trackingNmr')) {
                  productData.putIfAbsent(
                      'tracking number', () => product['trackingNmr']);
                }
                return productData;
              }).toList(),
              closeDialog: () => Navigator.pop(context),
            ));
          });

  Future<void> voidTransaction(String id, String status) async {
    try {
      setState(() {
        isLoading = true;
      });

      await firestore.collection('storeHistory').doc(id).update({
        'status': 'Inactive',
      });

      setState(() {
        transactionList
            .where((transaction) => transaction['firebaseId'] == id)
            .first['status'] = 'Inactive';
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('error updating member status: $e');
    }
  }

  Future<void> confirmTransaction(String id, String status) async {
    try {
      setState(() {
        isLoading = true;
      });

      await firestore.collection('storeHistory').doc(id).update({
        'status': 'Active',
      });

      setState(() {
        transactionList
            .where((transaction) => transaction['firebaseId'] == id)
            .first['status'] = 'Active';
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('error updating member status: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AdminTable(
        searchResult: searchResult,
        columnHeaders: const [
          'Date',
          'Customer',
          'Reference',
          'Status',
        ],
        dataList: transactionList,
        waiting: isLoading,
        actions: [
          (data) => PopupMenuButton<String>(
                icon: const Icon(Icons.more_vert),
                onSelected: (String result) {
                  switch (result) {
                    case 'view':
                      try {
                        // print(
                        //     'opening view order: id ${data['firebaseId']} products ${data['products']}}');
                        String email = data['customer'].split('\n')[1];
                        String mobile = data['customer'].split('\n')[2];
                        String title = data['customerTitle'];
                        Map<String, dynamic> customer = {
                          'name': data['customer'],
                          'email': email,
                          'mobile': mobile,
                          'title': title
                        };
                        openViewOrder(data['firebaseId'], customer,
                            List<Map<String, dynamic>>.from(data['products']));
                      } catch (e) {
                        print('error opening view order: $e');
                      }
                      break;
                    case 'void':
                      showDynamicDialog(
                        context: context,
                        title: 'Confirmation',
                        content:
                            'Are you sure you want to void this transaction?',
                        onContinue: () {
                          voidTransaction(data['firebaseId'], data['status']);
                          Navigator.of(context).pop();
                        },
                        onCancel: () {
                          Navigator.of(context).pop();
                        },
                      );
                      break;
                    case 'confirm':
                      showDynamicDialog(
                        context: context,
                        title: 'Confirmation',
                        content:
                            'Are you sure you want to confirm this transaction?',
                        onContinue: () {
                          confirmTransaction(
                              data['firebaseId'], data['status']);
                          Navigator.of(context).pop();
                        },
                        onCancel: () {
                          Navigator.of(context).pop();
                        },
                      );
                      break;
                    case 'add tracking':
                      try {
                        // print(
                        //     'opening view order: id ${data['firebaseId']} products ${data['products']}}');
                        String email = data['customer'].split('\n')[1];
                        String mobile = data['customer'].split('\n')[2];
                        String title = data['customerTitle'];
                        Map<String, dynamic> customer = {
                          'name': data['customer'],
                          'email': email,
                          'mobile': mobile,
                          'title': title
                        };
                        openAddTracking(
                            data['firebaseId'],
                            customer,
                            List<Map<String, dynamic>>.from(data['products']),
                            data['reference'],
                            data['trackingNmr']);
                      } catch (e) {
                        print('error opening view order: $e');
                      }
                      break;
                  }
                },
                itemBuilder: (BuildContext context) {
                  List<PopupMenuEntry<String>> menuItems = [];
                  // // Dynamically add menu items based on the user's status
                  if (data.containsKey('status')) {
                    if (data['status'] == 'Pending') {
                      menuItems.add(const PopupMenuItem<String>(
                        value: 'confirm',
                        child: Text('Confirm Payment'),
                      ));
                    }
                  }
                  menuItems.add(const PopupMenuItem<String>(
                    value: 'view',
                    child: Text('View Order'),
                  ));
                  menuItems.add(const PopupMenuItem<String>(
                    value: 'void',
                    child: Text('Void Order'),
                  ));
                  if (data['hasPhysicalProducts']) {
                    menuItems.add(const PopupMenuItem<String>(
                      value: 'add tracking',
                      child: Text('Add Tracking Number'),
                    ));
                  }
                  return menuItems;
                },
              )
        ]);
  }
}
