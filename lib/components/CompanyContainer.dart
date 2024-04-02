import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:sama/components/myutility.dart';

class CompanyContainer extends StatefulWidget {
  final String image;
  final String companyname;
  final String discription;

  const CompanyContainer({
    super.key,
    required this.image,
    required this.companyname,
    required this.discription,
  });

  @override
  State<CompanyContainer> createState() => _CompanyContainerState();
}

class _CompanyContainerState extends State<CompanyContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyUtility(context).width / 1.3,
      height: MyUtility(context).height * 0.2,
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Color(0xFF3D3D3D), width: 1.0))),
      child: Row(
        children: [
          ImageNetwork(
            image: widget.image,
            width: MyUtility(context).width * 0.12,
            height: 100,
            fitWeb: BoxFitWeb.cover,
          ),
          /*  Container(
            width: MyUtility(context).width * 0.12,
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(widget.image),
                fit: BoxFit.cover,
              ),
            ),
          ),*/
          SizedBox(width: MyUtility(context).width * 0.01),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.companyname,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3D3D3D),
                ),
              ),
              SizedBox(height: 4),
              Text(
                widget.discription,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF3D3D3D),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
