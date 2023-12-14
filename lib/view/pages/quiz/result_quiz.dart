import 'package:dashboard/ViewModel/GetX/QuizGetx.dart';
import 'package:dashboard/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../widget/Widget_CreateQuiz.dart';

class ResultQuiz extends StatefulWidget {
  final  data;

  const ResultQuiz({super.key, required this.data});
  @override
  State<ResultQuiz> createState() => _ResultQuizState();
}
class _ResultQuizState extends State<ResultQuiz> {
  var ranks={};

  @override
  void initState() {
Get.put(QuizGetX()).getRanks(widget.data['name']).then((value) {
  setState(() {
    ranks.addAll(value);
  });
}).then((value) {

});

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: appBarColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.data['name']),
        actions: [IconButton(
          onPressed: () {
            showDialog<void>(
              context: context,
              barrierDismissible: false,
              // user must tap button!
              builder: (BuildContext context) {
                return const CreateQuiz();
              },
            );
          },
          icon: const Icon(
            Icons.edit,
            color: Colors.white,
          ),
        ),
          IconButton(
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
                                "Are you sure want to delete '${widget.data['name']}'?",
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
                                            .doc(widget.data.id)
                                            .delete();                                      },
                                      label: const Text("Delete"))
                                ],
                              )
                            ],
                          ),
                        ));
                  });
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),],
        backgroundColor: appBarColor,
      ),
      body:Column(
        children: [


        ],
      ) ,
    );
  }
}
