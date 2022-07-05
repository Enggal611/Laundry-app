import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../screen/login_sc.dart'; 

class account extends StatefulWidget {


  final String  id, 
                nama, 
                alamat, 
                telepon, 
                email, 
                password;

  const account({
    required this.id,
    required this.nama,
    required this.alamat,
    required this.telepon,
    required this.email,
    required this.password,
    String profile = " "
  });

  @override
  State<account> createState() => _accountState();
}

class _accountState extends State<account> {

//=======================

  Future<void> simpan() async{
    final showImage = await uploadFile();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference akun = firestore.collection("akun");


    await akun.add({
      "profile": showImage,
      
    });
  }


  File? _photo;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker
    .pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future imgFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadFile() async {
    String show;
    String fname = DateTime.now().toString();
    Reference reff = FirebaseStorage.instance
    .ref()
    .child('profile/$fname');

    await reff.putFile(_photo!);

    show = await reff.getDownloadURL();
    return show;

  }

  //=======================

  //======================

  Future imageUrl() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage
    .ref()
    .child('profile');
    await ref.putFile(File(_photo!.path));
    String imageUrl = await ref.getDownloadURL();
  }

  Future imgProfile() async {
    String urlImage;
    String fname = DateTime.now().toString();
    Reference reff = FirebaseStorage.instance
    .ref()
    .child('profile/$fname');

    urlImage = await reff.getDownloadURL();
    
    setState(() {
      url: urlImage;
    });

  }

  //=====END========


  
  final Nama = TextEditingController();
  final Alamat = TextEditingController();
  final Telepon = TextEditingController();
  final Email = TextEditingController();
  final Profile = TextEditingController();

  final currentUser = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        
        actions: [
          IconButton(
            onPressed: (){
              var box = Hive.box('user').clear();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              duration: Duration(seconds: 1),
              content: Text('Mohon Tunggu')));
                                                      

              Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => login_screen()));
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                content: Text('Berhasil Log Out'),
                duration: Duration(seconds: 1),
                )
              );
            }, 
            icon: Icon(Icons.logout_outlined,
            size: 30,))
        ],
        elevation: 0,
        // backgroundColor: Colors.transparent,
        title: Text('My Account'),
        
        
      ),
      body: Container(
      
        child: Stack(
          children: [
            Positioned.fill(
              bottom: 350,
                  child: Container(
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
                          Colors.blue
                          ]
                          )
                        ),
                    ),
                  )
                ),

                Padding(
                  padding: const EdgeInsets.only(
                    top: 50,
                    left: 10,
                    right: 10,
                    bottom: 10),
                  child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 25,
                    mainAxisSpacing: 25,
                    mainAxisExtent: 550,
                  ),
                  children: [
                    SingleChildScrollView  (
                      child: Card(
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: 
                            Colors.blue
                            .withOpacity(1),
                            width: 4
                            ),
                          ),
                          child: 
                          StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("akun")
                              .where("uid", isEqualTo: currentUser.currentUser!.uid)
                              .snapshots(),
                              
                              
                          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, i) {
                                  var data = snapshot.data!.docs[i];
                                  return Column(
                                    children: [
                    
                                      Padding(
                                        padding: const EdgeInsets.only(left: 50, top: 20, bottom: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                            radius: 55,
                                            backgroundImage: 
                                            NetworkImage("${snapshot.data!.docs[i]['profile']}"),
                                            
                                            ),
                    
                                            IconButton(
                                              
                                              onPressed: (){
                                              
                                              showDialog(
                                                context: context, 
                                                builder: (context) => 
                                                Dialog(
                                                    backgroundColor: Colors.transparent,
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(5),
                                                      child: Container(
                                                        width: double.infinity,
                                                          height: 230,
                                                          decoration: BoxDecoration(
                                                            boxShadow: [
                                                              BoxShadow(
                                                                spreadRadius: 2,
                                                                blurRadius: 3,
                                                                color: Colors.blue.withOpacity(1),
                                                                
                                                              ),
                                                            ],
                                                            borderRadius: BorderRadius.circular(15),
                                                            color: Colors.white
                                                          ),
                    
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(10),
                                                          child: Center(
                                                            child: SingleChildScrollView (
                                                              child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Text('Foto Profil Harus Diisi !',
                                                                style: TextStyle(
                                                                  fontSize: 15,
                                                                  color: Colors.red
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                                                                  child: GestureDetector(
                                                                  onTap: () {
                                                                    _showPicker(context);
                                                                  },
                                                                  child: _photo != null
                                                                  ? ClipRRect(
                                                                    borderRadius: BorderRadius.circular(60),
                                                                    child: Image.file(
                                                                      _photo!,
                                                                      width: 120,
                                                                      height: 120,
                                                                      fit: BoxFit.cover,
                                                                    ),
                                                                  )
                                                                  : CircleAvatar(
                                                                  radius: 50,
                                                                  backgroundColor: Colors.blue,
                                                                  
                                                                  child: Icon(
                                                                    Icons.camera_alt,
                                                                    color: Colors.grey[800],
                                                                        ),
                                                                      ),
                                                                      
                                                                    ),
                                                                ),
                                                              
                                                            
                                                                  Padding(
                                                                    padding: const EdgeInsets.all(10),
                                                                    child: ElevatedButton(
                                                                      style: ElevatedButton.styleFrom(
                                                                      primary: Colors.blue[700],
                                                                      shape: RoundedRectangleBorder(
                                                                        borderRadius: BorderRadius.circular(20),
                                                                      ),
                                                                    ),
                                                                      onPressed: ()async{
                                                            
                                                                        
                                                                        FirebaseFirestore firestore = FirebaseFirestore.instance;
                                                                        CollectionReference akun = firestore.collection("akun");
                                                                        final showImage = await uploadFile();
                                                            
                                                                        await 
                                                                          snapshot.data!.docs[i]
                                                                          .reference
                                                                          .update({
                                                                            "profile" : showImage
                                                                          
                                                                            }).then((value) {
                                                                          Navigator.of(context)
                                                                          .pop(context);
                                                                          
                                                                          ScaffoldMessenger.of(context).showSnackBar(
                                                                            SnackBar(content: Text('Foto Disimpan'))
                                                                          );
                                                                        });
                                                                      }, 
                                                                      child: Text('Simpan',
                                                                      style: TextStyle(
                                                                        fontSize: 17,
                                                                        fontWeight: FontWeight.bold
                                                                      ),
                                                                      ),
                                                                      ),
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                    
                                                        
                                                      ),
                                                    ),
                                                  )
                                              );
                    
                                              }, 
                                              icon: Icon(Icons.edit)
                                            )
                                          ] 
                                        ),
                                      ),
                    
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10, right: 10),
                                        child: SizedBox(
                                          width: double.infinity,
                                          height: 60,
                                          child: Card(
                                            color: Colors.grey[300],
                                            shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15),
                                            
                                            ),
                                            
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 10),
                                                  child: Text('Nama',
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.black)
                                                  ),
                                                ),
                                                SizedBox(width: 25,),
                                                Text(
                                                  data['nama'],
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17,
                                                    color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      
                    
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10, right: 10),
                                        child: SizedBox(
                                          width: double.infinity,
                                          height: 60,
                                          child: Card(
                                            color: Colors.grey[300],
                                            shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15),
                                            ),
                                            
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 10),
                                                  child: Text('Alamat',
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.black)
                                                  ),
                                                ),
                                                SizedBox(width: 18,),
                                                Text(
                                                  data['alamat'],
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17,
                                                    color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      
                    
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10, right: 10),
                                        child: SizedBox(
                                          width: double.infinity,
                                          height: 60,
                                          child: Card(
                                            color: Colors.grey[300],
                                            shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15),
                                            ),
                                            
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 10),
                                                  child: Text('Telepon',
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.black)
                                                  ),
                                                ),
                                                SizedBox(width: 12,),
                                                Text(
                                                  data['telepon'],
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17,
                                                    color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                                      
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10, right: 10 ),
                                        child: SizedBox(
                                          width: double.infinity,
                                          height: 60,
                                          child: Card(
                                            color: Colors.grey[300],
                                            shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(15),
                                            ),
                                            
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 10),
                                                  child: Text('Email',
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.black)
                                                  ),
                                                ),
                                                SizedBox(width: 30,),
                                                Text(
                                                  data['email'],
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 17,
                                                    color: Colors.black),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10,),
                    
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10, bottom: 15),
                                        child: Column(
                                        children: [
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.blue[700],
                                                shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20),
                                                ),
                                                                      
                                              ),
                                            
                                              child: Text('Edit Profile',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  ),
                                                ),
                                            
                                                onPressed: () {
                                                  
                                                  Nama.text = data['nama'];
                                                  Alamat.text = data['alamat'];
                                                  Telepon.text = data['telepon'];
                                                  showDialog(
                                                  context: context, 
                                                  builder: (context) => 
                                                  Dialog(
                                                      backgroundColor: Colors.transparent,
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(5),
                                                        child: Container(
                                                          width: double.infinity,
                                                            height: 350,
                                                            decoration: BoxDecoration(
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  spreadRadius: 2,
                                                                  blurRadius: 3,
                                                                  color: Colors.blue.withOpacity(1),
                                                                  
                                                                ),
                                                              ],
                                                              borderRadius: BorderRadius.circular(15),
                                                              color: Colors.white
                                                            ),
                    
                                                          child: Padding(
                                                            padding: const EdgeInsets.all(10),
                                                            child: Center(
                                                              child: SingleChildScrollView (
                                                                child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  
                                                                  //NAMA
                                                                  Padding(
                                                                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                                                                    child: TextFormField(
                                                                      controller: Nama,
                                                                      style:
                                                                          TextStyle(
                                                                            color: Colors.black, 
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 17),
                                                              
                                                                      decoration: InputDecoration(
                                                                        hintText: "Nama Lengkap",
                                                                        label: Text('Nama Lengkap'),
                                                                        border: OutlineInputBorder(
                                                                            borderRadius: BorderRadius.circular(15)
                                                                            ),
                                                                        
                                                                          ),
                                                                      
                                                                          ),
                                                                      ),
                                                                  SizedBox(height: 10,),
                                                                    
                                                                    //ALAMAT
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                                                                      child: TextFormField(
                                                                      controller: Alamat,
                                                                      style:
                                                                          TextStyle(
                                                                            color: Colors.black, 
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 17),
                                                              
                                                                      decoration: InputDecoration(
                                                                        hintText: "Alamat Lengkap",
                                                                        label: Text('Alamat Lengkap'),
                                                                        border: OutlineInputBorder(
                                                                            borderRadius: BorderRadius.circular(15)
                                                                            )
                                                                          ),
                                                                        ),
                                                                    ),
                                                                  SizedBox(height: 10,),
                                                                    
                                                                    //TELEPON
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                                                                      child: TextFormField(
                                                                        
                                                                      controller: Telepon,
                                                                      style:
                                                                          TextStyle(
                                                                            color: Colors.black, 
                                                                            fontWeight: FontWeight.bold,
                                                                            fontSize: 17),
                                                              
                                                                      decoration: InputDecoration(
                                                                        hintText: "Telepon",
                                                                        label: Text('Telepon'),
                                                                        border: OutlineInputBorder(
                                                                            borderRadius: BorderRadius.circular(15)
                                                                            )
                                                                            
                                                                          ),
                                                                        ),
                                                                    ),
                                                              
                                                                    Padding(
                                                                      padding: const EdgeInsets.all(10),
                                                                      child: ElevatedButton(
                                                                        style: ElevatedButton.styleFrom(
                                                                        primary: Colors.blue[700],
                                                                        shape: RoundedRectangleBorder(
                                                                          borderRadius: BorderRadius.circular(20),
                                                                        ),
                                                                      ),
                                                                        onPressed: ()async{
                                                              
                                                                          
                                                                          FirebaseFirestore firestore = FirebaseFirestore.instance;
                                                                          CollectionReference akun = firestore.collection("akun");
                                                                          
                                                                          await 
                                                                            snapshot.data!.docs[i]
                                                                            .reference
                                                                            .update({
                                                                              "nama" : Nama.text,
                                                                              "alamat": Alamat.text,
                                                                              "telepon": Telepon.text,
                                                                            
                                                                              }).then((value) {
                                                                            Navigator.of(context)
                                                                            .pop(context);
                                                                            
                                                                            ScaffoldMessenger.of(context).showSnackBar(
                                                                              SnackBar(content: Text('Profile Tersimpan'))
                                                                            );
                                                                          });
                                                                        }, 
                                                                        child: Text('Simpan',
                                                                        style: TextStyle(
                                                                          fontSize: 17,
                                                                          fontWeight: FontWeight.bold
                                                                        ),
                                                                        ),
                                                                        ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                    
                                                          
                                                        ),
                                                      ),
                                                    )
                                                  );
                                                  
                                                  },
                                                ),
                                                SizedBox(width: 20,),
                                            ],
                                          ),
                                      ),
                    
                                    ],
                                  );
                                });
                              } else {
                                return 
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: 
                                      Text('Data Tidak Ada',
                                      style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold
                                          ),
                                        )
                                      ),
                                  ],
                                );
                              }
                            }
                          ),
                      ),
                    ),
                  ],
                ),
              ),
              
            ],
          ),
      ),
    );
  }

   void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        imgFromGallery();
                        Navigator.of(context).pop();
                      }),

                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

}
