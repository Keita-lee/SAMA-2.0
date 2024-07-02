import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';

class ProductListItem extends StatelessWidget {
  final String title;
  final String type;
  final bool isActive; // Add this line
  final Function()? onTapView;
  final Function()? onTapEdit;
  final Function()? onTapDelete;
  final Color itemColor;

  ProductListItem({
    super.key,
    required this.title,
    required this.type,
    required this.isActive, // Add this line
    this.onTapView,
    this.onTapEdit,
    this.onTapDelete,
    required this.itemColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: itemColor,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Container(
                  width: 60,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: isActive
                        ? Color(0xFF174486)
                        : Colors.grey, // Update this line
                  ),
                  child: Align(
                    alignment: isActive
                        ? Alignment.centerRight
                        : Alignment.centerLeft, // Update this line
                    child: Container(
                      width: 20,
                      height: 20,
                      margin: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MyUtility(context).width * 0.27,
              height: 30,
              child: Text(
                title,
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(
              width: MyUtility(context).width * 0.13,
              height: 30,
              child: Text(type),
            ),
            SizedBox(
              width: 185,
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  /* TextButton(
                      onPressed: onTapView,
                      child: Text(
                        'View',
                        style: TextStyle(color: Colors.black),
                      )),
                  Text('|'),*/
                  TextButton(
                      onPressed: onTapEdit,
                      child: Text(
                        'Edit',
                        style: TextStyle(color: Colors.black),
                      )),
                  Text('|'),
                  TextButton(
                      onPressed: onTapDelete,
                      child: Text(
                        'Delete',
                        style: TextStyle(color: Colors.black),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
