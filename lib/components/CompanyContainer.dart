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
  final VoidCallback openMemberDetails;

  const CompanyContainer(
      {super.key,
      required this.userType,
      required this.image,
      required this.companyname,
      required this.discription,
      required this.editCompanyDetails,
      required this.openMemberDetails});

  @override
  State<CompanyContainer> createState() => _CompanyContainerState();
}

class _CompanyContainerState extends State<CompanyContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Color.fromARGB(136, 169, 170, 170),
            )),
        width: MyUtility(context).width * 0.55,
        height: 120,
        child: Row(
          children: [
            SizedBox(
              width: 15,
            ),
            ImageNetwork(
              onTap: () {
                widget.openMemberDetails();
              },
              image: widget.image,
              width: 150,
              height: 90,
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
              width: MyUtility(context).width * 0.55 - 230,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.companyname,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(0, 159, 158, 1),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    widget.discription,
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF3D3D3D),
                    ),
                  ),
                  Row(
                    children: [
                      Spacer(),
                      StyleButton(
                        buttonColor: Color.fromRGBO(0, 159, 158, 1),
                        description: 'View',
                        height: 40,
                        width: 80,
                        onTap: () {
                          widget.openMemberDetails();
                        },
                      ),
                      Visibility(
                        visible: widget.userType == "Admin" ? true : false,
                          child: SizedBox(
                        width: 10,
                      )),
                      Visibility(
                        visible: widget.userType == "Admin" ? true : false,
                        child: StyleButton(
                            description: "Edit",
                            height: 40,
                            width: 125,
                            onTap: () {
                              widget.editCompanyDetails();
                            }),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
