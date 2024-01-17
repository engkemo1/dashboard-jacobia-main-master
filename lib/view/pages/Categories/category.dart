import 'package:dashboard/ViewModel/GetX/QuestionGetX.dart';
import 'package:dashboard/view/empty_widget.dart';
import 'package:dashboard/view/pages/Questions/create_question.dart';
import 'package:flutter/material.dart';
import '../../../ViewModel/GetX/CategoryGetX.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../constant.dart';

class Category extends StatefulWidget {
  final String name;
  const Category({super.key, required this.name});

  @override
  State<Category> createState() => _CategoryState();
}

List<String> options = [];

class _CategoryState extends State<Category> {
  String? dropdownValue;

  @override
  void initState() {
    var fire =
    FirebaseFirestore.instance.collection('category').get().then((value) {
      value.docs.forEach((element) {
        print(element['name']);
        options.add(element['name']);
      });
      setState(() {});
    });

    super.initState();
  }

  var controller = QustionGetX();
  var cat = CategoryController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBarColor,
      appBar: AppBar(

        title: Text(widget.name),
        backgroundColor: Colors.greenAccent,
        elevation: 100,
      ),
      body: StreamBuilder(
          stream:firestore.collection('question').where("selected",isEqualTo:widget.name).snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? const Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Colors.greenAccent,
              ),
            )
                : snapshot.data.docs.length == 0
                ? EmptyWidget()
                : ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        subtitle: Text(
                          "Answer: ${snapshot.data.docs[index]['type'] == 'options' ? snapshot.data.docs[index]['answer'] == 1 ? snapshot.data.docs[index]['option1'] : snapshot.data.docs[index]['answer'] == 2 ? snapshot.data.docs[index]['option2'] : snapshot.data.docs[index]['answer'] == 3 ? snapshot.data.docs[index]['option3'] : snapshot.data.docs[index]['answer'] == 4 ? snapshot.data.docs[index]['option4'] : snapshot.data.docs[index]['option5'] : snapshot.data.docs[index]['answer']}",
                          style: TextStyle(color: Colors.white),
                        ),
                        title: Text(
                            "Question: ${snapshot.data.docs[index]['question']}",
                            style: TextStyle(color: Colors.white)),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                      title: const Center(
                                        child: Text("Confirm Deletion"),
                                      ),
                                      content: Container(
                                        height: 100,
                                        child: Column(
                                          children: [
                                            Text(
                                              "Are you sure want to delete'?",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            SizedBox(height: 30,),

                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                ElevatedButton.icon(
                                                    icon: const Icon(
                                                      Icons.cancel,
                                                      size: 14,
                                                    ),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                        primary:
                                                        Colors.red),
                                                    onPressed: () {
                                                      Get.back();
                                                    },
                                                    label: Text("cancel")),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                ElevatedButton.icon(
                                                    icon: const Icon(
                                                      Icons.delete,
                                                      size: 14,
                                                    ),
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                        primary:
                                                        Colors.red),
                                                    onPressed: () {
                                                      firestore
                                                          .collection('question')
                                                          .doc(snapshot.data.docs[index].id)
                                                          .delete();                                                            },
                                                    label: const Text("Delete"))
                                              ],
                                            )
                                          ],
                                        ),
                                      ));
                                });

                          },
                        ),
                        isThreeLine: true,
                      ),
                      Divider(
                        color: Colors.white,
                      )
                    ],
                  );
                });
          }),
    );
  }
}
