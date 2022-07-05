
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';


import 'profile.dart';
import '../form/add.dart';
import '../form/delete/read_del.dart';
import '../form/read.dart';
import '../form/update/read_upd.dart';

class adminPage extends StatefulWidget {
  
  final String id, nama, umur, tgl, gbr;

  const adminPage({Key? key,
    required this.id,
    required this.nama,
    required this.umur,
    required this.tgl,
    required this.gbr,
    }) : super(key: key);

  @override
  _adminPageState createState() => _adminPageState();
}

class _adminPageState extends State<adminPage> {

  final currentUser = FirebaseAuth.instance;

  int? id;
  String? nama;
  String? umur;
  String? tgl;
  String? gbr;

  @override
  void initState(){
    super.initState();
    // getData();
  }

  @override

  

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
        body: Container(

          child: SafeArea(
            child: Stack(
              children: <Widget>[

                Positioned.fill(
                  bottom: 350,
                  child: Container(
                    decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)
                    ),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.blue, 
                          Colors.blue]
                          )
                        ),
                    
                  ),
                ),
                
                
                Positioned.fill(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                          
                          StreamBuilder(
                            stream: FirebaseFirestore.instance
                            .collection("akun")
                            .where("uid", isEqualTo: currentUser.currentUser!.uid)
                            .snapshots(),
                            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasData){
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, item){
                                  var data = snapshot.data!.docs[item];
                                    return Column( 
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [

                                        SizedBox(height: 20),
                                        Container(
                                          padding: EdgeInsets.all(5),
                                          child: 
                                          CircleAvatar(
                                              radius: 55,
                                              backgroundColor: Colors.white,
                                              backgroundImage: NetworkImage(
                                                "${snapshot
                                                .data!
                                                .docs[item]['profile']}"),

                                          )
                                        ),
                                          SizedBox(height: 16),

                                        Text('Hai Admin, ' + data['nama'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.white
                                            ),
                                          ),
                                      ],
                                    );
                                      }
                                  );
                                } else{
                                  return CircularProgressIndicator();
                                }
                              }
                            ),
                            SizedBox(height: 10,),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            
                            ),
                          ),
                          onPressed: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(
                              builder: (context) => account(
                                
                                id: '', 
                                nama: '',
                                alamat: '', 
                                telepon: '', 
                                email: '', 
                                password: '',))
                            );
                          }, 
                          child: Text('Account Setting',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue
                          ),
                          )
                          ),
                          
                        
                        SizedBox(height: 10),
                        GridView(
                          padding:   EdgeInsets.all(15),
                          shrinkWrap: true,
                          primary: false,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15,
                          ),
                          children: [
                            InkWell(
                              onTap: (){
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                  builder: (_) => Add())
                                );
                              },

                              child: Card(
                                elevation: 10,
                                shadowColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(
                                  color: Colors.grey.withOpacity(0.5),
                                  width: 4,
                                ),
                               ),
                                child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('image/icon/add.png',
                                  height: 90,),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text('Order Laundry',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15
                                  ),),
                                ],
                               ),
                              ),
                            ),

                        InkWell(
                          onTap: (){
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                  builder: (_) => Read())
                                );
                              },

                          child: Card(
                            elevation: 10,
                            shadowColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: Colors.grey.withOpacity(0.5),
                                width: 4,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('image/icon/read.png',
                                height: 90,),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('Customer',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        InkWell(
                          onTap: (){
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                  builder: (context) => readUpd()
                                  )
                                );
                              },

                          child: Card(
                            elevation: 10,
                            shadowColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: Colors.grey.withOpacity(0.5),
                                width: 4,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('image/icon/save.png',
                                height: 90,),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('Proses Laundry',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                                ),),
                              ],
                            ),
                          ),
                        ),

                        InkWell(
                          onTap: (){
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                  builder: (_) => readDel())
                                );
                              },

                          child: Card(
                            elevation: 10,
                            shadowColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                color: Colors.grey.withOpacity(0.5),
                                width: 4,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('image/icon/del.png',
                                height: 90,),
                                SizedBox(
                                  height: 10,
                                ),
                                Text('Sampah',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15
                                ),),
                              ],
                            ),
                          ),
                        ),
                            
                            
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }


}