import 'package:flutter/material.dart';

import '../../components/styleButton.dart';
import 'package:pdf/widgets.dart' as p;
import 'package:printing/printing.dart';

class GetInvoice extends StatefulWidget {
  const GetInvoice({super.key});

  @override
  State<GetInvoice> createState() => _GetInvoiceState();
}

class _GetInvoiceState extends State<GetInvoice> {

  void createBreadRoleBaking() async {
    List<p.Widget> widgets = [];
  /*  final ByteData image = await rootBundle.load('images/breadRoll.png');
    Uint8List imageData = (image).buffer.asUint8List();*/
    //pdf document
    final pdf = p.Document();


  @override
  Widget build(BuildContext context) {
    return StyleButton(
        description: "Get Invoice",
        height: 55,
        width: 125,
        onTap: () {
          
        });
  }
}
