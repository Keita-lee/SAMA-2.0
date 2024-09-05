import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as p;

import '../../components/styleButton.dart';

class GetInvoice2 extends StatefulWidget {
  String ref;
  String documentDate;
  String dueDate;
  String title;
  String name;
  String memberId;

  GetInvoice2({
    super.key,
    required this.ref,
    required this.documentDate,
    required this.dueDate,
    required this.title,
    required this.name,
    required this.memberId,
  });

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
        build: (context) =>
            p.Column(crossAxisAlignment: p.CrossAxisAlignment.start, children: [
          p.Row(children: [
            p.Column(crossAxisAlignment: p.CrossAxisAlignment.start, children: [
              p.Text(
                "The South African Medical Associations",
                style: p.TextStyle(
                  fontWeight: p.FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              p.SizedBox(height: 10),
              p.Text(
                "Incorporated Association not for Gain",
                style: p.TextStyle(
                  fontSize: 6,
                ),
              ),
              p.Text(
                "Reg. No. 1927/00136/08",
                style: p.TextStyle(
                  fontSize: 6,
                ),
              ),
              p.SizedBox(height: 10),
              p.Text(
                "Block F, Castle Walk Business Park Erasmuskloof \nExt 3, Pretoria, South Africa\nP.O. Box 74789, LYNWOODRIDGE, 0040",
                style: p.TextStyle(
                  fontWeight: p.FontWeight.bold,
                  fontSize: 10,
                ),
              ),
              p.SizedBox(height: 10),
              p.Text(
                "Telephone: (012) 481-2071\nFax Number: (086) 634-9656",
                style: p.TextStyle(
                  fontWeight: p.FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ]),
            p.Spacer(),
            p.Container(
                width: 100.0,
                height: 100.0,
                child: p.Center(child: p.Image(p.MemoryImage(logo)))),
          ]),
          p.SizedBox(height: 15),
          p.Row(children: [
            p.Container(
              width: 250,
              height: 100,
              decoration: p.BoxDecoration(
                  border: p.Border.all(
                width: 1.5,
              )),
              child: p.Column(
                crossAxisAlignment: p.CrossAxisAlignment.start,
                children: [
                  p.Text(
                    "MEMBER DETAIL",
                    style: p.TextStyle(
                      fontWeight: p.FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            p.Column(
              children: [],
            ),
            p.Spacer(),
          ]),
          p.SizedBox(height: 15),
          p.Row(children: [
            p.Text(
              "Description",
              style: p.TextStyle(
                fontWeight: p.FontWeight.bold,
                fontSize: 12,
              ),
            ),
            p.Spacer(),
            p.Text(
              "Amount",
              style: p.TextStyle(
                fontWeight: p.FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ]),
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
