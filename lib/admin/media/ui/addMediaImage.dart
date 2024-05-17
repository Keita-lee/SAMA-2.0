import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_network/image_network.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/styleButtonYellow.dart';
import 'package:uuid/uuid.dart';

class AddMediaImage extends StatefulWidget {
  String? networkImageUrl;
  Function(String) updateUrl;
  AddMediaImage(
      {super.key, required this.networkImageUrl, required this.updateUrl});

  @override
  State<AddMediaImage> createState() => _AddMediaImageState();
}

class _AddMediaImageState extends State<AddMediaImage> {
  Uint8List webImage = Uint8List(8);
  String imageUrl = '';

  Future<void> _pickImageGallery() async {
    setState(() {
      widget.networkImageUrl = "";
    });
    if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        setState(() {
          webImage = f;
          UploadFile();
          print('web Img success');
        });
      } else {
        print('no Image has been picked');
      }
    } else {
      print('Something went wrong');
    }
    //Navigator.pop(context);
  }

  UploadFile() async {
    var uuid = Uuid();
    final ref = FirebaseStorage.instance
        .ref()
        .child('images')
        .child("${uuid.v1()}.png");
    await ref.putData(webImage);
    imageUrl = await ref.getDownloadURL();
    final String newImage = imageUrl.toString();
    widget.updateUrl(newImage);
    setState(() {
      imageUrl = newImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: widget.networkImageUrl == "" ? true : false,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/imageIcon.png"),
                fit: BoxFit.cover,
              ),
            ),
            width: MyUtility(context).width / 7,
            height: 200,
          ),
        ),
        Visibility(
          visible: widget.networkImageUrl != "" ? true : false,
          child: ImageNetwork(
            fitWeb: BoxFitWeb.cover,
            image: widget.networkImageUrl!,
            width: MyUtility(context).width / 7,
            height: 200,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        StylrButtonYellow(
          description: "Add Image",
          height: 55,
          width: 95,
          onTap: () {
            _pickImageGallery();
          },
        ),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
