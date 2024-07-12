import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';

class BranchVotingContainer extends StatefulWidget {
  final String branchTitle;
  final String count;
  final bool isInProgress;
  final bool isChairpersonActive;
  final List<Widget> votingItems;
  const BranchVotingContainer(
      {super.key,
      required this.branchTitle,
      required this.count,
      required this.isInProgress,
      required this.isChairpersonActive,
      required this.votingItems});

  @override
  State<BranchVotingContainer> createState() => _BranchVotingContainerState();
}

class _BranchVotingContainerState extends State<BranchVotingContainer> {
  @override
  Widget build(BuildContext context) {
    return  Container(
        width: MyUtility(context).width * 0.60,
        height: 450,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Color(0xFFD1D1D1),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  height: 55,
                  width: 160,
                  decoration: BoxDecoration(
                    color: widget.isInProgress
                        ? Color.fromRGBO(0, 159, 12, 1)
                        : Color(0xFFD1D1D1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),
                  child: Center(
                    child: Text(
                      widget.isInProgress ? 'In progress' : 'Draft',
                      style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.1,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MyUtility(context).width * 0.55,
              child: Row(
                children: [
                  Text(
                    widget.branchTitle,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                  ),
                  Spacer(),
                  Container(
                    width: 100,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 8, 55, 145),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        'Manage',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MyUtility(context).width * 0.55,
              child: Column(
                children: widget.votingItems,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MyUtility(context).width * 0.55,
              child: Row(
                children: [
                  Text('Count: ${widget.count}', style: TextStyle(fontSize: 20),),
                  const SizedBox(
                    width: 30,
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'Chairperson voting: '),
                        TextSpan(
                            text: widget.isChairpersonActive
                                ? 'Active'
                                : 'Disabled'),
                      ],
                    ),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      
    );
  }
}
