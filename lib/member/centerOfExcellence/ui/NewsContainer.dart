import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:intl/intl.dart';
import 'package:sama/components/myutility.dart';

class NewsContainer extends StatefulWidget {
  final Function(String) openArticleDialog;
  final String articleId;
  final String userType;
  final String image;
  final String category;
  final Timestamp date;
  final String header;
  final VoidCallback onPressed;
  final VoidCallback onArticleEdit;

  const NewsContainer(
      {super.key,
      required this.openArticleDialog,
      required this.articleId,
      required this.userType,
      required this.image,
      required this.category,
      required this.date,
      required this.header,
      required this.onPressed,
      required this.onArticleEdit});

  @override
  State<NewsContainer> createState() => _NewsContainerState();
}

class _NewsContainerState extends State<NewsContainer> {
  String _formatDateTime(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    String dayNumber = DateFormat('dd').format(dateTime);

    String month = DateFormat('MMMM').format(dateTime);
    String year = DateFormat('yyyy').format(dateTime);

    return '$dayNumber $month $year ';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyUtility(context).width / 4.7,
      height: widget.userType == "Admin" ? 585 : 500,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Color(0xFFD1D1D1),
          )),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: MyUtility(context).width / 4.7,
                height: MyUtility(context).height * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFD1D1D1),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ImageNetwork(
                      image: widget.image,
                      fitWeb: BoxFitWeb.cover,
                      width: MyUtility(context).width / 5.2,
                      height: MyUtility(context).height * 0.25,
                    )

                  
                    ),
              ),
              SizedBox(
                height: MyUtility(context).height * 0.035,
              ),
              SizedBox(
                width: MyUtility(context).width / 4.7,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: _formatDateTime(widget.date),
                        style: TextStyle(
                          color: Color(0xFF3D3D3D),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MyUtility(context).height * 0.035,
              ),
              SizedBox(
                width: MyUtility(context).width / 4.7,
                height: 60,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 22,
                      color: Color(0xFF3D3D3D),
                    ),
                    children: [
                      TextSpan(
                        text: widget.header,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: SizedBox(
                  width: MyUtility(context).width / 4.7,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: MyUtility(context).width / 4.7,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFF174486),
                      ),
                      child: TextButton(
                        onPressed: widget.onPressed,
                        child: Text(
                          'View',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: widget.userType == "Admin" ? true : false,
                child: GestureDetector(
                  onTap: () {
                    widget.openArticleDialog(widget.articleId);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: SizedBox(
                      width: MyUtility(context).width / 4.7,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: MyUtility(context).width / 4.7,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFF174486),
                          ),
                          child: TextButton(
                            onPressed: widget.onArticleEdit,
                            child: Text(
                              'Edit',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
