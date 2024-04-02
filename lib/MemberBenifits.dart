import 'package:flutter/material.dart';
import 'package:sama/components/CompanyContainer.dart';
import 'package:sama/components/NewsContainer.dart';
import 'package:sama/components/myutility.dart';

class MemberBenifits extends StatefulWidget {
  const MemberBenifits({super.key});

  @override
  State<MemberBenifits> createState() => _MemberBenifitsState();
}

class _MemberBenifitsState extends State<MemberBenifits> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SAMA Member Benefits',
            style: TextStyle(
                fontSize: 32,
                color: Color(0xFF3D3D3D),
                fontWeight: FontWeight.normal),
          ),
          SizedBox(
            height: MyUtility(context).height * 0.05,
          ),
          CompanyContainer(
              image: 'images/company.jpg',
              companyname: 'Company name',
              discription: 'Description of company'),
          CompanyContainer(
              image: 'images/company.jpg',
              companyname: 'Company name',
              discription: 'Description of company')
        ],
      ),
    );
  }
}
