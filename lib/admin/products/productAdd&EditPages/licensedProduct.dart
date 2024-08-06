import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:uuid/uuid.dart';

import '../../../components/myutility.dart';
import '../../../login/popups/validateDialog.dart';
import '../UI/myProductButtons.dart';
import '../UI/myProductTextField.dart';
import '../UI/productImage.dart';

class LicensedProduct extends StatefulWidget {
  String productId;
  String type;
  Function(int, String) changePageIndex;
  LicensedProduct(
      {super.key,
      required this.productId,
      required this.type,
      required this.changePageIndex});

  @override
  State<LicensedProduct> createState() => _LicensedProductState();
}

class _LicensedProductState extends State<LicensedProduct> {
  //Controllers
  final name = TextEditingController();
  final skuController = TextEditingController();
  final downloadLink = TextEditingController();
  final firstLicensePrice = TextEditingController();
  final secondTierRange = TextEditingController();
  final secondTierPrice = TextEditingController();
  final thirdTierPrice = TextEditingController();
  final price = TextEditingController();

  //var
  String imageUrl = '';
  var priceType = "";
  var myJSON;
  bool unlimited = false;
  bool tier2 = false;
  QuillController quillController = QuillController.basic();

  //Set value for product image
  setImageUrl(value) {
    setState(() {
      imageUrl = value;
    });
  }

  //change member price type
  changePriceType(value) {
    setState(() {
      priceType = value;
    });
  }

  //Dialog  already made booking
  Future descriptionPopup(description) => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: ValidateDialog(
                description: description,
                closeDialog: () => Navigator.pop(context!)));
      });

  saveProduct(status) async {
    var productDetails = {
      'id': widget.productId,
      'name': name.text,
      'description': jsonEncode(quillController.document.toDelta().toJson()),
      'sku': skuController.text,
      'type': widget.type,
      'imageUrl': imageUrl,
      'isActive': status,
      'priceType': priceType,
      'price': price.text,
      "unlimited": unlimited,
      "firstLicensePrice": firstLicensePrice.text,
      "tier2": tier2,
      "downloadLink": downloadLink.text,
      "secondTierRange": secondTierRange.text,
      "secondTierPrice": secondTierPrice.text,
      "thirdTierPrice": thirdTierPrice.text
    };

    if (widget.productId == "") {
      final String newProductId =
          FirebaseFirestore.instance.collection('store').doc().id;
      productDetails['id'] = newProductId;
      await FirebaseFirestore.instance
          .collection('store')
          .doc(newProductId)
          .set(productDetails)
          .whenComplete(() {
        descriptionPopup("Product saved");
      });
    } else {
      await FirebaseFirestore.instance
          .collection('store')
          .doc(widget.productId)
          .update(productDetails)
          .whenComplete(() {
        descriptionPopup("Product saved");
      });
    }
  }

//get details for products
  getProductDetails() async {
    DocumentSnapshot productData = await FirebaseFirestore.instance
        .collection('store')
        .doc(widget.productId)
        .get();

    if (productData.exists) {
      setState(() {
        name.text = productData.get("name");

        myJSON = jsonDecode(productData.get('description'));
        quillController = QuillController(
            document: Document.fromJson(myJSON),
            selection: TextSelection.collapsed(offset: 0));
        skuController.text = productData.get("sku");
        imageUrl = productData.get("imageUrl");

        priceType = productData.get("priceType");
        price.text = productData.get("price");
        unlimited = productData.get("unlimited");
        firstLicensePrice.text = productData.get("unlimited");
        tier2 = productData.get("tier2");
        downloadLink.text = productData.get("downloadLink");
        secondTierRange.text = productData.get("secondTierRange");
        secondTierPrice.text = productData.get("secondTierPrice");
        thirdTierPrice.text = productData.get("thirdTierPrice");
      });
    }
  }

  @override
  void initState() {
    if (widget.productId != "") {
      getProductDetails();
    } else {
      var uuid = Uuid();
      skuController.text = uuid.v1().toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
          Text(
            'Add new Licensed Product',
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 8, 55, 145)),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                width: MyUtility(context).width * 0.60,
              ),
              MyProductButtons(
                buttonText: 'Back',
                buttonColor: Color.fromARGB(255, 212, 210, 210),
                borderColor: Color.fromARGB(255, 8, 55, 145),
                textColor: Colors.white,
                onTap: () {
                  widget.changePageIndex(0, "");
                },
              ),
              SizedBox(
                width: 15,
              ),
              MyProductButtons(
                buttonText: 'Save as Draft',
                buttonColor: Color.fromARGB(255, 8, 55, 145),
                borderColor: Color.fromARGB(255, 8, 55, 145),
                textColor: Colors.white,
                onTap: () {
                  saveProduct("InActive");
                },
              ),
              SizedBox(
                width: 15,
              ),
              MyProductButtons(
                buttonText: 'Publish',
                buttonColor: Color.fromARGB(255, 8, 55, 145),
                borderColor: Color.fromARGB(255, 8, 55, 145),
                textColor: Colors.white,
                onTap: () {
                  saveProduct("Active");
                },
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          MyProductTextField(
            hintText: 'Product name',
            textfieldController: name,
            textFieldWidth: MyUtility(context).width * 0.60,
            topPadding: 0,
            header: 'Name',
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Description",
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            width: MyUtility(context).width / 1.5,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: QuillToolbar.simple(
              configurations: QuillSimpleToolbarConfigurations(
                controller: quillController,
                sharedConfigurations: const QuillSharedConfigurations(),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MyUtility(context).width / 1.5,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: QuillEditor.basic(
              configurations: QuillEditorConfigurations(
                controller: quillController,
                sharedConfigurations: const QuillSharedConfigurations(),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              ProductImage(
                  customWidth: 350,
                  customHeight: 350,
                  description: '',
                  networkImageUrl: imageUrl,
                  setUrl: setImageUrl),
              SizedBox(
                width: 20,
              ),
              Column(
                children: [
                  MyProductTextField(
                      hintText: 'Product SKU',
                      textfieldController: skuController,
                      textFieldWidth: MyUtility(context).width * 0.36,
                      topPadding: 0,
                      header: 'SKU'),
                  SizedBox(
                    height: 10,
                  ),
                  MyProductTextField(
                      hintText: 'http://',
                      textfieldController: downloadLink,
                      textFieldWidth: MyUtility(context).width * 0.36,
                      topPadding: 0,
                      header: 'Download link'),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: [
              MyProductButtons(
                buttonText: 'Member Pricing',
                buttonColor: priceType == "Member Pricing"
                    ? Color.fromARGB(255, 8, 55, 145)
                    : Colors.grey,
                borderColor: priceType == "Member Pricing"
                    ? Color.fromARGB(255, 8, 55, 145)
                    : Colors.grey,
                textColor: Colors.white,
                onTap: () {
                  changePriceType("Member Pricing");
                },
              ),
              SizedBox(
                width: 20,
              ),
              MyProductButtons(
                buttonText: 'Non-Member Pricing',
                buttonColor: priceType == "'Non-Member Pricing"
                    ? Color.fromARGB(255, 8, 55, 145)
                    : Colors.grey,
                borderColor: priceType == "'Non-Member Pricing"
                    ? Color.fromARGB(255, 8, 55, 145)
                    : Colors.grey,
                textColor: Colors.white,
                onTap: () {
                  changePriceType("Non-Member Pricing");
                },
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "Add price inclusive of VAT.",
            style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
                fontSize: 16,
                letterSpacing: 1.1),
          ),
          Row(
            children: [
              MyProductTextField(
                  hintText: '0.00',
                  textfieldController: price,
                  textFieldWidth: MyUtility(context).width * 0.19,
                  topPadding: 0,
                  header: "First License Price"),
              SizedBox(
                width: 15,
              ),
            ],
          ),
          SizedBox(height: 15.0),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    tier2 = !tier2;
                  });
                },
                child: Container(
                  width: 35.0,
                  height: 35.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      color: Colors.grey,
                      width: 2.0,
                    ),
                    color: tier2 ? Color(0xFF174486) : Colors.transparent,
                  ),
                  child: tier2
                      ? Icon(
                          Icons.check,
                          size: 16.0,
                          color: Colors.white,
                        )
                      : null,
                ),
              ),
              SizedBox(width: 10.0),
              Text(
                "Add Tier 2 Price",
                style: TextStyle(
                  fontSize: 22,
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Visibility(
            visible: tier2,
            child: Row(
              children: [
                MyProductTextField(
                    hintText: '0.00',
                    textfieldController: secondTierRange,
                    textFieldWidth: MyUtility(context).width * 0.19,
                    topPadding: 0,
                    header: "From 2 to "),
                SizedBox(width: 20.0),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      unlimited = !unlimited;
                    });
                  },
                  child: Container(
                    width: 35.0,
                    height: 35.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                        color: Colors.grey,
                        width: 2.0,
                      ),
                      color: unlimited ? Color(0xFF174486) : Colors.transparent,
                    ),
                    child: unlimited
                        ? Icon(
                            Icons.check,
                            size: 16.0,
                            color: Colors.white,
                          )
                        : null,
                  ),
                ),
                SizedBox(width: 10.0),
                Text(
                  "Unlimited",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 20.0),
                MyProductTextField(
                    hintText: '1000.00',
                    textfieldController: secondTierPrice,
                    textFieldWidth: MyUtility(context).width * 0.19,
                    topPadding: 0,
                    header: "Price"),
              ],
            ),
          ),
          Visibility(
            visible: unlimited,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Add Tier 3 Pricing",
                  style: TextStyle(
                    fontSize: 22,
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                MyProductTextField(
                    hintText: '500.00',
                    textfieldController: thirdTierPrice,
                    textFieldWidth: MyUtility(context).width * 0.19,
                    topPadding: 0,
                    header: "From (tier 2 limit + 1) to unlimited price"),
              ],
            ),
          ),
        ]));
  }
}
