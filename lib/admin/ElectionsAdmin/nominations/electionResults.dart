import 'package:flutter/material.dart';
import 'package:sama/admin/ElectionsAdmin/nominations/ui/electionProcessUi/NomintaionAcceptanceRound.dart';
import 'package:sama/admin/ElectionsAdmin/nominations/ui/electionProcessUi/Round1NominationsFinished.dart';
import 'package:sama/admin/ElectionsAdmin/nominations/ui/electionProcessUi/Round2Election.dart';
import 'package:sama/admin/ElectionsAdmin/nominations/ui/electionProcessUi/chairMemberRound.dart';

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
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        widget.branch,
        style: TextStyle(
            fontSize: 22,
            color: Color(0xFF174486),
            fontWeight: FontWeight.bold),
      ),
      Round1NominationsFinished(
          nominationStartDate: widget.nominationStartDate,
          nominationEndDate: widget.nominationEndDate,
          electionId: widget.electionId,
          hdiCompliant: widget.hdiCompliant),
      SizedBox(
        height: 50,
      ),
      NominationAcceptanceRound(
          nominateAcceptEndDate: widget.nominateAcceptStartDate,
          nominateAcceptStartDate: widget.nominateAcceptEndDate,
          electionId: widget.electionId),
      SizedBox(
        height: 50,
      ),
      Round2Election(
          electionDateStart: widget.electionDateStart,
          electionDateEnd: widget.electionDateEnd,
          electionId: widget.electionId,
          electionVotes: widget.electionVotes,
          hdiCompliant: widget.hdiCompliant),
      SizedBox(
        height: 50,
      ),
      ChairMemberRound(
        chairMemberEndDate: widget.chairmanStartDate,
        chairMemberStartDate: widget.chairmanEndDate,
        chairMemberVoteList: widget.chairMemberVoteList,
        electionId: widget.electionId,
      )
    ]);
  }
}
