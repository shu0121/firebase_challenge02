import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_challenge02/firebase_options.dart';


class add extends StatefulWidget {
  const add({Key? key}) : super(key: key);

  @override
  State<add> createState() => _addState();


}

//ラジオボタン選択
enum RadioValue {First, Second}

class _addState extends State<add> {

  //ラジオボタンの初期値
  String _nameValue = '';
  String _sexValue = '';

  //コントローラー
  TextEditingController inputNameController = TextEditingController();
  TextEditingController inputBreedController = TextEditingController();
  TextEditingController inputAgeController = TextEditingController();

  String infoText = '';
  String _petName = '';
  String _breed = '';
  String _age = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            //名前
            Container(
              width: 250,
              child: TextField(
                keyboardType: TextInputType.text,
                controller: inputNameController,
                decoration: InputDecoration(
                    labelText: '名前',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),
                onChanged: (String value){
                  setState(() {
                    _petName = value;
                  });
                },
              ),
            ),

            SizedBox(height: 5,),

            //ラジオボタン
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //ラジオボタン：犬
                  Radio(
                    activeColor: Colors.lightBlue,
                    value: '犬',
                    groupValue: _nameValue,
                    onChanged: _onNameSelected,
                  ),
                  Text('犬'),

                  SizedBox(width: 50,),

                  //ラジオボタン：猫
                  Radio(
                    activeColor: Colors.lightBlue,
                    value: '猫',
                    groupValue: _nameValue,
                    onChanged: _onNameSelected,
                  ),
                  Text('猫'),
                ],
              ),
            ),


            SizedBox(height: 30,),


            //品種
            Container(
              width: 250,
              child: TextField(
                keyboardType: TextInputType.text,
                controller: inputBreedController,
                decoration: InputDecoration(
                    labelText: '品種',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),
                onChanged: (String value){
                  setState(() {
                    _breed = value;
                  });
                },
              ),
            ),

            SizedBox(height: 5,),

            //ラジオボタン
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //ラジオボタン：オス
                  Radio(
                    activeColor: Colors.lightBlue,
                    value: 'オス',
                    groupValue: _sexValue,
                    onChanged: _onSexSelected,
                  ),
                  Text('オス'),

                  SizedBox(width: 50,),

                  //ラジオボタン：メス
                  Radio(
                    activeColor: Colors.lightBlue,
                    value: 'メス',
                    groupValue: _sexValue,
                    onChanged: _onSexSelected,
                  ),
                  Text('メス'),
                ],
              ),
            ),


            SizedBox(height: 30,),


            //年齢
            Container(
              width: 250,
              child: TextField(
                keyboardType: TextInputType.number,
                controller: inputAgeController,
                decoration: InputDecoration(
                    labelText: '年齢',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                ),
                onChanged: (String value){
                  setState(() {
                    _age = value;
                  });
                },
              ),
            ),


            SizedBox(height: 30,),


            //登録ボタン
            ElevatedButton(
              onPressed: () async{
                if(_petName != '' && _nameValue != '' && _breed != '' && _sexValue != '' && _age != ''){
                  FirebaseFirestore.instance.collection('animals').add({
                    '名前': _petName,
                    '種類': _nameValue,
                    '品種': _breed,
                    '性別': _sexValue,
                    '年齢': _age
                  });
                }
              },
              child: Text('登録'),
            ),


          ],
        ),
      ),
    );
  }

  void _onNameSelected(value){
    setState(() {
      _nameValue = value;
    });
  }

  void _onSexSelected(value){
    setState(() {
      _sexValue = value;
    });
  }
}
