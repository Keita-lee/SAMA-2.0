import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:sama/components/CommentContainer.dart';
import 'package:sama/components/NewsContainer.dart';
import 'package:sama/components/myutility.dart';
import 'package:intl/intl.dart';

class CenterOfExcellenceArticle extends StatefulWidget {
  Function(int?)? changePage;
  String? articleId;
  CenterOfExcellenceArticle({
    super.key,
    required this.articleId,
    required this.changePage,
  });

  @override
  State<CenterOfExcellenceArticle> createState() =>
      _CenterOfExcellenceArticleState();
}

class _CenterOfExcellenceArticleState extends State<CenterOfExcellenceArticle> {
  String title = "";
  String imageUrl = "";
  String date = "";
  String description = "";
  String category = "";
  List comments = [];
  final comment = TextEditingController();
  String profilePicUrl = "";
  String userName = "";

  String _formatDateTime(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    String dayNumber = DateFormat('dd').format(dateTime);

    String month = DateFormat('MMMM').format(dateTime);
    String year = DateFormat('yyyy').format(dateTime);

    return '$dayNumber $month $year ';
  }

  String _formatTime(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    String time = DateFormat('HH:mm').format(dateTime);

    return '$time ';
  }

  getData() async {
    final data = await FirebaseFirestore.instance
        .collection('articles')
        .doc(widget.articleId)
        .get();

    if (data.exists) {
      setState(() {
        title = data.get('title');
        description = data.get('description');
        imageUrl = data.get('image');
        date = _formatDateTime(data.get('date'));
        category = data.get('category');
        comments.addAll(data.get('comments'));
        print(data.get('comments'));
      });
    }
  }

  getUserProfilePic() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    String currentUserID = auth.currentUser!.uid;
    print(currentUserID);

    final data = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUserID)
        .get();
    if (data.exists) {
      userName = data.get('firstName');
      profilePicUrl = data.get('profilePic');
    }
    //  return data.get('profilePic');
  }

  addComment(value) {
    comment.text = "";
    DateTime now = DateTime.now();

    setState(() {
      comments.add({
        "username": userName,
        "image": profilePicUrl,
        "date": now,
        "comment": value
      });
    });

    FirebaseFirestore.instance
        .collection('articles')
        .doc(widget.articleId)
        .update({"comments": comments});
  }

  @override
  void initState() {
    getData();
    getUserProfilePic();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Center of Excellence',
            style: TextStyle(
                fontSize: 32,
                color: Color(0xFF3D3D3D),
                fontWeight: FontWeight.normal),
          ),
          SizedBox(
            height: MyUtility(context).height * 0.05,
          ),
          Row(
            children: [
              Container(
                width: MyUtility(context).width / 4,
                height: MyUtility(context).height * 0.25,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFD1D1D1),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: ImageNetwork(
                      image: imageUrl,
                      fitWeb: BoxFitWeb.cover,
                      width: MyUtility(context).width * 0.215,
                      height: MyUtility(context).height * 0.25,
                    )

                    /* Image.asset(
                widget.image,
                fit: BoxFit.cover,
              ),*/
                    ),
              ),
              SizedBox(
                width: MyUtility(context).width * 0.025,
              ),
              SizedBox(
                height: MyUtility(context).height * 0.22,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        title,
                        style: TextStyle(
                            fontSize: 24,
                            color: Color(0xFF174486),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        category,
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF174486),
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Text(
                      date,
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF3D3D3D),
                          fontWeight: FontWeight.normal),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: MyUtility(context).height * 0.07,
          ),
          SizedBox(
            width: MyUtility(context).width - MyUtility(context).width * 0.25,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    description,
                    style: TextStyle(color: Color(0xFF3D3D3D), fontSize: 16),
                  ),
                  SizedBox(
                    height: MyUtility(context).height * 0.025,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Go back, view all articles',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF174486),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MyUtility(context).height * 0.05,
                  ),
                  Text(
                    'Comments',
                    style: TextStyle(
                        fontSize: 30,
                        color: Color(0xFF174486),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: MyUtility(context).height * 0.025,
                  ),
                  for (var i = 0; i < comments.length; i++)
                    CommentContainer(
                      image: comments[i]['username'],
                      username: comments[i]['username'],
                      time: _formatTime(comments[i]['date']),
                      date: _formatDateTime(comments[i]['date']),
                      comment: comments[i]['comment'],
                      backgroundColor: i.isEven
                          ? Color(0xFFFFF4D9)
                          : Color.fromARGB(255, 255, 255, 255),
                    ),
                  /* 
                 CommentContainer(
                    image: 'images/pfp.jpg',
                    username: 'Example',
                    time: '15:46',
                    date: ' 10 March 2024',
                    comment:
                        "Lorem ipsum dolor sit amet consectetur adipisicing elit. Qui, deleniti vel quam error voluptatibus accusamus sapiente odit placeat a repellat aliquid aliquam sint reprehenderit laudantium dolores corporis consequatur nulla officia in maxime rem et ducimus odio officiis. Esse unde assumenda, consectetur maiores pariatur nobis cum temporibus facere? Impedit praesentium eligendi incidunt, itaque adipisci voluptas, corrupti ipsum pariatur, ut soluta eveniet?",
                  ),
                  CommentContainer(
                    image: 'images/pfp.jpg',
                    username: 'Example',
                    time: '15:46',
                    date: '9 March 2024',
                    comment:
                        "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quam beatae nisi sed, minima sunt expedita quos aspernatur similique omnis corporis?",
                    backgroundColor: Color(0xFFFFF4D9),
                  ),*/
                  SizedBox(
                    height: MyUtility(context).height * 0.035,
                  ),
                  Text(
                    'Leave a comment',
                    style: TextStyle(
                        fontSize: 30,
                        color: Color(0xFF174486),
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: MyUtility(context).height * 0.035,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      'Your message:',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF3D3D3D),
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  Container(
                    width: MyUtility(context).width / 1.2,
                    height: 65,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.black,
                      ),
                    ),
                    child: TextField(
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFEFEFEF),
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                        controller: comment),
                  ),
                  SizedBox(
                    height: MyUtility(context).height * 0.035,
                  ),
                  SizedBox(
                    width: MyUtility(context).width / 1.62,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: MyUtility(context).width * 0.065,
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFF174486),
                        ),
                        child: TextButton(
                          onPressed: () {
                            addComment(comment.text);
                            widget.changePage!(1);
                          },
                          child: Text(
                            'Submit',
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
                  SizedBox(
                    height: MyUtility(context).height * 0.035,
                  ),
                  TextButton(
                    onPressed: () {
                      widget.changePage!(1);
                    },
                    child: Text(
                      'Go back, view all articles',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF174486),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MyUtility(context).height * 0.1,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
