import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sama/homePage/dashboard/ui/newDashboardUi/dashboardTextButton.dart';

class DashboardInfoContainers extends StatefulWidget {
  final double height;
  final Color topBarColor;
  final String image;
  final String header;
  final Widget child;
  final Color? svgColor;
  final Color? extendedTopBarColor;
  final bool? activeTopBar;
  final Color? borderColor;
  final bool? headerTextButton;
  const DashboardInfoContainers(
      {super.key,
      required this.height,
      required this.topBarColor,
      required this.image,
      required this.header,
      required this.child,
      this.svgColor,
      this.extendedTopBarColor,
      this.activeTopBar,
      this.borderColor,
      this.headerTextButton});

  @override
  State<DashboardInfoContainers> createState() =>
      _DashboardInfoContainersState();
}

class _DashboardInfoContainersState extends State<DashboardInfoContainers> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color.fromARGB(255, 190, 190, 190)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: widget.activeTopBar == null ? true : false,
            child: Container(
              width: 300,
              height: 10,
              decoration: BoxDecoration(
                color: widget.topBarColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: widget.extendedTopBarColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  SvgPicture.asset(
                    widget.image,
                    height: 22,
                    color: widget.svgColor == null
                        ? Color.fromRGBO(237, 157, 4, 1)
                        : widget.svgColor,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    widget.header,
                    style: GoogleFonts.openSans(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Visibility(
                    visible: widget.headerTextButton == true,
                    child: DashboardTextButton(
                      decorationColor: Colors.black,
                      textColor: Colors.black,
                      text: 'Turn off',
                      onTap: () {},
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          widget.child
        ],
      ),
    );
  }
}
