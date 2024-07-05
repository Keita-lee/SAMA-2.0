import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sama/admin/products/UI/codingProductDetail.dart';
import 'package:sama/admin/products/UI/digitalProductDetail.dart';
import 'package:sama/admin/products/UI/myDropDownButton.dart';
import 'package:sama/admin/products/UI/myProductButtons.dart';
import 'package:sama/admin/products/UI/myProductTextField.dart';
import 'package:sama/admin/products/UI/myToggleButton.dart';
import 'package:sama/admin/products/UI/productImage.dart';
import 'package:sama/components/myutility.dart';

class ProductEditPage extends StatefulWidget {
  final String productId;
  Function(int, String) changePageIndex;
  ProductEditPage(
      {super.key, required this.productId, required this.changePageIndex});

  @override
  State<ProductEditPage> createState() => _ProductEditPageState();
}

class _ProductEditPageState extends State<ProductEditPage> {
  var dropDownValue = '';
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _skuController;

  // Digital Product Controllers
  late TextEditingController _memberPriceController;
  late TextEditingController _nonMemberPriceController;
  late TextEditingController _retailerPriceController;
  late TextEditingController _digitalDownloadLinkController;

  // Coding Product Controllers
  late TextEditingController _firstLicensePriceController;
  late TextEditingController _tenLicensePriceController;
  late TextEditingController _elevenPlusLicensePriceController;
  late TextEditingController _codingDownloadLinkController;

  bool isDigitalProduct = false;
  bool isActive = true;
  String imageUrl = '';

  //Set value for product image
  setImageUrl(value) {
    setState(() {
      imageUrl = value;
    });
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _descriptionController = TextEditingController();
    _skuController = TextEditingController();

    // Initialize Digital Product Controllers
    _memberPriceController = TextEditingController();
    _nonMemberPriceController = TextEditingController();
    _retailerPriceController = TextEditingController();
    _digitalDownloadLinkController = TextEditingController();

    // Initialize Coding Product Controllers
    _firstLicensePriceController = TextEditingController();
    _tenLicensePriceController = TextEditingController();
    _elevenPlusLicensePriceController = TextEditingController();
    _codingDownloadLinkController = TextEditingController();

    // Load product details from Firestore
    loadProductDetails();
  }

  Future<void> loadProductDetails() async {
    try {
      DocumentSnapshot productSnapshot = await FirebaseFirestore.instance
          .collection('store')
          .doc(widget.productId)
          .get();

      if (productSnapshot.exists) {
        var data = productSnapshot.data() as Map<String, dynamic>;
        setState(() {
          isActive = data['isActive'] ?? '';
          imageUrl = data['imageUrl'] ?? '';
          _nameController.text = data['name'] ?? '';
          _descriptionController.text = data['description'] ?? '';
          _skuController.text = data['sku'] ?? '';
          dropDownValue = data['type'] ?? '';
          //isDigitalProduct = data['isDigitalProduct'] ?? false;

          if (data['type'] == 'Digital Product') {
            _memberPriceController.text = data['memberPrice'] ?? '';
            _nonMemberPriceController.text = data['nonMemberPrice'] ?? '';
            _retailerPriceController.text = data['retailerPrice'] ?? '';
            _digitalDownloadLinkController.text = data['downloadLink'] ?? '';
          } else {
            _firstLicensePriceController.text = data['firstLicensePrice'] ?? '';
            _tenLicensePriceController.text = data['tenLicensePrice'] ?? '';
            _elevenPlusLicensePriceController.text =
                data['elevenPlusLicensePrice'] ?? '';
            _codingDownloadLinkController.text = data['downloadLink'] ?? '';
          }
        });
      }
    } catch (e) {
      print('Error loading product details: $e');
    }
  }

  Future<void> updateProduct() async {
    var productDetails = {
      'id': widget.productId,
      'name': _nameController.text,
      'description': _descriptionController.text,
      'sku': _skuController.text,
      'type': dropDownValue,
      'isActive': isActive,
    };

    if (isDigitalProduct) {
      productDetails.addAll({
        'memberPrice': _memberPriceController.text,
        'nonMemberPrice': _nonMemberPriceController.text,
        'retailerPrice': _retailerPriceController.text,
        'downloadLink': _digitalDownloadLinkController.text,
      });
    } else {
      productDetails.addAll({
        'firstLicensePrice': _firstLicensePriceController.text,
        'tenLicensePrice': _tenLicensePriceController.text,
        'elevenPlusLicensePrice': _elevenPlusLicensePriceController.text,
        'downloadLink': _codingDownloadLinkController.text,
      });
    }

    if (_nameController.text.isNotEmpty &&
        _descriptionController.text.isNotEmpty &&
        _skuController.text.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('store')
          .doc(widget.productId)
          .update(productDetails);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Product updated successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all the fields')),
      );
    }
  }

  Future<void> deleteProduct() async {
    await FirebaseFirestore.instance
        .collection('store')
        .doc(widget.productId)
        .delete();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Product deleted successfully')),
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MyUtility(context).width * 0.60,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Edit product',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  MyProductButtons(
                    buttonText: 'Back',
                    buttonColor: Color.fromARGB(255, 212, 210, 210),
                    borderColor: Colors.black,
                    textColor: Colors.black,
                    onTap: () {
                      widget.changePageIndex(0, "");
                    },
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  MyProductButtons(
                    buttonText: 'Update Product',
                    buttonColor: Color.fromARGB(255, 8, 55, 145),
                    borderColor: Color.fromARGB(255, 8, 55, 145),
                    textColor: Colors.white,
                    onTap: () {
                      updateProduct();
                      widget.changePageIndex(0, "");
                      //  Navigator.pop(context);
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
                    textfieldController: _nameController,
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
                    textfieldController: _descriptionController,
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
                      textfieldController: _skuController,
                      textFieldWidth: MyUtility(context).width * 0.19,
                      topPadding: 0,
                      header: 'SKU'),
                  MyDropDownButton(
                    getDropDownValue: (value) {
                      setState(() {
                        dropDownValue = value;
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
                  memberPriceController: _memberPriceController,
                  nonMemberPriceController: _nonMemberPriceController,
                  retailerPriceController: _retailerPriceController,
                  downloadLinkController: _digitalDownloadLinkController,
                ),
              ),
              Visibility(
                visible: dropDownValue == 'Coding Product' ? true : false,
                child: CodingProductDetail(
                  firstLicensePriceController: _firstLicensePriceController,
                  tenLicensePriceController: _tenLicensePriceController,
                  elevenPlusLicensePriceController:
                      _elevenPlusLicensePriceController,
                  downloadLinkController: _codingDownloadLinkController,
                ),
              ),
              SizedBox(
                height: MyUtility(context).height * 0.08,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
