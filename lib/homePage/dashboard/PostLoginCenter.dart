import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sama/homePage/dashboard/ui/EventDate.dart';
import 'package:sama/homePage/dashboard/ui/GeneralInfoContainer.dart';
import 'package:sama/components/Morecontainers.dart';
import 'package:sama/components/ReuseableButton.dart';
import 'package:sama/components/myutility.dart';

class PostLoginCenter extends StatefulWidget {
  const PostLoginCenter({super.key});

  @override
  State<PostLoginCenter> createState() => _PostLoginCenterState();
}

class _PostLoginCenterState extends State<PostLoginCenter> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MyUtility(context).width / 1.3,
          height: MyUtility(context).height / 3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(
              color: Color(0xFFD1D1D1),
            ),
          ),
          child: Text(
            'Dashboard: Under Construction',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(106, 106, 106, 1.0),
            ),
            textAlign: TextAlign.center,
          ),
        ),

        /*  Row(
          children: [
            Container(
              width: 25,
              height: 25,
              child: SvgPicture.asset(
                'images/Blocks.svg',
                color: Color(0xFFFBC82D),
                width: 25,
                height: 25,
              ),
            ),
            SizedBox(width: 5),
            Text(
              'My Dashboard',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(106, 106, 106, 1.0),
              ),
            ),
            SizedBox(
              width: MyUtility(context).width * 0.025,
            ),
            IconButton(
              onPressed: () {},
              icon: Image.asset(
                'images/squareicon.png',
                width: 24,
                height: 24,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Image.asset(
                'images/speech.png',
                width: 24,
                height: 24,
              ),
            ),
            SizedBox(
              width: MyUtility(context).width * 0.15,
            ),
            /*Text(
              'Welcome, Dr. Robbert',
              style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF174486),
                  fontWeight: FontWeight.bold),
            ),*/
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 32),
              child: Container(
                width: MyUtility(context).width / 6.5,
                height: MyUtility(context).height * 0.225,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Color(0xFFD1D1D1),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFFBC82D),
                            ),
                            child: ClipOval(
                              child: Transform.scale(
                                scale: 0.6, // Adjust the scale factor as needed
                                child: SvgPicture.asset(
                                  'images/Ribbon.svg',
                                  color: Color(0xFF174486),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MyUtility(context).width * 0.005,
                          ),
                          Text(
                            'CDP Points',
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF174486),
                                fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: Image.asset(
                              'images/menuedots.png',
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '15',
                          style: TextStyle(
                              color: Color(0xFF6A6A6A),
                              letterSpacing: -0.05,
                              fontWeight: FontWeight.bold,
                              fontSize: 54),
                        ),
                        Text(
                          '/25',
                          style: TextStyle(
                              color: Color(0xFF6A6A6A),
                              letterSpacing: -0.05,
                              fontWeight: FontWeight.bold,
                              fontSize: 24),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: MyUtility(context).width * 0.11,
                      child: Text(
                        '60%',
                        style: TextStyle(
                            color: Color(0xFF174486),
                            letterSpacing: -0.05,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    ),
                    Container(
                      width: MyUtility(context).width * 0.11,
                      height: 7,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xFFD1D1D1)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: LinearProgressIndicator(
                          backgroundColor: Colors.transparent,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xFF174486)),
                          value: 0.6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 32),
              child: Container(
                width: MyUtility(context).width / 6.5,
                height: MyUtility(context).height * 0.225,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Color(0xFFD1D1D1),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFFBC82D),
                            ),
                            child: ClipOval(
                              child: Transform.scale(
                                scale: 0.6, // Adjust the scale factor as needed
                                child: SvgPicture.asset(
                                  'images/Hat.svg',
                                  color: Color(0xFF174486),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MyUtility(context).width * 0.005,
                          ),
                          Text(
                            'My Courses',
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF174486),
                                fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: Image.asset(
                              'images/menuedots.png',
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MyUtility(context).height * 0.02,
                    ),
                    SizedBox(
                      width: MyUtility(context).width * 0.14,
                      child: Text(
                        'Current: Sample course title',
                        style: TextStyle(
                            color: Color(0xFF6A6A6A),
                            letterSpacing: -0.05,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.5),
                      ),
                    ),
                    SizedBox(
                      height: MyUtility(context).height * 0.01,
                    ),
                    Container(
                      width: MyUtility(context).width * 0.125,
                      height: 7,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xFFD1D1D1)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: LinearProgressIndicator(
                          backgroundColor: Colors.transparent,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xFF174486)),
                          value: 0.4,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MyUtility(context).height * 0.04,
                    ),
                    SizedBox(
                      width: MyUtility(context).width * 0.14,
                      child: Row(
                        children: [
                          Text(
                            'Completed: ',
                            style: TextStyle(
                                color: Color(0xFF6A6A6A),
                                letterSpacing: -0.05,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.5),
                          ),
                          Text(
                            '12',
                            style: TextStyle(
                                color: Color(0xFF174486),
                                letterSpacing: -0.05,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          Spacer(),
                          ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xFF174486)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                            ),
                            child: Text(
                              'Continue',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 32),
              child: Container(
                width: MyUtility(context).width / 6.5,
                height: MyUtility(context).height * 0.225,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Color(0xFFD1D1D1),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFFBC82D),
                            ),
                            child: ClipOval(
                              child: Transform.scale(
                                scale: 0.6, // Adjust the scale factor as needed
                                child: SvgPicture.asset(
                                  'images/Person.svg',
                                  color: Color(0xFF174486),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MyUtility(context).width * 0.005,
                          ),
                          Text(
                            'Mentor/Mentee',
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF174486),
                                fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: Image.asset(
                              'images/menuedots.png',
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MyUtility(context).height * 0.01,
                    ),
                    SizedBox(
                      width: MyUtility(context).width * 0.13,
                      child: Text(
                        'Jenny James',
                        style: TextStyle(
                            color: Color(0xFF6A6A6A),
                            letterSpacing: -0.05,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      width: MyUtility(context).width * 0.13,
                      child: Text(
                        'Andrew Spencer',
                        style: TextStyle(
                            color: Color(0xFF6A6A6A),
                            letterSpacing: -0.05,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: MyUtility(context).height * 0.022,
                    ),
                    SizedBox(
                      width: MyUtility(context).width * 0.14,
                      child: Row(
                        children: [
                          Spacer(),
                          ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Color(0xFF174486)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                            ),
                            child: Text(
                              'CONNECT',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 32),
              child: Container(
                width: MyUtility(context).width / 6.5,
                height: MyUtility(context).height * 0.225,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Color(0xFFD1D1D1),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFFBC82D),
                            ),
                            child: ClipOval(
                              child: Transform.scale(
                                scale: 0.6, // Adjust the scale factor as needed
                                child: SvgPicture.asset(
                                  'images/Bag.svg',
                                  color: Color(0xFF174486),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MyUtility(context).width * 0.005,
                          ),
                          Text(
                            'Mentor/Mentee',
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF174486),
                                fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: Image.asset(
                              'images/menuedots.png',
                              width: 24,
                              height: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MyUtility(context).height * 0.01,
                    ),
                    SizedBox(
                      width: MyUtility(context).width * 0.08,
                      child: Text(
                        '22 in Cape Town',
                        style: TextStyle(
                            color: Color(0xFF6A6A6A),
                            letterSpacing: -0.05,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ),
                    SizedBox(
                      width: MyUtility(context).width * 0.08,
                      child: Text(
                        '15 in Johannesburg',
                        style: TextStyle(
                            color: Color(0xFF6A6A6A),
                            letterSpacing: -0.05,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ),
                    SizedBox(
                      width: MyUtility(context).width * 0.08,
                      child: GestureDetector(
                        onTap: () {},
                        behavior: HitTestBehavior.translucent,
                        child: Text(
                          "View more areas",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            letterSpacing: -0.05,
                            fontWeight: FontWeight.bold,
                            fontSize: 12.5,
                            decoration:
                                TextDecoration.underline, // Underline text
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MyUtility(context).height * 0.022,
                    ),
                    SizedBox(
                      width: MyUtility(context).width * 0.14,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: ReuseableButton(
                            buttontext: "VIEW Listing", onPressed: () {}),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: MyUtility(context).height * 0.045,
        ),
        Row(
          children: [
            Container(
              width: MyUtility(context).width / 5.5,
              height: MyUtility(context).height * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Color(0xFFD1D1D1),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 10, bottom: 15, top: 10),
                      child: Text(
                        'Events',
                        style: TextStyle(
                            fontSize: 18,
                            color: Color(0xFF174486),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 10),
                    EventDate(
                        date: '02',
                        month: 'Nov',
                        discription:
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit."),
                    EventDate(
                        date: '11',
                        month: 'Nov',
                        discription:
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit."),
                    EventDate(
                        date: '12',
                        month: 'Nov',
                        discription:
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit."),
                    EventDate(
                        date: '24',
                        month: 'Nov',
                        discription:
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit."),
                    EventDate(
                        date: '03',
                        month: 'Dec',
                        discription:
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit."),
                    SizedBox(
                      height: MyUtility(context).height * 0.01,
                    ),
                    Row(
                      children: [
                        Spacer(),
                        ReuseableButton(
                            buttontext: "VIEW CALENDAR", onPressed: () {})
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MyUtility(context).width * 0.01,
            ),
            Column(
              children: [
                SizedBox(
                  height: MyUtility(context).height * 0.01,
                ),
                Row(
                  children: [
                    MoreContainer(
                        catagoryname: "Podcast",
                        image: 'images/coffee.jpg',
                        catagorytitle: "Title goes here",
                        textbutton: "More",
                        onpress: () {}),
                    SizedBox(
                      width: MyUtility(context).width * 0.01,
                    ),
                    MoreContainer(
                        catagoryname: "Publications",
                        image: 'images/coffee.jpg',
                        catagorytitle: "Title goes here",
                        textbutton: "More",
                        onpress: () {}),
                    SizedBox(
                      width: MyUtility(context).width * 0.01,
                    ),
                    Container(
                      width: MyUtility(context).width / 5.5,
                      height: MyUtility(context).height * 0.28,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: Color(0xFFD1D1D1),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            SizedBox(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Who's Online",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color(0xFF174486),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MyUtility(context).height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image:
                                          AssetImage('images/onlineimage.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image:
                                          AssetImage('images/onlineimage.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image:
                                          AssetImage('images/onlineimage.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image:
                                          AssetImage('images/onlineimage.jpg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: MyUtility(context).height * 0.025,
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: GestureDetector(
                                onTap: () {},
                                behavior: HitTestBehavior.translucent,
                                child: Text(
                                  'more',
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    letterSpacing: -0.05,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.5,
                                    decoration: TextDecoration
                                        .underline, // Underline text
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MyUtility(context).height * 0.035,
                ),
                Row(
                  children: [
                    GeneralInfoContainer(
                        headline: "Announcements",
                        text:
                            "Phasellus cursus felis nisi. Phasellus ac mauris risus. Pellentesque at velit sit.",
                        buttonText: "READ MORE",
                        onPressed: () {}),
                    SizedBox(
                      width: MyUtility(context).width * 0.01,
                    ),
                    GeneralInfoContainer(
                        headline: "Industry Developments",
                        text:
                            "Phasellus cursus felis nisi. Phasellus ac mauris risus. Pellentesque at velit sit.",
                        buttonText: "READ MORE",
                        onPressed: () {}),
                    SizedBox(
                      width: MyUtility(context).width * 0.01,
                    ),
                    Container(
                      width: MyUtility(context).width / 5.5,
                      height: MyUtility(context).height * 0.28,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: Color(0xFFD1D1D1),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Latest Article",
                              style: TextStyle(
                                fontSize: 20,
                                color: Color(0xFF174486),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: MyUtility(context).height * 0.02),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                  child: Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5.0),
                                      image: DecorationImage(
                                        image: AssetImage('images/coffee.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "Lorem Ipsum Dolor, Sit Amet Consectetur adfispiscing elit. Deleniti ut temporibud as accusamus sequi, obcaecati dolorernque earum omnis que dignissimos",
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      letterSpacing: -0.05,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 5,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: MyUtility(context).height * 0.01),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: GestureDetector(
                                onTap: () {},
                                behavior: HitTestBehavior.translucent,
                                child: Text(
                                  'Read More',
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    letterSpacing: -0.05,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.5,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: MyUtility(context).height * 0.05,
        ),
        Row(
          children: [
            GeneralInfoContainer(
                headline: "Community Highlights",
                text:
                    "Phasellus cursus felis nisi. Phasellus ac mauris risus. Pellentesque at velit sit.",
                buttonText: "READ MORE",
                onPressed: () {}),
            SizedBox(
              width: MyUtility(context).width * 0.01,
            ),
            Container(
              width: MyUtility(context).width / 2.7,
              height: MyUtility(context).height * 0.28,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Color(0xFFD1D1D1),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Coding Academy',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color(0xFF174486),
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MyUtility(context).height * 0.03,
                    ),
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            child: SizedBox(
                              width: MyUtility(context).width * 0.17,
                              child: Text(
                                "Praesent eu ante id nunc egestas interdum vitae in ante.",
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    letterSpacing: -0.05,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0),
                              ),
                            ),
                          ),
                          Flexible(
                            child: SizedBox(
                              width: MyUtility(context).width * 0.17,
                              child: Text(
                                "Praesent eu ante id nunc egestas interdum vitae in ante.",
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    letterSpacing: -0.05,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8), // Add spacing between the rows
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            child: SizedBox(
                              width: MyUtility(context).width * 0.17,
                              child: Text(
                                "Praesent eu ante id nunc egestas interdum vitae in ante.",
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    letterSpacing: -0.05,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0),
                              ),
                            ),
                          ),
                          Flexible(
                            child: SizedBox(
                              width: MyUtility(context).width * 0.17,
                              child: Text(
                                "Praesent eu ante id nunc egestas interdum vitae in ante.",
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    letterSpacing: -0.05,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8), // Add spacing between the rows
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            child: SizedBox(
                              width: MyUtility(context).width * 0.17,
                              child: Text(
                                "Praesent eu ante id nunc egestas interdum vitae in ante.",
                                style: TextStyle(
                                    color: Colors.grey.shade600,
                                    letterSpacing: -0.05,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0),
                              ),
                            ),
                          ),
                          Flexible(
                            child: SizedBox(
                              width: MyUtility(context).width * 0.167,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: MyUtility(context).height * 0.05,
        ),
      */
      ],
    );
  }
}
