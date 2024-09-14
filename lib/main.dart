import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/Myhome.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/pageUnderContruction.dart';
import 'package:sama/homePage/PostLoginLandingPage.dart';
import 'package:sama/login/loginPages.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  usePathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyCVtEWeZAl8jvB2Xj_A1_48cuSankMxUAQ",
      authDomain: "https://members.samedical.org",
      projectId: "sama-959a2",
      storageBucket: "sama-959a2.appspot.com",
      messagingSenderId: "393242211465",
      appId: "1:393242211465:web:b6c2d02f372dc9ec138258",
    ));
  } else {
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1,
      child: MaterialApp(
        home: MyHome(),
        routes: {
          '/login': (context) => MyUtility(context).width < 600
              ? Material(child: PageUnderConstruction())
              : Material(
                  child: LoginPages(
                  pageIndex: 0,
                )),
          '/register': (context) => MyUtility(context).width < 600
              ? Material(child: PageUnderConstruction())
              : Material(
                  child: LoginPages(
                  pageIndex: 9,
                )),
          '/cpd': (context) => MyUtility(context).width < 600
              ? Material(child: PageUnderConstruction())
              : Material(
                  child: PostLoginLandingPage(
                      pageIndex: 19, userId: "", activeIndex: 19),
                ),
          '/media': (context) => MyUtility(context).width < 600
              ? Material(child: PageUnderConstruction())
              : Material(
                  child: PostLoginLandingPage(
                      pageIndex: 9, userId: "", activeIndex: 2),
                ),
          '/events': (context) => MyUtility(context).width < 600
              ? Material(child: PageUnderConstruction())
              : Material(
                  child: PostLoginLandingPage(
                      pageIndex: 10, userId: "", activeIndex: 7),
                ),
          '/products': (context) => MyUtility(context).width < 600
              ? Material(child: PageUnderConstruction())
              : Material(
                  child: PostLoginLandingPage(
                      pageIndex: 14, userId: "", activeIndex: 6),
                ),
        },
      ),
    );
  }
}
