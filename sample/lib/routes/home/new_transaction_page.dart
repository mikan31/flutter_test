import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sample/routes/home/home.dart';

class NewTransaction extends StatelessWidget{
  String JobName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ジョブの追加"),
      ),
      body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                children:<Widget>[
                  Row(
                    children:<Widget> [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('ジョブ名:'),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Container(
                          width: 300,
                          child: TextField(
                            onChanged: (text){
                              JobName = text;
                              },
                          ),
                        ),
                      ),
                    ],
                  ),
                  RaisedButton(
                    child: Text('ジョブを公開'),
                    onPressed: () async{
                      try{
                        await addJobToFirebase(); //Firebaseに追加

                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('公開完了'),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('OK'),
                                  onPressed: () async{
                                    await Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );

                        //公開完了したらホームに戻る
                        await Navigator.of(context).pop();
                      } catch(e){ //フォーム未入力時の処理
                        await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(e.toString()),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('OK'),
                                  onPressed: () async{
                                   await Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                  ),
                ]
            ),
          ),
      ),
    );
  }

  Future addJobToFirebase() async{
    if(JobName.isEmpty){
      throw('ジョブの名前を入力してください');
    }
    FirebaseFirestore.instance.collection('Job').add({
      'title': 'Job',
      'createdAt': Timestamp.now(),
    },
    );
  }
}
