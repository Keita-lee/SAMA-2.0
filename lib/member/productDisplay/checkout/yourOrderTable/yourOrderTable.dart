import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class YourOrderTable extends StatefulWidget {
  List orderProduct;

  YourOrderTable({super.key, required this.orderProduct});

  @override
  State<YourOrderTable> createState() => _YourOrderTableState();
}

class _YourOrderTableState extends State<YourOrderTable> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      //height: 500,
      child: Center(
        child: Table(
          columnWidths: {
            0 : FixedColumnWidth(220)
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            const TableRow(
              children: [
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Product',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Subtotal',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            ...List.generate(
              widget.orderProduct.length,
              (index) => TableRow(
                children: [
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        widget.orderProduct[index]['product'],
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        widget.orderProduct[index]['subtotal'],
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            TableRow(children: [
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Total',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              TableCell(
                verticalAlignment: TableCellVerticalAlignment.middle,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Total',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
