import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:sama/admin/products/UI/myProductButtons.dart';
import 'package:sama/components/utility.dart';

class HistoryProductDisplay extends StatefulWidget {
  List products;
  String date;

  HistoryProductDisplay(
      {super.key, required this.products, required this.date});

  @override
  State<HistoryProductDisplay> createState() => _HistoryProductDisplayState();
}

class _HistoryProductDisplayState extends State<HistoryProductDisplay> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MyUtility(context).width * 0.70,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: Border.all(
                color: Color.fromARGB(255, 212, 210, 210), width: 1.5)),
        child: Column(
          children: [
            SizedBox(
              height: 25,
            ),
            Text(
              widget.date,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            for (int i = 0; i < widget.products.length; i++)
              Column(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 30),
                      child: Row(
                        children: [
                          Visibility(
                            visible: widget.products[i]['productImage'] == ""
                                ? true
                                : false,
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("images/imageIcon.png"),
                                  fit: BoxFit.contain,
                                ),
                              ),
                              width: MyUtility(context).width / 7,
                              height: 200,
                            ),
                          ),
                          Visibility(
                            visible: widget.products[i]['productImage'] != ""
                                ? true
                                : false,
                            child: ImageNetwork(
                              fitWeb: BoxFitWeb.contain,
                              image: widget.products[i]['productImage'],
                              width: MyUtility(context).width / 7,
                              height: 200,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MyUtility(context).width / 3,
                                child: Text(
                                  widget.products[i]['productName'],
                                  maxLines: null,
                                  style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                width: MyUtility(context).width / 3,
                                child: Text(
                                  'R ${widget.products[i]['productPrice']}',
                                  maxLines: null,
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Color.fromRGBO(0, 159, 158, 1)),
                                ),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              widget.products[i]['downloadLink'] != null ||
                                      widget.products[i]['downloadLink'] == ''
                                  ? const SizedBox.shrink()
                                  : MyProductButtons(
                                      buttonText: 'Download',
                                      buttonColor: Colors.teal,
                                      borderColor: Colors.teal,
                                      textColor: Colors.white,
                                      onTap: () {},
                                    ),
                            ],
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 25,
                  ),
                  Container(
                    color: Colors.teal,
                    height: 1,
                    width: MyUtility(context).width * 0.65,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
          ],
        ));
  }
}
