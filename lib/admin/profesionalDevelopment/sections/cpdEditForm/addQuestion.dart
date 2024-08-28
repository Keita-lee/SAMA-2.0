import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/admin/profesionalDevelopment/sections/cpdEditForm/ui/answerStyle.dart';
import 'package:sama/components/styleButton.dart';

import '../../../../components/utility.dart';
import '../../../products/UI/myProductTextField.dart';

class AddQuestion extends StatefulWidget {
  Function(Map, int) updateQuestionsList;
  String questionToBeAsked;
  List answerOptions;
  int index;
  AddQuestion(
      {super.key,
      required this.updateQuestionsList,
      required this.questionToBeAsked,
      required this.answerOptions,
      required this.index});

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final questionToBeAsked = TextEditingController();
  final answer = TextEditingController();
  var editAnswer = false;
  var answerIndex = -1;
  List answerOptions = [];

  updateAnswerStatus(index) {
    setState(() {
      answerOptions[index]["answerTrueFalse"] =
          !answerOptions[index]["answerTrueFalse"];
    });
  }

//Add or edit answer in array
  addToAnswerList(value) {
    setState(() {
      answerOptions.add({"answerValue": answer.text, "answerTrueFalse": false});
      answer.text = "";
    });
  }

  editAnswerDetails() {
    setState(() {
      editAnswer = true;
    });
  }

  saveEditAnswerSelected() {
    setState(() {
      editAnswer = false;
      answerOptions[answerIndex]["answerValue"] = answer.text;
      answer.text = "";
    });
  }

  removeAnswer() {
    setState(() {
      editAnswer = false;
      answerOptions.removeAt(answerIndex);
      answer.text = "";
    });
  }

  @override
  void initState() {
    questionToBeAsked.text = widget.questionToBeAsked;
    answerOptions = widget.answerOptions;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Color(0xFFD1D1D1),
          )),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add Question",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            MyProductTextField(
              hintText: 'Question to be asked',
              textfieldController: questionToBeAsked,
              textFieldWidth: MyUtility(context).width * 0.75,
              topPadding: 0,
              header: 'Question',
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Answers",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MyProductTextField(
                  lines: editAnswer ? 5 : 1,
                  hintText: 'Write a answer to add',
                  textfieldController: answer,
                  textFieldWidth: MyUtility(context).width * 0.50,
                  topPadding: 0,
                  header: 'Add answer',
                ),
                Spacer(),
                Visibility(
                  visible: !editAnswer,
                  child: StyleButton(
                      description: "Add +",
                      height: 55,
                      width: 120,
                      onTap: () {
                        addToAnswerList("");
                      }),
                ),
                Visibility(
                  visible: editAnswer,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: StyleButton(
                        description: " + ",
                        height: 55,
                        width: 45,
                        onTap: () {
                          saveEditAnswerSelected();
                        }),
                  ),
                ),
                Visibility(
                  visible: editAnswer,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: StyleButton(
                        description: " - ",
                        height: 55,
                        width: 45,
                        onTap: () {
                          removeAnswer();
                        }),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
            for (var i = 0; i < answerOptions.length; i++)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      editAnswer = true;
                      answerIndex = i;
                      answer.text = answerOptions[i]['answerValue'];
                    });
                  },
                  child: AnswerStyle(
                      answerValue: answerOptions[i]['answerValue'],
                      answerTrueFalse: answerOptions[i]['answerTrueFalse'],
                      index: i,
                      updateAnswerStatus: updateAnswerStatus),
                ),
              ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                StyleButton(
                    description: "Save",
                    height: 55,
                    width: 120,
                    onTap: () {
                      widget.updateQuestionsList({
                        "questionToBeAsked": questionToBeAsked.text,
                        "answerOptions": answerOptions,
                      }, widget.index);
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
