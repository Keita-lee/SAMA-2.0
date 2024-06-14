import 'package:flutter/material.dart';
import 'package:sama/admin/ElectionsAdmin/nominations/ui/nominationForm.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/styleButton.dart';

class NominationHeader extends StatefulWidget {
  TextEditingController controller;
  Function(String) openNominationForm;
  NominationHeader(
      {super.key, required this.controller, required this.openNominationForm});

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
        mainAxisAlignment: MainAxisAlignment.start,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MyUtility(context).width / 1.8,
          ),
          Column(
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
          ),
          StyleButton(
              description: "New Voting",
              height: 55,
              width: 125,
              onTap: () {
                widget.openNominationForm("");
              })
        ],
      ),
    );
  }
}
