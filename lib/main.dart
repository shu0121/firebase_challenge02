import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_challenge02/firebase_options.dart';
import 'package:firebase_challenge02/add.dart';


//firebase起動
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Challenge02',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var _selectedMenu = '';
  var _popupMenus = ['犬のみ', '猫のみ', '年齢：昇順', '年齢：降順'];

  // static final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  // static final CollectionReference _collectionReference = _firebaseFirestore.collection('animals');

  Stream<QuerySnapshot> _animals = FirebaseFirestore.instance.collection('animals').snapshots();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.sort), color:Colors.white,
            initialValue: _selectedMenu,
            onSelected: (String menu){
              setState(() {
                _selectedMenu = menu;
                if(_selectedMenu.startsWith('犬')){
                  _animals = FirebaseFirestore.instance.collection('animals').where('種類', isEqualTo: '犬').snapshots();
                }else if(_selectedMenu.startsWith('猫')){
                  _animals = FirebaseFirestore.instance.collection('animals').where('種類', isEqualTo: '猫').snapshots();
                }else if(_selectedMenu.contains('昇順')){
                  _animals = FirebaseFirestore.instance.collection('animals').orderBy('年齢').snapshots();
                }else if(_selectedMenu.contains('降順')){
                  _animals = FirebaseFirestore.instance.collection('animals').orderBy('年齢', descending: true).snapshots();
                }else{
                  _animals = FirebaseFirestore.instance.collection('animals').snapshots();
                }
              });
            },
            itemBuilder: (BuildContext context){
              return _popupMenus.map((String menu){
                return PopupMenuItem(child: Text(menu),value: menu,);
              }).toList();
            },
          ),
          // IconButton(onPressed: (){}, icon: Icon(Icons.sort), color:Colors.white,),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:  _animals,
        builder: (context, snapshot){
          if(snapshot.hasData){
            List<DocumentSnapshot> animalsData = snapshot.data!.docs;
            return ListView.separated(
              itemCount: animalsData.length,
              itemBuilder: (BuildContext context, int index){
                Map<String, dynamic> animalData = animalsData[index].data()! as Map<String, dynamic>;
                return ListTile(title: Text('名前：${animalData['名前']}'), subtitle: Text('品種：${animalData['品種']}\n性別：${animalData['性別']}\n年齢：${animalData['年齢']}'), );
              },
              separatorBuilder: (BuildContext context, int index) => const Divider(),
            );
          }else{
            return const Center(child: CircularProgressIndicator(),);
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const add()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

