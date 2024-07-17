import 'package:flutter/material.dart';

class ElectionOverviewItem extends StatefulWidget {
  final String voteTitle;
  final String startDate;
  final String endDate;
  final VoidCallback exportToExcel;
  const ElectionOverviewItem(
      {super.key,
      required this.voteTitle,
      required this.startDate,
      required this.endDate,
      required this.exportToExcel});

  @override
  State<ElectionOverviewItem> createState() => _ElectionOverviewItemState();
}

class _ElectionOverviewItemState extends State<ElectionOverviewItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 10, 45, 10),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 35,
              ),
              Text(
                widget.voteTitle,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF6A6A6A),
                ),
              ),
              Spacer(),
              SizedBox(
                child: Row(
                  children: [
                    Text(
                      widget.startDate,
                      style: TextStyle(
                          color: Color(0xFF6A6A6A),
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      ' - ',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      widget.endDate,
                      style: TextStyle(
                          color: Color(0xFF6A6A6A),
                          fontWeight: FontWeight.w500,
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
              Spacer(),
              InkWell(
                onTap: () {
                  widget.exportToExcel();
                },
                child: Text(
                  "Export Result in Excel",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 18),
                ),
              ),
              SizedBox(
                width: 25,
              )
            ],
          ),
          Divider(
            color: Color(0xFFD1D1D1),
          ),
        ],
      ),
    );
  }
}
