import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as p;
import 'package:sama/components/styleButton.dart';

class GetOrderInvoice extends StatefulWidget {
  String ref;
  String documentDate;
  String dueDate;
  String title;
  String name;
  String memberId;
  List<Map<String, dynamic>> products;

  GetOrderInvoice({
    super.key,
    required this.ref,
    required this.documentDate,
    required this.dueDate,
    required this.title,
    required this.name,
    required this.memberId,
    required this.products,
  });

  @override
  State<GetOrderInvoice> createState() => _GetOrderInvoiceState();
}

class _GetOrderInvoiceState extends State<GetOrderInvoice> {
  void createInvoice(List<Map<String, dynamic>> products) async {
    final ByteData image = await rootBundle.load('images/sama_logo.png');
    Uint8List logo = (image).buffer.asUint8List();

    // Calculate subtotal, VAT, and total
    double subtotal = 0;
    products.forEach((product) {
      subtotal += product['quantity'] * product['productPrice'];
    });
    double vat = subtotal * 0.15;
    double total = subtotal + vat;

    // PDF document
    final pdf = p.Document();

    pdf.addPage(
      p.Page(
        pageFormat: PdfPageFormat.a4,
        build: (context) => p.Column(
          crossAxisAlignment: p.CrossAxisAlignment.start,
          children: [
            // Header with logo and company info
            p.Row(
              children: [
                p.Column(
                  crossAxisAlignment: p.CrossAxisAlignment.start,
                  children: [
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
                      style: p.TextStyle(fontSize: 6),
                    ),
                    p.Text(
                      "Reg. No. 1927/00136/08",
                      style: p.TextStyle(fontSize: 6),
                    ),
                    p.SizedBox(height: 10),
                    p.Text(
                      "Block F, Castle Walk Business Park, Erasmuskloof\nExt 3, Pretoria, South Africa\nP.O. Box 74789, LYNWOODRIDGE, 0040",
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
                  ],
                ),
                p.Spacer(),
                p.Container(
                  width: 100.0,
                  height: 100.0,
                  child: p.Center(child: p.Image(p.MemoryImage(logo))),
                ),
              ],
            ),
            p.SizedBox(height: 15),

            // Member details box
            p.Row(
              children: [
                p.Container(
                  width: 250,
                  height: 100,
                  decoration: p.BoxDecoration(
                    border: p.Border.all(width: 1.5),
                  ),
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
                      // Add member details here
                    ],
                  ),
                ),
                p.Spacer(),
              ],
            ),
            p.SizedBox(height: 15),

            // Product table headers
            p.Row(
              children: [
                p.Expanded(
                  child: p.Text(
                    "Description",
                    style: p.TextStyle(
                      fontWeight: p.FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                p.Text(
                  "Qty",
                  style: p.TextStyle(
                    fontWeight: p.FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                p.SizedBox(width: 20),
                p.Text(
                  "Amount",
                  style: p.TextStyle(
                    fontWeight: p.FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            p.Divider(),

            // Products list
            p.Column(
              children: products.map((product) {
                return p.Row(
                  children: [
                    p.Expanded(
                      child: p.Text(product['productName']),
                    ),
                    p.Text(product['quantity'].toString()),
                    p.SizedBox(width: 20),
                    p.Text(
                        'R${(product['quantity'] * product['productPrice']).toStringAsFixed(2)}'),
                  ],
                );
              }).toList(),
            ),
            p.SizedBox(height: 15),
            p.Divider(),

            // Subtotal, VAT, and total
            p.Row(
              children: [
                p.Spacer(),
                p.Column(
                  crossAxisAlignment: p.CrossAxisAlignment.start,
                  children: [
                    p.Row(
                      children: [
                        p.Text("Subtotal: "),
                        p.Text('R${subtotal.toStringAsFixed(2)}'),
                      ],
                    ),
                    p.Row(
                      children: [
                        p.Text("VAT (15%): "),
                        p.Text('R${vat.toStringAsFixed(2)}'),
                      ],
                    ),
                    p.Row(
                      children: [
                        p.Text(
                          "Total: ",
                          style: p.TextStyle(fontWeight: p.FontWeight.bold),
                        ),
                        p.Text(
                          'R${total.toStringAsFixed(2)}',
                          style: p.TextStyle(fontWeight: p.FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );

    // Output the PDF
    await Printing.layoutPdf(
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
          createInvoice(widget.products);
        });
  }
}
