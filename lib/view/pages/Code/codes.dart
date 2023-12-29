import 'package:dashboard/constant.dart';
import 'package:flutter/material.dart';

class Codes extends StatelessWidget {
  const Codes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<int> items = List<int>.generate(100, (int index) => index);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Codes'),
        backgroundColor: appBarColor,
        elevation: 0,
      ),
      backgroundColor: appBarColor,
      body: StreamBuilder<Object>(
          stream: firestore.collection('codes').snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? const Center(child: CircularProgressIndicator.adaptive(
              backgroundColor: Colors.greenAccent,),): ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  return  Dismissible(
                    key:  Key(snapshot.data.docs[index].id),
                    background: Container(
                      margin: EdgeInsets.all(20),
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 20, bottom: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.red,
                        boxShadow: const [
                          BoxShadow(blurRadius: 100, color: Colors.grey),
                        ],
                      ),
                      child: Center(
                          child: Text('Remove', style: TextStyle(color: Colors
                              .white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),)),),
                    onDismissed: (d) {
                      firestore.collection('codes').doc(
                          snapshot.data.docs[index].id).delete();
                    },
                    child: Container(
                      margin: EdgeInsets.all(20),
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, top: 20, bottom: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: appBarColor,
                        boxShadow: const [
                          BoxShadow(blurRadius: 100, color: Colors.grey),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Code : ${snapshot.data.docs[index]['code']}',
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                snapshot.data.docs[index]['isApplied'] == false
                                    ? 'Not applied'
                                    : 'Applied',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              Text(
                                'Type Coins : ${snapshot.data
                                    .docs[index]['typeCoins']}',
                                style: TextStyle(color: Colors.white),
                              ), Text(
                                'Price : ${snapshot.data.docs[index]['price']}',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
