import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileNavbarOptions extends StatelessWidget {
  const ProfileNavbarOptions({super.key});

  static const List<Map<String, String>> _options = [
    {'icon': 'images/icon_chat.svg', 'name': 'Profile'},
    {'icon': 'images/icon_estore.svg', 'name': 'Settings'},
    {'icon': 'images/icon_bell.svg', 'name': 'Logout'},
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _options
          .map((option) =>
              _buildSvgOption(context, option['icon']!, option['name']!))
          .toList(),
    );
  }

  Widget _buildSvgOption(
      BuildContext context, String assetPath, String optionName) {
    return IconButton(
      onPressed: () => _handleOptionTap(context, optionName),
      icon: SvgPicture.asset(
        assetPath,
        width: 24,
        height: 24,
      ),
      tooltip: optionName,
    );
  }

  void _handleOptionTap(BuildContext context, String optionName) {
    switch (optionName) {
      case 'Chat':
        Navigator.pushNamed(context, '/chat');
        break;
      case 'Estore':
        Navigator.pushNamed(context, '/estore');
        break;
      case 'Notifications':
        // Perform logout action
        // For example:
        // AuthService.logout();
        Navigator.pushReplacementNamed(context, '/notifications');
        break;
    }
  }
}
