import 'package:flutter/material.dart';

class MediaPopup extends StatefulWidget {
  Function closeDialog;
  MediaPopup({super.key, required this.closeDialog});

  @override
  State<MediaPopup> createState() => _MediaPopupState();
}

class _MediaPopupState extends State<MediaPopup> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
