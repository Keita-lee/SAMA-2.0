import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sama/admin/products/UI/myProductButtons.dart';
import 'package:sama/components/myutility.dart';
import 'package:uuid/uuid.dart';

class ProductImage extends StatefulWidget {
  double customWidth;
  double customHeight;
  String? description;
  String? networkImageUrl;

  Function(String) setUrl;
  ProductImage(
      {super.key,
      required this.customWidth,
      required this.customHeight,
      required this.description,
      required this.networkImageUrl,
      required this.setUrl});

  @override
  State<ProductImage> createState() => _ProductImageState();
}

class _ProductImageState extends State<ProductImage> {
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
    widget.setUrl(newImage);
    setState(() {
      imageUrl = newImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 35,
        ),
        const Text(
          'Product Image',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.black,
            ),
          ),
          width: MyUtility(context).width * 0.22,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: widget.networkImageUrl != ""
                        ? Container(
                            child: ImageNetwork(
                              onTap: () {
                                _pickImageGallery();
                              },
                              fitWeb: BoxFitWeb.cover,
                              image: widget.networkImageUrl!,
                              width: MyUtility(context).width / 6,
                              height: 200,
                            ),
                          )
                        : Image.asset(
                            'images/imageIcon.png',
                            height: 150,
                          ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: 155,
                    child: MyProductButtons(
                      buttonText: 'Change Image',
                      buttonColor: Color.fromARGB(255, 8, 55, 145),
                      borderColor: Color.fromARGB(255, 8, 55, 145),
                      textColor: Colors.white,
                      onTap: () {
                        _pickImageGallery();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
