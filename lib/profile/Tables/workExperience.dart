
import 'package:flutter/material.dart';


import '../../components/myutility.dart';

class WorkExperience extends StatefulWidget {
  const WorkExperience({super.key});

  @override
  State<WorkExperience> createState() => _WorkExperienceState();
}

class _WorkExperienceState extends State<WorkExperience> {
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
                      'Start',
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
                      'End',
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
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(''),
                  ),
                ),
              ],
            ),
            ...List.generate(
              3,
              (index) =>  TableRow(
                decoration: BoxDecoration(
                  
                  color: index % 2 == 0 ? Color(0xFFF8FAFF)  : Color.fromRGBO(174, 204, 236, 1),  
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
                        '06 May 2017',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        '06 May 2017',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Test 1',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
