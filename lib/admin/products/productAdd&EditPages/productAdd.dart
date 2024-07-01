import 'package:flutter/material.dart';
import 'package:sama/admin/products/UI/codingProductDetail.dart';
import 'package:sama/admin/products/UI/digitalProductDetail.dart';
import 'package:sama/admin/products/UI/myDropDownButton.dart';
import 'package:sama/admin/products/UI/myProductButtons.dart';
import 'package:sama/admin/products/UI/myProductTextField.dart';
import 'package:sama/admin/products/UI/myToggleButton.dart';
import 'package:sama/admin/products/UI/productImage.dart';
import 'package:sama/components/myutility.dart';


class ProductAdd extends StatefulWidget {
  const ProductAdd({super.key});

  @override
  State<ProductAdd> createState() => _ProductAddState();
}

class _ProductAddState extends State<ProductAdd> {
  var dropDownValue = '';
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
                        textColor: Colors.white)
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
                      textfieldController: TextEditingController(),
                      textFieldWidth: MyUtility(context).width * 0.35,
                      topPadding: 0,
                      header: 'Name',
                    ),
                    Spacer(),
                    MyToggleButton()
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyProductTextField(
                      hintText: 'Product description',
                      textfieldController: TextEditingController(),
                      textFieldWidth: MyUtility(context).width * 0.35,
                      lines: 12,
                      topPadding: 20,
                      header: 'Description',
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    ProductImage()
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MyProductTextField(
                        hintText: 'Product SKU',
                        textfieldController: TextEditingController(),
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
                  child: DigitalProductDeatail(),
                ),
                Visibility(
                  visible: dropDownValue == 'Coding Product' ? true : false,
                  child: CodingProductDetail(),
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
