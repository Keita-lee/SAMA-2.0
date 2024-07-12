import 'package:flutter/material.dart';
import 'package:sama/admin/products/UI/ProductListView.dart';
import 'package:sama/admin/products/UI/filterDropButton.dart';

import 'package:sama/admin/products/UI/myProductButtons.dart';

import 'package:sama/admin/products/UI/productListItem.dart';
import 'package:sama/admin/products/UI/productListTop.dart';
import 'package:sama/admin/products/productAdd&EditPages/productAdd.dart';
import 'package:sama/admin/products/productAdd&EditPages/productEditPage.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/components/styleTextfield.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var pageIndex = 0;
  var productId = "";
  changePageIndex(value, id) {
    setState(() {
      pageIndex = value;
      productId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: pageIndex == 0 ? true : false,
          child: Center(
            child: SizedBox(
              width: MyUtility(context).width * 0.60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Products',
                        style: TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      MyProductButtons(
                        buttonText: 'Add new',
                        buttonColor: Color.fromARGB(255, 8, 55, 145),
                        borderColor: Color.fromARGB(255, 8, 55, 145),
                        textColor: Colors.white,
                        onTap: () {
                          changePageIndex(2, "");
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: MyUtility(context).height * 0.07,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 200,
                        height: 45,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 255, 255, 255),
                            border: Border.all(
                              color: const Color.fromARGB(255, 51, 51, 51),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Center(
                          child: TextFormField(
                            controller: TextEditingController(),
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.only(left: 10),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      StyleButton(
                        description: "Search Products",
                        height: 55,
                        width: 160,
                        onTap: () {},
                      ),
                      Spacer(),
                      FilterDropButton(),
                    ],
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Column(
                    children: [
                      ProductListTop(),
                      ProductListView(changePageIndex: changePageIndex)
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: pageIndex == 1 ? true : false,
          child: Center(
            child: ProductEditPage(
                productId: productId, changePageIndex: changePageIndex),
          ),
        ),
        Visibility(
          visible: pageIndex == 2 ? true : false,
          child: Center(
            child: ProductAdd(changePageIndex: changePageIndex),
          ),
        )
      ],
    );
  }
}
