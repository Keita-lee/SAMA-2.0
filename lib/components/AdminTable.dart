import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';

class AdminTable extends StatefulWidget {
  final List<String> columnHeaders;
  final List<Map<String, dynamic>> dataList;
  final Function(int id)? onEdit;
  final Function(int id)? onDelete;
  bool waiting;

  AdminTable({
    Key? key,
    required this.columnHeaders,
    required this.dataList,
    required this.waiting,
    this.onEdit,
    this.onDelete,
  }) : super(key: key);

  @override
  State<AdminTable> createState() => _AdminTableState();
}

class _AdminTableState extends State<AdminTable> {
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
              ? const Center(child: Text('Loading...'))
              : widget.dataList.isEmpty
                  ? const Center(child: Text('No data found'))
                  : Column(
                      children: [
                        ...widget.dataList
                            .map(
                              (data) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 12.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    for (var header in widget.columnHeaders)
                                      Expanded(
                                        child: Text(
                                            data[header.toLowerCase()] ?? ''),
                                      ),
                                    // Actions column
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            if (widget.onEdit != null) {
                                              widget.onEdit!(data['id']);
                                            }
                                          },
                                          icon: const Icon(Icons.edit),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            if (widget.onDelete != null) {
                                              widget.onDelete!(data['id']);
                                            }
                                          },
                                          icon: const Icon(Icons.delete),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ],
                    ),
        ],
      ),
    );
  }
}
