import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:uuid/uuid.dart';

import '../../../Login/popups/validateDialog.dart';
import '../../../components/myutility.dart';
import '../UI/myProductButtons.dart';
import '../UI/myProductTextField.dart';
import '../UI/productImage.dart';

class PhysicalProduct extends StatefulWidget {
  String productId;
  String type;
  Function(int, String) changePageIndex;
  PhysicalProduct(
      {super.key,
      required this.productId,
      required this.type,
      required this.changePageIndex});

  @override
  State<PhysicalProduct> createState() => _PhysicalProductState();
}

class _PhysicalProductState extends State<PhysicalProduct> {
  //Controllers
  final name = TextEditingController();
  final description = TextEditingController();
  final skuController = TextEditingController();
  final price = TextEditingController();
  final nonMemberPrice = TextEditingController();

//var
  String imageUrl = '';
  var priceType = "";
  var myJSON;

  QuillController quillController = QuillController.basic();

  //Dialog  already made booking
  Future descriptionPopup(description) => showDialog(
      context: context,
      builder: (context) {
        return Dialog(
            child: ValidateDialog(
                description: description,
                closeDialog: () => Navigator.pop(context!)));
      });

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
      'nonMemberPrice': nonMemberPrice.text
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
        nonMemberPrice.text = productData.get("nonMemberPrice");
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
            'Add new Physical Product',
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
                width: MyUtility(context).width * 0.40,
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
              MyProductTextField(
                  hintText: 'Product SKU',
                  textfieldController: skuController,
                  textFieldWidth: MyUtility(context).width * 0.36,
                  topPadding: 0,
                  header: 'SKU'),
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
                buttonColor: priceType == "Non-Member Pricing"
                    ? Color.fromARGB(255, 8, 55, 145)
                    : Colors.grey,
                borderColor: priceType == "Non-Member Pricing"
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
          Visibility(
            visible: priceType == "Member Pricing",
            child: MyProductTextField(
                hintText: '0.00',
                textfieldController: price,
                textFieldWidth: MyUtility(context).width * 0.19,
                topPadding: 0,
                header: "Member Price"),
          ),
          Visibility(
            visible: priceType == "Non-Member Pricing",
            child: MyProductTextField(
                hintText: '0.00',
                textfieldController: nonMemberPrice,
                textFieldWidth: MyUtility(context).width * 0.19,
                topPadding: 0,
                header: "Non Member Price"),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
