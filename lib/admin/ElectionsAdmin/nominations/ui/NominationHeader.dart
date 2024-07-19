import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sama/admin/ElectionsAdmin/nominations/ui/nominationForm.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/styleButton.dart';

class NominationHeader extends StatefulWidget {
  TextEditingController controller;
  String electionId;
  VoidCallback openElectionForm;
  Function(int) changePageIndex;
  int pageIndex;
  NominationHeader(
      {super.key,
      required this.controller,
      required this.electionId,
      required this.openElectionForm,
      required this.changePageIndex,
      required this.pageIndex});

  @override
  State<NominationHeader> createState() => _NominationHeaderState();
}

class _NominationHeaderState extends State<NominationHeader> {
  //var
  List items = [
    'Border Coastal (BCB)',
    'Cape Western (CWB)',
    'Eastern Highveld (ETB)',
    'Eastern Province(EPB)',
    'Free State (OFS)',
    'Gauteng (STB)',
    'Gauteng North (NTB)',
    'GoldFields (GFB)',
    'GoldFields (GFB)',
    'Griqualand West (GWB)',
    'KZN Coastal (NCB)',
    'KZN Midlands (NIB)',
    'KZN Northen (NNB)',
    'Limpopo (SPB)',
    'Lowveld (LVB)',
    'North West (WTB)',
    'Outeniqua (OQB)',
    'Transkei (TRB)',
    'Tygerberg Boland (TBB)',
    'Vaal River (VR)',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
      child: Row(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Spacer(),
          /*  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select a Branch",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF6A6A6A),
                ),
              ),
              DropdownMenu<String>(
                width: 250,
                controller: widget.controller,
                requestFocusOnTap: true,
                label: const Text(''),
                onSelected: (value) {
                  setState(() {
                    //widget.getCategoryValue(value!);
                  });
                },
                dropdownMenuEntries:
                    items.map<DropdownMenuEntry<String>>((value) {
                  return DropdownMenuEntry<String>(
                    value: value,
                    label: value,
                  );
                }).toList(),
              ),
            ],
          ),
          SizedBox(
            width: 15,
          ),*/
          Visibility(
            visible: widget.electionId == "" &&
                    widget.pageIndex != 1 &&
                    widget.pageIndex != 2
                ? true
                : false,
            child: StyleButton(
                description: "New",
                height: 55,
                width: 125,
                onTap: () {
                  widget.openElectionForm();
                }),
          ),
          SizedBox(
            width: 15,
          ),
          Visibility(
            visible:
                widget.electionId == "" && widget.pageIndex == 0 ? true : false,
            child: StyleButton(
                description: "OverView",
                height: 55,
                width: 125,
                onTap: () {
                  widget.changePageIndex(3);
                }),
          ),
          Visibility(
            visible:
                widget.electionId == "" && widget.pageIndex == 3 ? true : false,
            child: StyleButton(
                description: "View All",
                height: 55,
                width: 125,
                onTap: () {
                  widget.changePageIndex(0);
                }),
          ),

          /*  Visibility(
            visible: widget.electionId != "" ? true : false,
            child: StyleButton(
                description: "Exit",
                height: 55,
                width: 175,
                onTap: () {
                  widget.changePageIndex(0);
                }),
          ),
          SizedBox(
            width: 15,
          ),
          Visibility(
            visible:
                widget.electionId != "" && widget.pageIndex != 2 ? true : false,
            child: StyleButton(
                description: "OverView",
                height: 55,
                width: 125,
                onTap: () {
                  widget.changePageIndex(2);
                }),
          ),
          Visibility(
            visible:
                widget.electionId != "" && widget.pageIndex != 1 ? true : false,
            child: StyleButton(
                description: "View Setup",
                height: 55,
                width: 125,
                onTap: () {
                  widget.changePageIndex(1);
                }),
          ),
          SizedBox(
            width: 15,
          ),
             StyleButton(
              description: "View All",
              height: 55,
              width: 125,
              onTap: () {}) */
        ],
      ),
    );
  }
}
