import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sama/components/styleButton.dart';
import 'package:sama/components/styleButtonYellow.dart';
import 'package:sama/components/utility.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';
import 'dart:async';

class ImageAdd extends StatefulWidget {
  double customWidth;
  double customHeight;
  String? description;
  String? networkImageUrl;

  Function(String) setUrl;
  ImageAdd(
      {super.key,
      required this.customWidth,
      required this.customHeight,
      required this.description,
      required this.networkImageUrl,
      required this.setUrl});

  @override
  State<ImageAdd> createState() => _ImageAddState();
}

class _ImageAddState extends State<ImageAdd> {
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
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      
        StylrButtonYellow(
          description: "Pick Image",
          height: 55,
          width: 95,
          onTap: () {
            _pickImageGallery();
          },
        ),
        SizedBox(
          height: 8,
        ),
        GestureDetector(
          onTap: () {
            _pickImageGallery();
          },
          child: Container(
            width: widget.customWidth!,
            height: widget.customHeight!,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25), color: Colors.white),
            child: Padding(
                padding: EdgeInsets.all(8.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: Container(
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
                          : Image.memory(
                              webImage,
                              fit: BoxFit.contain,
                            ),
                    ))

                /*(webImage == null)
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.memory(
                            webImage,
                            fit: BoxFit.cover,
                          ),
                        )
                      : ImageNetwork(
                          image: webImage.toString(),
                          height: 150,
                          width: 150,
                          onTap: () {
                            _pickImageGallery();
                          },
                        ),*/
                ),
          ),
        ),
      ],
    );
  }
}
