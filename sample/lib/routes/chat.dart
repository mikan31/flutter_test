import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("チャット"),
        ),
        body: new TestList());
  }
}

class TestList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('test');

    return StreamBuilder<QuerySnapshot>(
      stream: users.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return new ListView(
          children: snapshot.data.documents.map((DocumentSnapshot document) {
            return new ListTile(
              title: new Text(document.data()['title']),
              subtitle: new Text(document.data()['content']),
            );
          }).toList(),
        );
      },
    );
  }
}

class Message extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconTheme(
        data: IconThemeData(color: Theme.of(context).accentColor),
        // コンテナ型(自身の中にウィジェットを組み込める)Containerウィジェット
        child: Container(
            alignment: Alignment(0.0, 0.0),
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            // Rowウィジェットは複数のウィジェットを縦に配置するコンテナ型ウィジェット
            child: Row(
              children: <Widget>[
                Flexible(
                  child: TextField(
                    decoration:
                        InputDecoration.collapsed(hintText: "Send a message"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.0),
                  child: Icon(Icons.send),
                )
              ],
            )));
  }
}
