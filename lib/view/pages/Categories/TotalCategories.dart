import 'package:dashboard/view/pages/Categories/category.dart';
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

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
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
                                      return 'Please fill the field';
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

                                            categoryController
                                                .postCategory()
                                                .then((value) => Get.back());
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
                              Navigator.pop(
                                  context);
                              _imageUrLController
                                  .clear();
                              _nameController
                                  .clear();                            },
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
              ),
            )
          ],
          title: const Text('Categories'),
          backgroundColor: Colors.greenAccent,
          elevation: 0,
        ),
        backgroundColor: appBarColor,
        body: StreamBuilder(
            stream: categoryController.docs,
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.greenAccent,
                  ),
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Get.to(Category(
                            name: snapshot.data.docs[index]['name'],
                          ));
                        },
                        child: Container(
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
                                          color: backgroundColor,
                                          blurRadius: 100)
                                    ],
                                    color: Colors.white12),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      child: Image.network(snapshot
                                          .data.docs[index]['imageUrl']),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Text(
                                            snapshot.data.docs[index]['name'],
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white),
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
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                    backgroundColor:
                                                        Colors.white,
                                                    content:
                                                        SingleChildScrollView(
                                                      child: ListBody(
                                                        children: <Widget>[
                                                          TextFormField(
                                                            controller: _nameController
                                                              ..text = snapshot
                                                                          .data
                                                                          .docs[
                                                                      index]
                                                                  ['name'],
                                                            decoration:
                                                                InputDecoration(
                                                              labelText:
                                                                  "Catergory name",
                                                              fillColor:
                                                                  Colors.grey,
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderSide: const BorderSide(
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
                                                            controller: _imageUrLController
                                                              ..text = snapshot
                                                                          .data
                                                                          .docs[
                                                                      index]
                                                                  ['imageUrl'],
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
                                                                        width:
                                                                            1.0),
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
                                                            onPressed:
                                                                () async {
                                                              await firestore
                                                                  .collection(
                                                                      'category')
                                                                  .doc(snapshot
                                                                      .data
                                                                      .docs[
                                                                          index]
                                                                      .id)
                                                                  .delete()
                                                                  .then(
                                                                      (value) async {
                                                                await firestore
                                                                    .collection(
                                                                        'question')
                                                                    .where(
                                                                        "selected",
                                                                        isEqualTo: snapshot
                                                                            .data
                                                                            .docs[index]['name'])
                                                                    .get()
                                                                    .then((value) {
                                                                  value.docs
                                                                      .forEach(
                                                                          (element) {
                                                                    firestore
                                                                        .collection(
                                                                            'question')
                                                                        .doc(element
                                                                            .id)
                                                                        .delete();
                                                                  });
                                                                });
                                                              });
                                                              Navigator.pop(
                                                                  context);                                                            },
                                                            child:
                                                                Text('Delete'),
                                                            style: ButtonStyle(
                                                                backgroundColor:
                                                                    MaterialStateProperty
                                                                        .all(
                                                                            appBarColor)),
                                                          ),
                                                          ElevatedButton(
                                                            onPressed:
                                                                () async {
                                                              await firestore
                                                                  .collection(
                                                                      'category')
                                                                  .doc(snapshot
                                                                      .data
                                                                      .docs[
                                                                          index]
                                                                      .id)
                                                                  .update({
                                                                "imageUrl":
                                                                    _imageUrLController
                                                                        .text,
                                                                "name":
                                                                    _nameController
                                                                        .text
                                                              }).then((value) {
                                                                Navigator.pop(
                                                                    context);                                                                Get.snackbar(
                                                                    'Jacobia',
                                                                    "Successfully updated");
                                                              });
                                                            },
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
                                                        child: const Text(
                                                          'cancel',
                                                          style: TextStyle(
                                                              color:
                                                                  appBarColor),
                                                        ),
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                          _imageUrLController
                                                              .clear();
                                                          _nameController
                                                              .clear();
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
                        ),
                      );
                    });
              }
            }),
      ),
    );
  }
}
