import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';

class AdminTable extends StatefulWidget {
  final List<String> columnHeaders;
  final List<Map<String, dynamic>> dataList;
  final List<Widget Function(Map<String, dynamic> data)> actions;
  final String? emptyMessage;
  final Function(int id)? onEdit;
  final Function(int id)? onDelete;
  bool waiting;

  AdminTable(
      {Key? key,
      required this.columnHeaders,
      required this.dataList,
      required this.waiting,
      this.emptyMessage,
      this.onEdit,
      this.onDelete,
      required this.actions})
      : super(key: key);

  @override
  State<AdminTable> createState() => _AdminTableState();
}

class _AdminTableState extends State<AdminTable> {
  Widget statusWidget(String status) {
    switch (status) {
      case 'Pending':
        return _buildLegendIndicator(Color(0xffd1d1d1), "");
      case 'Active':
        return _buildLegendIndicator(Color(0xff0c6e08), "");
      case 'Inactive':
        return _buildLegendIndicator(Color.fromARGB(255, 175, 0, 0), "");
      default:
        return _buildLegendIndicator(Color(0xffd1d1d1), "");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.745,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Container(
            decoration: const BoxDecoration(
              color: Color.fromRGBO(209, 209, 209, 1),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (var header in widget.columnHeaders)
                    Expanded(
                      child: Text(
                        header,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  const Text(
                    'Actions',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ), // Actions column header
                ],
              ),
            ),
          ),
          // Data Rows
          widget.waiting
              ? const Center(
                  child: Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text('Loading...'),
                ))
              : widget.dataList.isEmpty
                  ? Center(
                      child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(widget.emptyMessage ?? 'No data found'),
                    ))
                  : Container(
                      height: 400,
                      width: MyUtility(context).width * 0.745,
                      child: ListView.builder(
                          itemCount: widget.dataList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final data = widget.dataList[index];
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 12.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  for (var header in widget.columnHeaders)
                                    Expanded(
                                      child: header == 'Status'
                                          ? Center(
                                              child: statusWidget(
                                                  data[header.toLowerCase()]))
                                          : Text(
                                              data[header.toLowerCase()] ?? ''),
                                    ),
                                  // Actions column
                                  Row(
                                    children: [
                                      ...widget.actions
                                          .map((builder) => builder(data))
                                          .toList()
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                    )
          // Column(
          //     children: [
          //       ...widget.dataList
          //           .map(
          //             (data) => Padding(
          //               padding: const EdgeInsets.symmetric(
          //                   vertical: 4.0, horizontal: 12.0),
          //               child: Row(
          //                 mainAxisAlignment:
          //                     MainAxisAlignment.spaceBetween,
          //                 children: [
          //                   for (var header in widget.columnHeaders)
          //                     Expanded(
          //                       child: header == 'Status'
          //                           ? Center(
          //                               child: statusWidget(
          //                                   data[header.toLowerCase()]))
          //                           : Text(data[header.toLowerCase()] ??
          //                               ''),
          //                     ),
          //                   // Actions column
          //                   Row(
          //                     children: [
          //                       ...widget.actions
          //                           .map((builder) => builder(data))
          //                           .toList()
          //                     ],
          //                   ),
          //                 ],
          //               ),
          //             ),
          //           )
          //           .toList(),
          //     ],
          //   ),
        ],
      ),
    );
  }
}

Widget _buildLegendIndicator(Color color, String text) {
  return Padding(
    padding: const EdgeInsets.only(right: 16.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 6,
          backgroundColor: color,
        ),
        const SizedBox(width: 8),
        Text(text),
      ],
    ),
  );
}
