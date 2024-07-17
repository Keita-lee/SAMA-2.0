import 'package:flutter/material.dart';
import 'package:sama/admin/ElectionsAdmin/nominations/ui/electionProcessUi/NomintaionAcceptanceRound.dart';
import 'package:sama/admin/ElectionsAdmin/nominations/ui/electionProcessUi/Round1NominationsFinished.dart';
import 'package:sama/admin/ElectionsAdmin/nominations/ui/electionProcessUi/Round2Election.dart';
import 'package:sama/admin/ElectionsAdmin/nominations/ui/electionProcessUi/chairMemberRound.dart';
import 'package:sama/admin/ElectionsAdmin/nominations/ui/tabStyle.dart';

class ElectionResults extends StatefulWidget {
  String branch;
  String nominationStartDate;
  String nominationEndDate;
  String nominateAcceptStartDate;
  String nominateAcceptEndDate;
  String electionDateStart;
  String electionDateEnd;
  String electionId;
  String chairmanStartDate;
  String chairmanEndDate;
  List electionVotes;
  List chairMemberVoteList;
  bool hdiCompliant;
  ElectionResults({
    super.key,
    required this.branch,
    required this.nominationStartDate,
    required this.nominationEndDate,
    required this.nominateAcceptStartDate,
    required this.nominateAcceptEndDate,
    required this.electionDateStart,
    required this.electionDateEnd,
    required this.electionId,
    required this.chairmanStartDate,
    required this.chairmanEndDate,
    required this.electionVotes,
    required this.chairMemberVoteList,
    required this.hdiCompliant,
  });

  @override
  State<ElectionResults> createState() => _ElectionResultsState();
}

class _ElectionResultsState extends State<ElectionResults> {
  var resultsIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        height: 25,
      ),
      Text(
        widget.branch,
        style: TextStyle(
            fontSize: 22,
            color: Color(0xFF174486),
            fontWeight: FontWeight.bold),
      ),
      SizedBox(
        height: 25,
      ),
      Row(
        children: [
          Tabstyle(
            pageIndex: resultsIndex,
            changePage: () {
              setState(() {
                resultsIndex = 0;
              });
            },
            tabIndexNumber: 0,
            description: "Round 1",
            customWidth: 150,
            customColor1: Color.fromARGB(255, 7, 124, 179),
            customColor2: Color.fromARGB(255, 8, 55, 145),
          ),
          Tabstyle(
            pageIndex: resultsIndex,
            changePage: () {
              setState(() {
                resultsIndex = 1;
              });
            },
            tabIndexNumber: 1,
            description: "Acceptance Round",
            customWidth: 150,
            customColor1: Color.fromARGB(255, 7, 124, 179),
            customColor2: Color.fromARGB(255, 8, 55, 145),
          ),
          Tabstyle(
            pageIndex: resultsIndex,
            changePage: () {
              setState(() {
                resultsIndex = 2;
              });
            },
            tabIndexNumber: 2,
            description: "Round2",
            customWidth: 150,
            customColor1: Color.fromARGB(255, 7, 124, 179),
            customColor2: Color.fromARGB(255, 8, 55, 145),
          ),
          Tabstyle(
            pageIndex: resultsIndex,
            changePage: () {
              setState(() {
                resultsIndex = 3;
              });
            },
            tabIndexNumber: 3,
            description: "Chair Person",
            customWidth: 150,
            customColor1: Color.fromARGB(255, 7, 124, 179),
            customColor2: Color.fromARGB(255, 8, 55, 145),
          ),
        ],
      ),
      SizedBox(
        height: 25,
      ),
      Visibility(
        visible: resultsIndex == 0 ? true : false,
        child: Round1NominationsFinished(
            nominationStartDate: widget.nominationStartDate,
            nominationEndDate: widget.nominationEndDate,
            electionId: widget.electionId,
            hdiCompliant: widget.hdiCompliant),
      ),
      Visibility(
        visible: resultsIndex == 1 ? true : false,
        child: NominationAcceptanceRound(
            nominateAcceptEndDate: widget.nominateAcceptStartDate,
            nominateAcceptStartDate: widget.nominateAcceptEndDate,
            electionId: widget.electionId),
      ),
      Visibility(
        visible: resultsIndex == 2 ? true : false,
        child: Round2Election(
            electionDateStart: widget.electionDateStart,
            electionDateEnd: widget.electionDateEnd,
            electionId: widget.electionId,
            electionVotes: widget.electionVotes,
            hdiCompliant: widget.hdiCompliant),
      ),
      Visibility(
        visible: resultsIndex == 3 ? true : false,
        child: ChairMemberRound(
          chairMemberEndDate: widget.chairmanStartDate,
          chairMemberStartDate: widget.chairmanEndDate,
          chairMemberVoteList: widget.chairMemberVoteList,
          electionId: widget.electionId,
        ),
      )
    ]);
  }
}
