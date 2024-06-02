import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sama/admin/Events/NewEvent/NewEventComp/EventDescriptionTextField.dart';
import 'package:sama/admin/Events/NewEvent/NewEventComp/EventTextField.dart';
import 'package:sama/components/utility.dart';
import 'dart:io';

class NewEvent extends StatefulWidget {
  const NewEvent({Key? key}) : super(key: key);

  @override
  State<NewEvent> createState() => _NewEventState();
}

class _NewEventState extends State<NewEvent> {
  TextEditingController _title = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController _times = TextEditingController();
  TextEditingController _event = TextEditingController();
  TextEditingController _controller = TextEditingController();

  List<XFile?> _images = [null, null, null];

  Future<void> _pickImage(int index) async {
    final ImagePicker _picker = ImagePicker();
    XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _images[index] = pickedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.transparent, // Set Scaffold background to transparent
      body: Center(
        child: Container(
          width: MyUtility(context).width * 0.55,
          height: MyUtility(context).height * 0.7,
          decoration: ShapeDecoration(
            color: Color(0xFFFFF5F5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            shadows: [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 4,
                offset: Offset(0, 4),
                spreadRadius: 0,
              )
            ],
          ),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(3, (index) {
                      return GestureDetector(
                        onTap: () => _pickImage(index),
                        child: Container(
                          width: MyUtility(context).width * 0.16,
                          height: MyUtility(context).height * 0.3,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey[300]!,
                              width: 1,
                            ),
                            image: _images[index] != null
                                ? DecorationImage(
                                    image: FileImage(
                                      File(_images[index]!.path),
                                    ),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: _images[index] == null
                              ? Icon(Icons.add_a_photo)
                              : null,
                        ),
                      );
                    }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      EventTxtField(
                        controller: _title,
                        textSection: 'Title',
                      ),
                      EventTxtField(
                        controller: _date,
                        textSection: 'Date',
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      EventTxtField(
                        controller: _times,
                        textSection: 'Start-EndTime',
                      ),
                      EventTxtField(
                        controller: _event,
                        textSection: 'Type of Event',
                      ),
                    ],
                  ),
                  EventDescriptionTextField(
                    controller: _controller,
                    textSection: 'Description',
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      'Load',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF3D3D3D),
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
