import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../components/myutility.dart';

class CategoryContainer extends StatefulWidget {
  int index;
  String description;
  String hoverDescription;
  String monthly;
  String annually;
  Function(String, String, String, String) priceSelected;
  String applicationPrice;
  String code;
  CategoryContainer(
      {super.key,
      required this.index,
      required this.description,
      required this.hoverDescription,
      required this.monthly,
      required this.annually,
      required this.priceSelected,
      required this.applicationPrice,
      required this.code});

  @override
  State<CategoryContainer> createState() => _CategoryContainerState();
}

class _CategoryContainerState extends State<CategoryContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.index.isEven
          ? Color.fromARGB(255, 230, 230, 230)
          : Color.fromARGB(255, 255, 255, 255),
      width: MyUtility(context).width,
      height: 40,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(255, 8, 55, 145)),
              child: Center(
                child: Tooltip(
                  message: widget.hoverDescription,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: const Color.fromARGB(255, 59, 59, 59),
                  ),
                  //  height: 150,
                  margin: EdgeInsets.only(right: 50),
                  padding: const EdgeInsets.all(8.0),
                  preferBelow: true,
                  textStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  child: Text(
                    "?",
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              widget.description!,
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            Spacer(),
            InkWell(
              onTap: () {
                widget.priceSelected(widget.monthly, widget.description!,
                    "Monthly", widget.code);
              },
              child: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 2),
                    color: widget.applicationPrice == widget.monthly
                        ? Color.fromARGB(255, 8, 55, 145)
                        : Colors.white),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              widget.monthly!,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                widget.priceSelected(widget.annually, widget.description!,
                    "Annually", widget.code);
              },
              child: Container(
                padding: EdgeInsets.all(
                  widget.applicationPrice == widget.annually ? 10 : 0,
                ),
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.black, width: 2),
                    color: widget.applicationPrice == widget.annually
                        ? Color.fromARGB(255, 8, 55, 145)
                        : Colors.white),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              widget.annually!,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
