import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../components/myutility.dart';

class OrganisationsTable extends StatefulWidget {
  List organizations;

  Function(int) removeOrganization;
  OrganisationsTable(
      {super.key,
      required this.removeOrganization,
      required this.organizations});

  @override
  State<OrganisationsTable> createState() => _OrganisationsTableState();
}

class _OrganisationsTableState extends State<OrganisationsTable> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MyUtility(context).width / 1.7,
      //height: 500,
      child: Center(
        child: Table(
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            const TableRow(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 233, 232, 232),
              ),
              children: [
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Organisation name',
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
                      'Position/Role',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
            ...List.generate(
              widget.organizations.length,
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
                        widget.organizations[index]['organizationName'],
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        widget.organizations[index]['organizationRole'],
                        style: TextStyle(fontSize: 16),
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
