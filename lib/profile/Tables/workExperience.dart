import 'package:flutter/material.dart';

import '../../components/myutility.dart';

class WorkExperience extends StatefulWidget {
  List workExperienceList;
  Function(int) removeExperience;
  String? memberView;
  WorkExperience(
      {super.key,
      required this.workExperienceList,
      required this.removeExperience,
      this.memberView});

  @override
  State<WorkExperience> createState() => _WorkExperienceState();
}

class _WorkExperienceState extends State<WorkExperience> {
  @override
  Widget build(BuildContext context) {
    bool isMobile = MyUtility(context).width < 600 ? true : false;
    return SizedBox(
      width:
          isMobile ? MyUtility(context).width : MyUtility(context).width / 1.7,
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
                    child: Center(
                      // Centering the text
                      child: Text(
                        'Start',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Center(
                      // Centering the text
                      child: Text(
                        'End',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.middle,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Center(
                      // Centering the text
                      child: Text(
                        'Description',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
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
              widget.workExperienceList.length,
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
                      child: Center(
                        // Centering the text
                        child: Text(
                          widget.workExperienceList[index]
                              ['workExperienceFrom'],
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        // Centering the text
                        child: Text(
                          widget.workExperienceList[index]['workExperienceTo'],
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  TableCell(
                    verticalAlignment: TableCellVerticalAlignment.middle,
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        // Centering the text
                        child: Text(
                          widget.workExperienceList[index]
                              ['workExperienceDescription'],
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: widget.memberView != null ? false : true,
                    child: TableCell(
                      verticalAlignment: TableCellVerticalAlignment.middle,
                      child: InkWell(
                        onTap: () {
                          widget.removeExperience(index);
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
            )
          ],
        ),
      ),
    );
  }
}
