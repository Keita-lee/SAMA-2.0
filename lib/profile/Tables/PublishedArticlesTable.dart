import 'package:flutter/material.dart';

import '../../components/utility.dart';

class PublishedArticlesTable extends StatefulWidget {
  List articlesList;
  Function(int) removeArticle;
  String? memberView;
  PublishedArticlesTable(
      {super.key,
      required this.removeArticle,
      required this.articlesList,
      this.memberView});

  @override
  State<PublishedArticlesTable> createState() => _PublishedArticlesTableState();
}

class _PublishedArticlesTableState extends State<PublishedArticlesTable> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MyUtility(context).width / 1.7,
      //height: 500,
      child: Center(
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 233, 232, 232),
              ),
              children: [
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Date',
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
                      'Description',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.memberView != null ? false : true,
                  child: TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(''),
                    ),
                  ),
                ),
              ],
            ),
            ...List.generate(
              widget.articlesList.length,
              (index) => TableRow(
                decoration: BoxDecoration(
                  color: index % 2 == 0
                      ? Color(0xFFF8FAFF)
                      : Color.fromRGBO(174, 204, 236, 1),
                  border: Border(
                    bottom: BorderSide(
                      width: 1.5,
                      color: Color.fromARGB(255, 233, 232, 232),
                    ),
                  ),
                ),
                children: [
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        widget.articlesList[index]['articleDate'],
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        widget.articlesList[index]['articleDescription'],
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: widget.memberView != null ? false : true,
                    child: TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: InkWell(
                        onTap: () {
                          widget.removeArticle(index);
                        },
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
