import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SamaTopTabBar extends StatefulWidget {
  const SamaTopTabBar({super.key});

  @override
  State<SamaTopTabBar> createState() => _SamaTopTabBarState();
}

class _SamaTopTabBarState extends State<SamaTopTabBar>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController!.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Container(
        width: 200,
        height: 65,
        child: TabBar(
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: Color.fromRGBO(55, 94, 144, 1),
          indicatorWeight: 2,
          tabs: [
            Tab(
              child: Tooltip(
                verticalOffset: 38,
                textStyle: TextStyle(
                    color: Color.fromRGBO(55, 94, 144, 1), fontSize: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    width: 1.5,
                    color: Color.fromRGBO(55, 94, 144, 1),
                  ),
                ),
                message: 'News Feed',
                child: SvgPicture.asset(
                  _tabController!.index == 0
                      ? 'images/icon_feed_active.svg'
                      : 'images/icon_feed.svg',
                  height: 24,
                  width: 24,
                  color: Color.fromRGBO(55, 94, 144, 1),
                ),
              ),
            ),
            Tab(
              child: Tooltip(
                verticalOffset: 38,
                textStyle: TextStyle(
                    color: Color.fromRGBO(55, 94, 144, 1), fontSize: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    width: 1.5,
                    color: Color.fromRGBO(55, 94, 144, 1),
                  ),
                ),
                message: 'Chat',
                child: SvgPicture.asset(
                  _tabController!.index == 1
                      ? 'images/icon_chat_active.svg'
                      : 'images/icon_chat.svg',
                  width: 24,
                  height: 24,
                  color: Color.fromRGBO(55, 94, 144, 1),
                ),
              ),
            ),
            /*   Tooltip(
              verticalOffset: 38,
              textStyle: TextStyle(
                  color: Color.fromRGBO(55, 94, 144, 1), fontSize: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  width: 1.5,
                  color: Color.fromRGBO(55, 94, 144, 1),
                ),
              ),
              message: 'Messages',
              child: Tab(
                child: SvgPicture.asset(
                  _tabController!.index == 2
                      ? 'images/icon_messages_active.svg'
                      : 'images/icon_messages.svg',
                  width: 20,
                  height: 20,
                  color: Color.fromRGBO(55, 94, 144, 1),
                ),
              ),
            ),
         */
          ],
        ),
      ),
    );
  }
}
