import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sama/admin/products/UI/codingProductDetail.dart';
import 'package:sama/admin/products/UI/digitalProductDetail.dart';
import 'package:sama/admin/products/UI/myDropDownButton.dart';
import 'package:sama/admin/products/UI/myProductButtons.dart';
import 'package:sama/admin/products/UI/myProductTextField.dart';
import 'package:sama/admin/products/UI/myToggleButton.dart';
import 'package:sama/admin/products/UI/productImage.dart';
import 'package:sama/components/imageAdd.dart';
import 'package:sama/components/myutility.dart';

class ProductAdd extends StatefulWidget {
  const ProductAdd({
    super.key,
  });

  @override
  State<ProductAdd> createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  var dropDownValue = '';
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController skuController = TextEditingController();

  // Digital Product Controllers
  final TextEditingController memberPriceController = TextEditingController();
  final TextEditingController nonMemberPriceController =
      TextEditingController();
  final TextEditingController retailerPriceController = TextEditingController();
  final TextEditingController digitalDownloadLinkController =
      TextEditingController();

  // Coding Product Controllers
  final TextEditingController firstLicensePriceController =
      TextEditingController();
  final TextEditingController tenLicensePriceController =
      TextEditingController();
  final TextEditingController elevenPlusLicensePriceController =
      TextEditingController();
  final TextEditingController codingDownloadLinkController =
      TextEditingController();

  String imageUrl = '';
  bool isActive = true;
  bool isDigitalProduct = false;

  //Set value for product image
  setImageUrl(value) {
    setState(() {
      imageUrl = value;
    });
  }

  final String newProductId =
      FirebaseFirestore.instance.collection('store').doc().id;

  Future<void> addProduct() async {
    var productDetails = {
      'id': newProductId,
      'name': nameController.text,
      'description': descriptionController.text,
      'sku': skuController.text,
      'type': dropDownValue,
      'imageUrl': imageUrl,
      'isActive': isActive,
    };

    // Add additional product details based on product type
    if (isDigitalProduct) {
      productDetails.addAll({
        'memberPrice': memberPriceController.text,
        'nonMemberPrice': nonMemberPriceController.text,
        'retailerPrice': retailerPriceController.text,
        'downloadLink': digitalDownloadLinkController.text,
      });
    } else {
      productDetails.addAll({
        'firstLicensePrice': firstLicensePriceController.text,
        'tenLicensePrice': tenLicensePriceController.text,
        'elevenPlusLicensePrice': elevenPlusLicensePriceController.text,
        'downloadLink': codingDownloadLinkController.text,
      });
    }

    if (nameController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        skuController.text.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('store')
          .doc(newProductId) // Set the document ID explicitly
          .set(productDetails);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product added successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all the fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: MyUtility(context).width * 0.60,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MyUtility(context).height * 0.08,
                ),
                Row(
                  children: [
                    Text(
                      'Add new product',
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    MyProductButtons(
                        buttonText: 'Save as Draft',
                        buttonColor: Color.fromARGB(255, 212, 210, 210),
                        borderColor: Colors.black,
                        textColor: Colors.black),
                    const SizedBox(
                      width: 25,
                    ),
                    MyProductButtons(
                      buttonText: 'Publish Product',
                      buttonColor: Color.fromARGB(255, 8, 55, 145),
                      borderColor: Color.fromARGB(255, 8, 55, 145),
                      textColor: Colors.white,
                      onTap: () {
                        addProduct();
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    MyProductTextField(
                      hintText: 'Product name',
                      textfieldController: nameController,
                      textFieldWidth: MyUtility(context).width * 0.35,
                      topPadding: 0,
                      header: 'Name',
                    ),
                    Spacer(),
                    MyToggleButton(
                      initialValue: isActive,
                      onChanged: (value) {
                        setState(() {
                          isActive = value;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyProductTextField(
                      hintText: 'Product description',
                      textfieldController: descriptionController,
                      textFieldWidth: MyUtility(context).width * 0.35,
                      lines: 12,
                      topPadding: 20,
                      header: 'Description',
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    ProductImage(
                        customWidth: 150,
                        customHeight: 150,
                        description: '',
                        networkImageUrl: imageUrl,
                        setUrl: setImageUrl)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MyProductTextField(
                        hintText: 'Product SKU',
                        textfieldController: skuController,
                        textFieldWidth: MyUtility(context).width * 0.19,
                        topPadding: 0,
                        header: 'SKU'),
                    MyDropDownButton(
                      getDropDownValue: (value) {
                        setState(() {
                          dropDownValue = value;
                          isDigitalProduct = value == 'Digital Product';
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 35,
                ),
                Visibility(
                  visible: dropDownValue == 'Digital Product' ? true : false,
                  child: DigitalProductDeatail(
                    memberPriceController: memberPriceController,
                    nonMemberPriceController: nonMemberPriceController,
                    retailerPriceController: retailerPriceController,
                    downloadLinkController: digitalDownloadLinkController,
                  ),
                ),
                Visibility(
                  visible: dropDownValue == 'Coding Product' ? true : false,
                  child: CodingProductDetail(
                    firstLicensePriceController: firstLicensePriceController,
                    tenLicensePriceController: tenLicensePriceController,
                    elevenPlusLicensePriceController:
                        elevenPlusLicensePriceController,
                    downloadLinkController: codingDownloadLinkController,
                  ),
                ),
                SizedBox(
                  height: MyUtility(context).height * 0.08,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
