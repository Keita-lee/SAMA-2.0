import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BranchVotingItems extends StatefulWidget {
  final String voteTitle;
  final String startDate;
  final String endDate;
  final String voteDuration;
  const BranchVotingItems(
      {super.key,
      required this.voteTitle,
      required this.startDate,
      required this.endDate,
      required this.voteDuration});

  @override
  State<BranchVotingItems> createState() => _BranchVotingItemsState();
}

class _BranchVotingItemsState extends State<BranchVotingItems> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                widget.voteTitle,
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
              ),
              Spacer(),
              SizedBox(
                child: Row(
                  children: [
                    Text(
                      widget.startDate,
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                    Text(
                      ' - ',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                    Text(
                      widget.endDate,
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                widget.voteDuration,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
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
