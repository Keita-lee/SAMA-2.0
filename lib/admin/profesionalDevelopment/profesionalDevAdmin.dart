import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sama/admin/profesionalDevelopment/sections/cpdList/cpdList.dart';
import 'package:sama/components/myutility.dart';
import 'package:sama/components/styleButton.dart';

import '../../components/banner/samaBlueBanner.dart';
import 'sections/cpdEditForm/cpdEditForm.dart';

class ProfessionalDevAdmin extends StatefulWidget {
  const ProfessionalDevAdmin({super.key});

  @override
  State<ProfessionalDevAdmin> createState() => _ProfessionalDevAdminState();
}

class _ProfessionalDevAdminState extends State<ProfessionalDevAdmin> {
  var pageIndex = 0;
  var cpdItemId = "";
  final search = TextEditingController();
  var searchText = "";
  //change page index state
  changePageIndex(value, id) {
    print(id);
    setState(() {
      pageIndex = value;
      cpdItemId = id;
    });
  }

  void onSearchChanged() {
    setState(() {
      searchText = search.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SamaBlueBanner(pageName: 'CPD'),
      SizedBox(
        height: 30,
      ),
      Visibility(
        visible: pageIndex == 0,
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: SizedBox(
                  width: MyUtility(context).width / 1.4,
                  child: Container(
                      child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          StyleButton(
                              description: "Add New",
                              height: 55,
                              width: 125,
                              onTap: () {
                                setState(() {
                                  cpdItemId = "";
                                });
                                changePageIndex(1, "");
                              }),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 200,
                            height: 45,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 255, 255, 255),
                                border: Border.all(
                                  color: const Color.fromARGB(255, 51, 51, 51),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Center(
                              child: TextFormField(
                                controller: search,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 10),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          StyleButton(
                              description: "Search",
                              height: 55,
                              width: 125,
                              onTap: () {
                                onSearchChanged();
                              }),
                        ],
                      ),
                      CpdList(
                        changePageIndex: changePageIndex,
                        searchText: searchText,
                      ),
                    ],
                  )),
                )),
          ],
        ),
      ),
      Visibility(
          visible: pageIndex == 1,
          child: SizedBox(
              width: MyUtility(context).width / 1.4,
              child: CpdEditForm(
                changePageIndex: changePageIndex,
                cpdId: cpdItemId,
              )))
    ]);
  }
}
