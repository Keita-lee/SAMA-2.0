import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sama/components/mobile/components/Themes/custom_colors.dart';

class InfoDropdown extends StatefulWidget {
  final String title;
  final String icon; // Changed from String imagePath
  final String description;
  final Widget content;

  const InfoDropdown(
      {super.key,
      required this.title,
      required this.icon, // Changed from imagePath
      required this.description,
      required this.content});

  @override
  State<InfoDropdown> createState() => _InfoDropdownState();
}

class _InfoDropdownState extends State<InfoDropdown> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final dropdownWidth = screenWidth - 20; // 10 pixels padding on each side

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Visibility(
              visible: !_isExpanded,
              child: Container(
                width: dropdownWidth,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: CustomColors.lightGrey, // Light grey border color
                    width: 1, // Border width
                  ),
                ),
                child: Row(
                  children: [
                    Visibility(
                      visible: !_isExpanded,
                      child: SvgPicture.asset(
                        widget.icon, // Changed from Image.asset
                        color: CustomColors.yellow,
                        height: 30,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        widget.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Icon(
                      _isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                      size: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
              visible: _isExpanded,
              child: Container(
                  width: dropdownWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: CustomColors.lightGrey, // Light grey border color
                      width: 1, // Border width
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              _isExpanded = !_isExpanded;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Text(
                                //   widget.title,
                                //   style: const TextStyle(
                                //     fontSize: 14,
                                //     color: Colors.grey,
                                //     fontWeight: FontWeight.w500,
                                //   ),
                                // ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  size: 30,
                                ),
                              ],
                            ),
                          )),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: widget.content,
                      )
                    ],
                  ))),
          /*  if (_isExpanded)
            Container(
              width: dropdownWidth,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Text(
                widget.description,
                style: const TextStyle(fontSize: 16),
              ),
            ),*/
        ],
      ),
    );
  }
}
