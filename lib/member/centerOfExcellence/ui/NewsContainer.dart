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
      
      width: 250,
      height: widget.userType == "Admin" ? 365 : 335,
      
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            
            width: 250,
           // width: MyUtility(context).width / 5.6,
            height: 200,
            decoration: BoxDecoration(
              
              color: Color(0xFFD1D1D1),
            ),
            child: ClipRRect(
                
                child: ImageNetwork(
                  image: widget.image,
                  fitWeb: BoxFitWeb.cover,
                  width: 250,
                  //width: MyUtility(context).width / 5.6,
                  height: 200,
                )
            
              
                ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MyUtility(context).width / 5.6,
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
                      fontSize: 12,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(148, 158, 158, 158),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MyUtility(context).width /5.2,
            //height: 60,
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
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
         Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: SizedBox(
              width: MyUtility(context).width / 4.7,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromRGBO(0, 159, 158, 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric( horizontal: 20),
                    child: TextButton(
                      onPressed: widget.onPressed,
                      child: Text(
                        'Read',
                        style: TextStyle(
                          color: Colors.white,
                          
                          fontSize: 13,
                        ),
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
              child: SizedBox(
                width: MyUtility(context).width / 5.2,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    //width: MyUtility(context).width / 5.2,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xFF174486),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextButton(
                        onPressed: widget.onArticleEdit,
                        child: Text(
                          'Edit',
                          style: TextStyle(
                            color: Colors.white,
                            
                            fontSize: 13,
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
    );
  }
}
