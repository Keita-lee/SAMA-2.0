import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';

class MemberTable extends StatefulWidget {
  final List<String> columnHeaders;
  final List<Map<String, dynamic>> dataList;
  final Function(int id)? onEdit;
  final Function(int id)? onDelete;

  const MemberTable({
    Key? key,
    required this.columnHeaders,
    required this.dataList,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  @override
  State<MemberTable> createState() => _MemberTableState();
}

class _MemberTableState extends State<MemberTable> {
  // Example data list with ids
  final List<Map<String, dynamic>> dataList = [
    {
      'id': 1,
      'column1': 'Row 1, Column 1',
      'column2': 'Row 1, Column 2',
      'column3': 'Row 1, Column 3',
      'column4': 'Row 1, Column 4',
      'column5': 'Row 1, Column 5'
    },
    {
      'id': 2,
      'column1': 'Row 2, Column 1',
      'column2': 'Row 2, Column 2',
      'column3': 'Row 2, Column 3',
      'column4': 'Row 2, Column 4',
      'column5': 'Row 2, Column 5'
    },
    {
      'id': 3,
      'column1': 'Row 3, Column 1',
      'column2': 'Row 3, Column 2',
      'column3': 'Row 3, Column 3',
      'column4': 'Row 3, Column 4',
      'column5': 'Row 3, Column 5'
    },
    {
      'id': 4,
      'column1': 'Row 4, Column 1',
      'column2': 'Row 4, Column 2',
      'column3': 'Row 4, Column 3',
      'column4': 'Row 4, Column 4',
      'column5': 'Row 4, Column 5'
    },
    {
      'id': 5,
      'column1': 'Row 5, Column 1',
      'column2': 'Row 5, Column 2',
      'column3': 'Row 5, Column 3',
      'column4': 'Row 5, Column 4',
      'column5': 'Row 5, Column 5'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MyUtility(context).width * 0.745,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Container(
            decoration:
                const BoxDecoration(color: Color.fromRGBO(209, 209, 209, 1)),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text('Column 1',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(
                      child: Text('Column 2',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(
                      child: Text('Column 3',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(
                      child: Text('Column 4',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Expanded(
                      child: Text('Column 5',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Text('Actions',
                      style: TextStyle(
                          fontWeight:
                              FontWeight.bold)), // Actions column header
                ],
              ),
            ),
          ),
          // Data Rows
          for (var data in dataList)
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(data['column1'])),
                  Expanded(child: Text(data['column2'])),
                  Expanded(child: Text(data['column3'])),
                  Expanded(child: Text(data['column4'])),
                  Expanded(child: Text(data['column5'])),

                  // Actions column
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          // Handle edit action here, using data['id']
                          print('Edit row with id: ${data['id']}');
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          // Handle delete action here, using data['id']
                          print('Delete row with id: ${data['id']}');
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
