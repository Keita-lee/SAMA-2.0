import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/login/membershipCategory/pages/ui/categoryContainer.dart';

import '../../../components/styleButton.dart';

class MemberCategoryReg extends StatefulWidget {
  String title;
  List options;
  Function(int) nextSection;
  Function(String, String) priceSelected;
  String applicationPrice;

  MemberCategoryReg(
      {super.key,
      required this.title,
      required this.options,
      required this.nextSection,
      required this.priceSelected,
      required this.applicationPrice});

  @override
  State<MemberCategoryReg> createState() => _MemberCategoryRegState();
}

class _MemberCategoryRegState extends State<MemberCategoryReg> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 1)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.title!,
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                for (var i = 0; i < widget.options.length; i++)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: CategoryContainer(
                      index: i,
                      description: widget.options[i]['title'],
                      hoverDescription: widget.options[i]['info'],
                      monthly: widget.options[i]['month'],
                      annually: widget.options[i]['annual'],
                      priceSelected: widget.priceSelected,
                      applicationPrice: widget.applicationPrice,
                    ),
                  ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: Text(
                    "Calculated on pro-rata basis when paying annully.",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            InkWell(
              onTap: () {},
              child: Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(
                        color: const Color.fromARGB(255, 145, 145, 145),
                        width: 2),
                    color: Colors.white),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              "I accept SAMA's",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              "terms and conditions",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.teal,
                  fontWeight: FontWeight.bold),
            ),
          ]),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              StyleButton(
                  buttonColor: const Color.fromARGB(255, 219, 219, 219),
                  description: "PREVIOUS",
                  height: 55,
                  width: 125,
                  onTap: () {
                    widget.nextSection(0);
                  }),
              Spacer(),
              StyleButton(
                  description: "CONTINUE",
                  height: 55,
                  width: 125,
                  onTap: () {
                    widget.nextSection(2);
                  })
            ],
          )
        ],
      ),
    );
  }
}
