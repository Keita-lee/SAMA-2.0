import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';

class Legendindicators extends StatelessWidget {
  const Legendindicators({super.key});

  @override
  Widget build(BuildContext context) {
    return // Legend Indicators
        Center(
      child: Container(
        width: MyUtility(context).width * 0.745,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child: Row(
                children: [
                  _buildLegendIndicator(Color(0xff0c6e08), "Active"),
                  _buildLegendIndicator(
                      Color.fromARGB(255, 175, 0, 0), "Inactive"),
                  _buildLegendIndicator(Color(0xffd1d1d1), "Pending"),
                ],
              ),
            ),
            // Container(
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       StyleButton(
            //           description: 'Filter',
            //           height: 40,
            //           width: 50,
            //           onTap: () {}),
            //       const SizedBox(width: 16),
            //       StyleButton(
            //           description: 'Excel Export',
            //           height: 40,
            //           width: 40,
            //           onTap: () {}),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

Widget _buildLegendIndicator(Color color, String text) {
  return Padding(
    padding: const EdgeInsets.only(right: 16.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 6,
          backgroundColor: color,
        ),
        const SizedBox(width: 8),
        Text(text),
      ],
    ),
  );
}
