import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';

class PageUnderConstruction extends StatefulWidget {
  const PageUnderConstruction({super.key});

  @override
  State<PageUnderConstruction> createState() => _PageUnderConstructionState();
}

class _PageUnderConstructionState extends State<PageUnderConstruction> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          color: const Color.fromARGB(255, 255, 255, 255),
          width: MyUtility(context).width,
          height: MyUtility(context).height,
          child: Center(
              child: Container(
                  width: MyUtility(context).width - 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Column(children: [
                    Row(
                      children: [
                        Image(
                            width: MyUtility(context).width / 4,
                            image: AssetImage('images/sama_logo.png')),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "SAMA Member Portal",
                          style: TextStyle(
                              fontSize: 22,
                              color: const Color.fromARGB(255, 0, 27, 102)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        color: const Color.fromARGB(255, 216, 216, 216),
                      ),
                      width: MyUtility(context).width - 65,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Exiting News!",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: const Color.fromARGB(
                                          255, 82, 82, 82)),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "You've reached us on mobile, and while our mobile views are coming soon, you can still explore the full desktop version of our site.",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: const Color.fromARGB(
                                          255, 82, 82, 82)),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "We're thrilled to bring you a fantastic mobile experience in the near future. In the meantime, enjoy the desktop version and stay tuned for updates.",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: const Color.fromARGB(
                                          255, 82, 82, 82)),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Thanks for your patience and excitement!",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: const Color.fromARGB(
                                          255, 82, 82, 82)),
                                ),
                              ],
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5),
                            ),
                            child: Image.asset(
                              'images/bannerBackground.jpg',
                              width: MyUtility(context).width,
                              height: MyUtility(context).height * 0.04,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    )
                  ])))),
    );
  }
}
