import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as p;

import '../../components/styleButton.dart';

class GetInvoice2 extends StatefulWidget {
  const GetInvoice2({super.key});

  @override
  State<GetInvoice2> createState() => _GetInvoice2State();
}

class _GetInvoice2State extends State<GetInvoice2> {
  void createInvoice() async {
    List<p.Widget> widgets = [];
    final ByteData image = await rootBundle.load('images/sama_logo.png');
    Uint8List logo = (image).buffer.asUint8List(); /* */
    //pdf document
    final pdf = p.Document();
    pdf.addPage(
      p.Page(
        pageFormat: PdfPageFormat.a4,
        //pageTheme: pageTheme,
        build: (context) => p.Stack(children: [
          p.Row(children: []),
          p.Container(
              width: 250.0,
              height: 250.0,
              child: p.Center(child: p.Image(p.MemoryImage(logo)))),
          p.Text("TEST"),
          /*  p.Container(
              width: 650.0,
              height: 1000.0,
              child: p.Center(child: p.Image(p.MemoryImage(logo)))),*/
        ]),
      ),
    );

    Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  void createBreadRoleBaking() async {
    List<p.Widget> widgets = [];
    final ByteData image = await rootBundle.load('assets/images/speech.png');
    Uint8List imageData = (image).buffer.asUint8List();
    //pdf document
    final pdf = p.Document();
    pdf.addPage(
      p.Page(
        pageFormat: PdfPageFormat.a4,
        //pageTheme: pageTheme,
        build: (context) => p.Stack(children: [
          p.Container(
              width: 650.0,
              height: 1000.0,
              child: p.Center(child: p.Image(p.MemoryImage(imageData)))),
          p.Positioned(
            top: 325,
            left: 120,
            child: p.SizedBox(
              width: 150,
              child: p.Text(
                "",
                style: const p.TextStyle(
                  fontSize: 17,
                ),
              ),
            ),
          ),
          p.Positioned(
            top: 678,
            left: 60,
            child: p.SizedBox(
              width: 150,
              child: p.Text(
                "",
                style: const p.TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          )
        ]),
      ),
    );
    Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StyleButton(
        description: "Get Invoice123",
        height: 55,
        width: 125,
        onTap: () {
          createInvoice();
        });
  }
}
