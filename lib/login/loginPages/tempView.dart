import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/components/myutility.dart';

class TempView extends StatefulWidget {
  String type;
  TempView({super.key, required this.type});

  @override
  State<TempView> createState() => _TempViewState();
}

class _TempViewState extends State<TempView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: widget.type == "Login",
          child: Container(
              width: MyUtility(context).width / 1.5,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Login",
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                        color: Color.fromRGBO(0, 159, 158, 1),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '“We’re almost there! The login feature is coming soon. Please check back later to access your account. Thank you for your patience!”',
                      style: GoogleFonts.openSans(
                        textStyle: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        color: Color.fromRGBO(90, 90, 90, 1),
                      ),
                    ),
                  ])),
        ),
        Visibility(
          visible: widget.type == "Registration",
          child: Container(
              //color: Colors.amber,
              //width: MyUtility(context).width ,
              //height: MyUtility(context).height / 2,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                /*  Image(
            width: MyUtility(context).width / 6,
            height: MyUtility(context).height / 3.5,
            image: AssetImage('images/sama_logo.png')),*/
                SizedBox(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Text(
                        "Register",
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                          color: Color.fromRGBO(0, 159, 158, 1),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: MyUtility(context).width / 2,
                        child: Text(
                          '“Exciting things are on the way! Registration will be available soon. Stay tuned for updates and check back later to create your account. We appreciate your understanding!”',
                          style: GoogleFonts.openSans(
                            textStyle: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                            color: Color.fromRGBO(90, 90, 90, 1),
                          ),
                        ),
                      ),
                    ]))
              ])),
        )
      ],
    );
  }
}
