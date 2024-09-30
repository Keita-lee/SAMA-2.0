import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as p;

void createInvoice(List<Map<String, dynamic>> products,
    Map<String, dynamic> customerDetails) async {
  final ByteData image = await rootBundle.load('images/sama_logo.png');
  Uint8List logo = (image).buffer.asUint8List();

  // Function to calculate VAT when price includes VAT
  double calculateVATInclusive(double price) {
    double vatRate = 0.15;
    return (price / (1 + vatRate)) * vatRate;
  }

  // Calculate subtotal, VAT, and total

  double totalVAT = 0;
  double total = 0;
  print(products);
  for (var product in products) {
    total = product['quantity'] * double.parse(product['productPrice']);
    totalVAT += product['quantity'] *
        calculateVATInclusive(double.parse(product['productPrice']));
  }

  double subtotal = total - totalVAT;

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
                child: p.Padding(
                  padding: p.EdgeInsets.all(
                      10), // Adds padding on all sides (10 units)
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
                      p.SizedBox(height: 5),
                      p.Text("Name: ${customerDetails['name'].split('\n')[0]}"),
                      p.Text("Email: ${customerDetails['email']}"),
                      p.Text("Mobile Number: ${customerDetails['mobile']}"),
                    ],
                  ),
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
                      'R${(product['quantity'] * double.parse(product['productPrice'])).toStringAsFixed(2)}'),
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
                    mainAxisAlignment: p.MainAxisAlignment.spaceBetween,
                    children: [
                      p.Text("Subtotal: "),
                      p.Text('R${subtotal.toStringAsFixed(2)}'),
                    ],
                  ),
                  p.Row(
                    mainAxisAlignment: p.MainAxisAlignment.spaceBetween,
                    children: [
                      p.Text("VAT (15%): "),
                      p.Text('R${totalVAT.toStringAsFixed(2)}'),
                    ],
                  ),
                  p.Row(
                    mainAxisAlignment: p.MainAxisAlignment.spaceBetween,
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

  try {
    // Output the PDF
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  } catch (e) {
    print('error printing pdf: $e');
  }
}
