import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/styleButton.dart';

class CompanyContainer extends StatefulWidget {
  final String userType;
  final String image;
  final String companyname;
  final String discription;
  final VoidCallback editCompanyDetails;

  const CompanyContainer(
      {super.key,
      required this.userType,
      required this.image,
      required this.companyname,
      required this.discription,
      required this.editCompanyDetails});

  @override
  State<CompanyContainer> createState() => _CompanyContainerState();
}

class _CompanyContainerState extends State<CompanyContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyUtility(context).width - MyUtility(context).width / 4,
      height: MyUtility(context).height * 0.2,
      child: Row(
        children: [
          ImageNetwork(
            image: widget.image,
            width: MyUtility(context).width * 0.12,
            height: 100,
            fitWeb: BoxFitWeb.contain,
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
          SizedBox(width: 15),
          SizedBox(
            width: MyUtility(context).width / 2,
            child: Column(
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
                )
              ],
            ),
          ),
          Visibility(
            visible: widget.userType == "Admin" ? true : false,
            child: StyleButton(
                description: "Edit",
                height: 55,
                width: 125,
                onTap: () {
                  widget.editCompanyDetails();
                }),
          )
        ],
      ),
    );
  }
}
