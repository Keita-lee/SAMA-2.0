import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/profileTextField.dart';
import 'package:sama/components/styleButtonYellow.dart';
import 'package:sama/components/yesNoDialog.dart';

class CategoryForm extends StatefulWidget {
  Function closeDialog;
  String categoryType;
  String id;
  CategoryForm({
    super.key,
    required this.closeDialog,
    required this.categoryType,
    required this.id,
  });

  @override
  State<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  // Text controllers
  final categoryDescription = TextEditingController();

  //save add data to firebase
  saveData() async {
    var categoryData = {
      "categoryDescription": categoryDescription.text,
      "categoryType": widget.categoryType,
      "id": widget.id,
    };

    if (widget.id == "") {
      var myNewDoc = await FirebaseFirestore.instance
          .collection("categories")
          .add(categoryData);

      FirebaseFirestore.instance
          .collection("categories")
          .doc(myNewDoc.id)
          .update({
        "id": myNewDoc.id,
      }).whenComplete(() => widget.closeDialog());
    } else {
      FirebaseFirestore.instance
          .collection("categories")
          .doc(widget.id)
          .update(categoryData)
          .whenComplete(() => widget.closeDialog());
    }
  }

  getCategoryData() async {
    final data = await FirebaseFirestore.instance
        .collection('categories')
        .doc(widget.id)
        .get();

    if (data.exists) {
      setState(() {
        categoryDescription.text = data.get('categoryDescription');
      });
    }
  }

  //Remove member from db
  removeCategory() {
    FirebaseFirestore.instance
        .collection('categories')
        .doc(widget.id)
        .delete()
        .whenComplete(() => widget.closeDialog!());
  }

  BuildContext? dialogContext;
  //Dialog for password Validate
  Future removeCategoryPopup() => showDialog(
      context: context,
      builder: (context) {
        dialogContext = context;
        return Dialog(
            child: YesNoDialog(
          description: "Are you sure you want to remove this item",
          closeDialog: () => Navigator.pop(dialogContext!),
          callFunction: removeCategory,
        ));
      });

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if (widget.id != "") {
      getCategoryData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MyUtility(context).width / 3,
        height: MyUtility(context).height / 2.5,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color.fromARGB(255, 255, 255, 255)),
        child: SingleChildScrollView(
            child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                Spacer(),
                GestureDetector(
                  onTap: () {
                    widget.closeDialog();
                  },
                  child: Text(
                    "X",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Color.fromARGB(255, 8, 55, 145),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ProfileTextField(
              customSize: MyUtility(context).width / 4,
              description: "Category Description:",
              textfieldController: categoryDescription,
              textFieldType: "stringType"),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StylrButtonYellow(
                  description: "Save",
                  height: 45,
                  width: 110,
                  onTap: () {
                    saveData();
                  }),
              SizedBox(
                width: 15,
              ),
              Visibility(
                visible: widget.id != "" ? true : false,
                child: StylrButtonYellow(
                    description: "Remove",
                    height: 45,
                    width: 110,
                    onTap: () {
                      removeCategoryPopup();
                    }),
              )
            ],
          )
        ])));
  }
}
