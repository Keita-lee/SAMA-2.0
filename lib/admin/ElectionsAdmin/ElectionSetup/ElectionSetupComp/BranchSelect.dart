import 'package:flutter/material.dart';
import 'package:sama/components/utility.dart';

class BranchSelect extends StatefulWidget {
  const BranchSelect({Key? key}) : super(key: key);

  @override
  State<BranchSelect> createState() => _BranchSelectState();
}

class _BranchSelectState extends State<BranchSelect> {
  final List<String> branchNames = [
    'Border Coastal (BCB)',
    'Cape Western (CWB)',
    'Eastern Highveld (ETB)',
    'Eastern Province (EPB)',
    'Free State (OFS)',
    'Gauteng (STB)',
    'Gauteng North (NTB)',
    'GoldFields (GFB)',
    'GriQuaLand West (GWB)',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
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
          )
        ],
      ),
      child: DropdownMenu(
        width: MyUtility(context).width * 0.55,
        hintText: 'Select Branch',
        textStyle: TextStyle(
          fontSize: 18,
          color: Color(0xFF3D3D3D),
          fontWeight: FontWeight.bold,
        ),
        enableFilter: true,
        dropdownMenuEntries: branchNames
            .map(
              (branchName) => DropdownMenuEntry(
                value: branchName,
                label: branchName,
              ),
            )
            .toList(),
      ),
    );
  }
}
