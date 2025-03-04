import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../components/myutility.dart';

class PaymentTextreu extends StatefulWidget {
  final String boldText;
  final String secondText;

  PaymentTextreu({super.key, required this.boldText, required this.secondText});

  @override
  State<PaymentTextreu> createState() => _PaymentTextreuState();
}

class _PaymentTextreuState extends State<PaymentTextreu> {
  @override
  Widget build(BuildContext context) {
    bool isMobile = MyUtility(context).width < 600 ? true : false;
    return Row(
      mainAxisAlignment:
          isMobile ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: GoogleFonts.openSans(
              fontSize: isMobile ? 22 : 16,
              color: Colors.grey[800],
            ),
            children: <TextSpan>[
              TextSpan(
                text: '${widget.boldText}: ',
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.bold, letterSpacing: -0.5),
              ),
              TextSpan(
                text: widget.secondText,
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                    letterSpacing: -0.5),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PaymentTextPr extends StatefulWidget {
  final String boldText;
  final String secondText;

  PaymentTextPr({super.key, required this.boldText, required this.secondText});

  @override
  State<PaymentTextPr> createState() => _PaymentTextPrState();
}

class _PaymentTextPrState extends State<PaymentTextPr> {
  @override
  Widget build(BuildContext context) {
    bool isMobile = MyUtility(context).width < 600 ? true : false;
    return Wrap(
      alignment: WrapAlignment.center,
      children: [
        RichText(
          text: TextSpan(
            style: GoogleFonts.openSans(
              fontSize: isMobile ? 22 : 16,
              color: Colors.grey[800],
            ),
            children: <TextSpan>[
              TextSpan(
                text: isMobile
                    ? '${widget.boldText}: '
                    : '${widget.boldText}: \n',
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.bold, letterSpacing: -0.5),
              ),
              TextSpan(
                text: widget.secondText,
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[600],
                    letterSpacing: -0.5),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class JournalCheckBox extends StatefulWidget {
  final String title;
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  JournalCheckBox({
    required this.title,
    this.initialValue = false,
    required this.onChanged,
  });

  @override
  _JournalCheckBoxState createState() => _JournalCheckBoxState();
}

class _JournalCheckBoxState extends State<JournalCheckBox> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MyUtility(context).width < 600 ? true : false;
    return InkWell(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
        widget.onChanged(isChecked);
      },
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Checkbox(
            value: isChecked,
            onChanged: (bool? value) {
              setState(() {
                isChecked = value ?? false;
              });
              widget.onChanged(isChecked);
            },
          ),
          SizedBox(width: 8),
          Text(
            widget.title,
            style: TextStyle(
              fontSize: isMobile ? 20 : 14,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
