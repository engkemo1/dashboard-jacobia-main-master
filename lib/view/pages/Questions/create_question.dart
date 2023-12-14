import 'package:dashboard/Models/options.dart';
import 'package:dashboard/ViewModel/GetX/QuizGetx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import '../../../constant.dart';
import '../../../ViewModel/GetX/QuestionGetX.dart';
import '../../widget/DropDownWidget.dart';

class CreateQuestion extends StatefulWidget {
  @override
  State<CreateQuestion> createState() => _CreateQuestionState();
}

class _CreateQuestionState extends State<CreateQuestion> {
  final TextEditingController _question = TextEditingController();
  final TextEditingController _imageUrLController = TextEditingController();
  final TextEditingController _option1 = TextEditingController();
  final TextEditingController _option2 = TextEditingController();
  final TextEditingController _option3 = TextEditingController();
  final TextEditingController _option4 = TextEditingController();
  final TextEditingController _option5 = TextEditingController();

  String? dropdownValue;

  final _formKey = GlobalKey<FormState>();

  int index = 0;

  String? corAns;

  bool truefalse = false;
  var controller = Get.put(QustionGetX());
  var quizGetx = Get.put(QuizGetX());
  List<Options>optionsList=[];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('Add Question'),centerTitle: true,backgroundColor: appBarColor,),
      body: Container(
        padding: EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: appBarColor,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 5),
                      child: Text(
                        "Questions Type:",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          unselectedWidgetColor: Colors.greenAccent,
                        ),
                        child: RadioListTile(
                          title: const Text(
                            'Options',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          value: 0,
                          selectedTileColor: Colors.white,
                          activeColor: Colors.greenAccent,
                          groupValue: index,
                          onChanged: (int? value) {
                            setState(() {
                              index = value!;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(unselectedWidgetColor: Colors.greenAccent),
                        child: RadioListTile(
                          activeColor: Colors.greenAccent,
                          title: const Text('True/False',
                              style:
                              TextStyle(color: Colors.white, fontSize: 15)),
                          value: 1,
                          groupValue: index,
                          onChanged: (int? value) {
                            setState(() {
                              index = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                index == 0
                    ? Container(
                  child: Column(
                    children: [
                      InputField(
                          controller: _option1,
                          label: 'A',
                          hint: 'Option',
                          iconOrdrop: 'icon',
                          isEnabled: true,
                          texth: 15),
                      const SizedBox(
                        height: 10,
                      ),
                      InputField(
                          controller: _option2,
                          label: 'B',
                          hint: 'Option',
                          iconOrdrop: 'icon',
                          isEnabled: true,
                          texth: 15),
                      SizedBox(
                        height: 10,
                      ),
                      InputField(
                          controller: _option3,
                          label: 'C',
                          hint: 'Option',
                          iconOrdrop: 'icon',
                          isEnabled: true,
                          texth: 15),
                      SizedBox(
                        height: 10,
                      ),
                      InputField(
                          controller: _option4,
                          label: 'D',
                          hint: 'Option',
                          iconOrdrop: 'icon',
                          isEnabled: true,
                          texth: 15),
                      SizedBox(
                        height: 10,
                      ),
                      InputField(
                          controller: _option5,
                          label: 'E',
                          hint: 'Option',
                          iconOrdrop: 'icon',
                          isEnabled: true,
                          texth: 15),
                      SizedBox(
                        height: 30,
                      ),
                      DropdownButtonFormField(
                        elevation: 0,
                        iconEnabledColor: Colors.white,
                        style: TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Please Select Correct Answer',
                          hintStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            //<-- SEE HERE
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            //<-- SEE HERE
                            borderSide:
                            BorderSide(color: Colors.white, width: 1),
                          ),
                          filled: true,
                          fillColor: appBarColor,
                        ),
                        iconDisabledColor: Colors.white,
                        dropdownColor: Colors.black,
                        value: corAns,
                        onChanged: (String? newValue) {
                          corAns = newValue!;
                        },
                        items: ['A', 'B', 'C', 'D', 'E']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(fontSize: 20),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                )
                    : Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          unselectedWidgetColor: Colors.greenAccent,
                        ),
                        child: RadioListTile(
                          title: const Text(
                            'True',
                            style: TextStyle(
                                color: Colors.white, fontSize: 15),
                          ),
                          value: true,
                          selectedTileColor: Colors.white,
                          activeColor: Colors.greenAccent,
                          groupValue: truefalse,
                          onChanged: (bool? value) {
                            setState(() {
                              truefalse = value!;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Theme(
                        data: Theme.of(context).copyWith(
                            unselectedWidgetColor: Colors.greenAccent),
                        child: RadioListTile(
                          activeColor: Colors.greenAccent,
                          title: const Text('False',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 15)),
                          value: false,
                          groupValue: truefalse,
                          onChanged: (bool? value) {
                            setState(() {
                              truefalse = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),

                SizedBox(
                  height: 10,
                ),
                InputField(
                    label: 'Question ',
                    hint: 'Enter Question',
                    controller: _question,
                    iconOrdrop: 'icon',
                    isEnabled: true,
                    texth: 15),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 10,
                ),
                InputField(
                    controller: _imageUrLController,
                    label: 'Image Url',
                    hint: 'Enter Image UrL',
                    iconOrdrop: 'icon',
                    isEnabled: true,
                    texth: 15),
                SizedBox(
                  height: 20,
                ),
                MultiSelectDialogField(
                  title: const Text('Categories',style: TextStyle(color: Colors.black),),
                  buttonText: const Text('Category',style: TextStyle(color: Colors.white54),),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white)
                  ),
                  items:quizGetx.optionsModelList.map((a) => MultiSelectItem<Options>(a, a.name))
                      .toList(),
                  listType: MultiSelectListType.CHIP,
                  onConfirm: (List<Options>  values) {
                    optionsList=values;
                    controller.selectedOptionList.value.clear();
                    values.forEach((element) {
                      controller.selectedOptionList.value.add(element.name);
                    });


                  } ,


                ),

                SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {
                      if(_formKey.currentState!.validate()){
                        controller.answer = corAns;
                        controller.answertf = truefalse;
                        controller.option1 = _option1.text;
                        controller.option2 = _option1.text;
                        controller.option3 = _option1.text;
                        controller.option4 = _option1.text;
                        controller.option5 = _option1.text;
                        controller.type = index;
                        controller.question = _question.text;

                        if (controller.type == 0) {
                          controller.postQOptions();
                        } else {
                          controller.postQTF();
                        }

                        _option1.clear();
                        _option2.clear();
                        _option3.clear();
                        _option4.clear();
                        _option5.clear();
                        _question.clear();
                        _imageUrLController.clear();
                        controller.selectedOptionList.value.clear();
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all(Colors.greenAccent)),
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
