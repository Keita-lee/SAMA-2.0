import 'package:flutter/material.dart';
import 'package:sama/components/CommentContainer.dart';
import 'package:sama/components/NewsContainer.dart';
import 'package:sama/components/myutility.dart';

class CenterOfExcellenceArticle extends StatefulWidget {
  const CenterOfExcellenceArticle({super.key});

  @override
  State<CenterOfExcellenceArticle> createState() =>
      _CenterOfExcellenceArticleState();
}

class _CenterOfExcellenceArticleState extends State<CenterOfExcellenceArticle> {
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
                width: MyUtility(context).width * 0.17,
                height: MyUtility(context).height * 0.22,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xFFD1D1D1),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    'images/news1.jpg',
                    fit: BoxFit.cover,
                  ),
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
                        'WEBINAR | JUDASA - Reviving a Junior Doctors Movement',
                        style: TextStyle(
                            fontSize: 24,
                            color: Color(0xFF174486),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Med-e-mail',
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF174486),
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Text(
                      '13 March 2024',
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
                    'Lorem ipsum dolor sit amet consectetur adipisicing elit. Reprehenderit consectetur tenetur nihil voluptatum veniam asperiores atque placeat nostrum dicta, nesciunt vitae eligendi fuga odit doloremque quos odio ducimus, voluptate adipisci excepturi quia totam harum et necessitatibus aliquam. Earum rem reprehenderit, in delectus eaque voluptate incidunt quibusdam blanditiis quasi laboriosam amet mollitia impedit quisquam tenetur officia sint sed accusantium. Id repellendus doloribus, cumque laboriosam corporis odit! Sunt, odio harum nesciunt iure atque iusto aut esse, reprehenderit minus deserunt tempore commodi consequuntur quidem et assumenda quis cum quod eveniet suscipit at veniam. Deserunt at architecto maiores soluta nobis, error expedita aliquid ratione.',
                    style: TextStyle(color: Color(0xFF3D3D3D), fontSize: 16),
                  ),
                  SizedBox(
                    height: MyUtility(context).height * 0.025,
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet consectetur adipisicing elit. Reprehenderit consectetur tenetur nihil voluptatum veniam asperiores atque placeat nostrum dicta, nesciunt vitae eligendi fuga odit doloremque quos odio ducimus, voluptate adipisci excepturi quia totam harum et necessitatibus aliquam. Earum rem reprehenderit, impedit quisquam tenetur officia sint sed accusantium. Id repellendus doloribus, cumque laboriosam corporis odit! Sunt, odio harum nesciunt iure atque iusto aut esse, reprehenderit minus deserunt tempore commodi consequuntur quidem et assumenda quis cum quod eveniet suscipit at veniam. Deserunt at architecto maiores soluta nobis, error expedita aliquid ratione.',
                    style: TextStyle(color: Color(0xFF3D3D3D), fontSize: 16),
                  ),
                  SizedBox(
                    height: MyUtility(context).height * 0.025,
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet consectetur adipisicing elit. Reprehenderit consectetur tenetur nihil voluptatum veniam asperiores atque placeat nostrum dicta, nesciunt vitae eligendi fuga odit doloremque quos odio ducimus, voluptate adipisci excepturi quia totam harum et necessitatibus aliquam. Earum rem reprehenderit, in delectus eaque voluptate incidunt quibusdam blanditiis quasi laboriosam amet mollitia impedit quisquam tenetur officia sint sed accusantium. Id repellendus doloribus, cumque laboriosam corporis odit! Sunt, odio harum nesciunt iure atque iusto aut esse, reprehenderit minus deserunt tempore commodi consequuntur quidem et assumenda quis cum quod eveniet suscipit at veniam.',
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
                  CommentContainer(
                    image: 'images/pfp.jpg',
                    username: 'Example',
                    time: '15:46',
                    date: '13 September 2024',
                    comment:
                        "Lorem ipsum dolor sit amet consectetur adipisicing elit. Quam beatae nisi sed, minima sunt expedita quos aspernatur similique omnis corporis?",
                    backgroundColor: Color(0xFFFFF4D9),
                  ),
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
                  ),
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
                      controller:
                          TextEditingController(text: 'Enter you comment here'),
                    ),
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
                          onPressed: () {},
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
