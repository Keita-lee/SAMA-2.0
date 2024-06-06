import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';

final List<List<String>> tableData = [
  ['9088466', 'John Doe', 'HDI', '2'],
  ['9088466', 'Jane Smith', 'HDI', '8'],
  ['9088466', 'Alice Brown', 'HDI', '0'],
  ['9088466', 'Bob White', 'HDI', '12'],
  ['9088466', 'Eve Black', 'HDI', '3'],
  ['9088466', 'Tom Blue', 'HDI', '2'],
];

class NominatedMembers extends StatefulWidget {
  const NominatedMembers({Key? key}) : super(key: key);

  @override
  State<NominatedMembers> createState() => _NominatedMembersState();
}

class _NominatedMembersState extends State<NominatedMembers> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MyUtility(context).width * 0.65,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
        child: Container(
          decoration: ShapeDecoration(
            color: Color(0xFFFFF5F5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            shadows: [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 4,
                offset: Offset(0, 4),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Table(
              border: TableBorder.all(color: Colors.transparent),
              children: [
                TableRow(
                  children: [
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'SAMA NR',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF3D3D3D),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Name',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF3D3D3D),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'HDI Status',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF3D3D3D),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Nominations',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color(0xFF3D3D3D),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                for (var row in tableData)
                  TableRow(
                    children: [
                      for (int i = 0; i < row.length; i++)
                        TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: i == row.length - 1
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          row[i],
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Color(0xFF3D3D3D),
                                            fontWeight: FontWeight.normal,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Text(
                                    row[i],
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xFF3D3D3D),
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
