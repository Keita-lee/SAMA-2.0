import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../../components/myutility.dart';

class CpdListItem extends StatefulWidget {
  final String title;
  final Color itemColor;
  final bool isActive;
  final Function()? onTapEdit;
  final Function()? onTapDelete;

  CpdListItem({
    super.key,
    required this.title,
    required this.itemColor,
    required this.isActive,
    required this.onTapEdit,
    required this.onTapDelete,
  });

  @override
  State<CpdListItem> createState() => _CpdListItemState();
}

class _CpdListItemState extends State<CpdListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: widget.itemColor,
        child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Container(
                  width: 60,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: widget.isActive ? Color(0xFF174486) : Colors.grey,
                  ),
                  child: Align(
                    alignment: widget.isActive
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
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
              SizedBox(
                width: MyUtility(context).width * 0.27,
                height: 30,
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFF3D3D3D),
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Spacer(),
              SizedBox(
                width: 185,
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                        onPressed: widget.onTapEdit,
                        child: Text(
                          'Edit',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        )),
                    Text('|'),
                    TextButton(
                        onPressed: widget.onTapDelete,
                        child: Text(
                          'Delete',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        )),
                  ],
                ),
              ),
            ])));
  }
}
