import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../ViewModel/GetX/CategoryGetX.dart';
import '../../../constant.dart';

class TotalCategories extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _imageUrLController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var categoryController = CategoryController();

    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () {
              showDialog<void>(
                context: context,
                barrierDismissible: false,
                // user must tap button!
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: ListBody(
                          children: <Widget>[
                            TextFormField(
                              controller: _nameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please fill the field'
                                      ;
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: "Catergory name",
                                fillColor: Colors.grey,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 1.0),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                              controller: _imageUrLController,
                              decoration: InputDecoration(
                                labelText: "Image Url",
                                fillColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 1.0),
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            FutureBuilder(
                                future: categoryController.postCategory(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return ElevatedButton(
                                      onPressed: () {
                                        categoryController.name =
                                            _nameController.text;
                                        categoryController.imageUrl =
                                            _imageUrLController.text;

                                        categoryController.postCategory();
                                        _nameController.clear();
                                        _imageUrLController.clear();
                                      },
                                      child: Text('Save'),
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  appBarColor)),
                                    );
                                  } else
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                })
                          ],
                        ),
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        child: Text(
                          'cancel',
                          style: TextStyle(color: appBarColor),
                        ),
                        onPressed: () {
                         Get.back();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            child: Text(
              'Add Category',
              style: TextStyle(color: Colors.greenAccent),
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(appBarColor)),
          )
        ],
        title: Text('Categories'),
        backgroundColor: appBarColor,
        elevation: 0,
      ),
      backgroundColor: appBarColor,
      body: StreamBuilder(
          stream: categoryController.docs,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.greenAccent,
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(30),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                      color: backgroundColor, blurRadius: 100)
                                ],
                                color: Colors.white12),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  child: Image.network(snapshot.data.docs[index]['imageUrl']),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(
                                        snapshot.data.docs[index]['name'],
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                    )),
                                Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: IconButton(
                                        onPressed: () {
                                          showDialog<void>(
                                            context: context,
                                            barrierDismissible: false,
                                            // user must tap button!
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                backgroundColor: Colors.white,
                                                content: SingleChildScrollView(
                                                  child: ListBody(
                                                    children: <Widget>[
                                                      TextFormField(
                                                        initialValue: 'math',
                                                        decoration:
                                                            InputDecoration(
                                                          labelText:
                                                              "Catergory name",
                                                          fillColor:
                                                              Colors.grey,
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .black,
                                                                    width: 1.0),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25.0),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      TextFormField(
                                                        initialValue:
                                                            'image/daasdasdffaadc.adasdadaas.png',
                                                        decoration:
                                                            InputDecoration(
                                                          labelText:
                                                              "Image Url",
                                                          fillColor:
                                                              Colors.white,
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: Colors
                                                                        .grey,
                                                                    width: 1.0),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        25.0),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 20,
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () {},
                                                        child: Text('Delete'),
                                                        style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all(
                                                                        appBarColor)),
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () {},
                                                        child: Text('Save'),
                                                        style: ButtonStyle(
                                                            backgroundColor:
                                                                MaterialStateProperty
                                                                    .all(
                                                                        appBarColor)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text(
                                                      'cancel',
                                                      style: TextStyle(
                                                          color: appBarColor),
                                                    ),
                                                    onPressed: () {
                                                     Get.back();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  });
            }
          }),
    );
  }
}
