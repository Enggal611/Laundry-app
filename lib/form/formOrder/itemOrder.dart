import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '/user/botnav.dart';

class order extends StatefulWidget {
  @override
  _orderState createState() => _orderState();
}

class _orderState extends State<order> {
  //TOTAL

  String hasil = '';
  Total() {
    setState(() {
      var tot = int.parse(berat.text);
      var totalT = 10 * tot;
      hasil = totalT.toString();
    });
  }
  //END TOTAL

  //CRUD
  final TextEditingController nama = TextEditingController();
  final TextEditingController tgl = TextEditingController();
  final TextEditingController telp = TextEditingController();
  final TextEditingController Alamat = TextEditingController();
  final TextEditingController status = TextEditingController();
  final TextEditingController diambil = TextEditingController();
  final TextEditingController berat = TextEditingController();
  final TextEditingController total = TextEditingController();
  final TextEditingController selesai = TextEditingController();
  final TextEditingController bayar = TextEditingController();

  Future<void> update() async {
    final showImage = await uploadFile();
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference cust = firestore.collection("cust");

    await cust.add({
      "nama": nama.text,
      "alamat": Alamat.text,
      "telepon": telp.text,
      "berat": berat.text,
      "status": status.text,
      "diambil": diambil.text,
      "laundry selesai": selesai.text,
      "pembayaran": bayar.text,
      "total": total.text,
      "tanggal": tgl.text,
      "gambar": showImage,
    });
  }
  //END CRUD

  //FOTO

  File? _photo;
  final ImagePicker _picker = ImagePicker();

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

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
    Reference reff = FirebaseStorage.instance.ref().child('files/$fname');

    await reff.putFile(_photo!);

    show = await reff.getDownloadURL();
    return show;
  }
  //END FOTO

  //DROPDOWN
  String dropdown = 'Pilih Pengiriman';
  var items = [
    'Pilih Pengiriman',
    'Di Antar Sendiri',
    'Di Ambil Kurir',
  ];

  String dropDown = 'Pilih Pengiriman';
  var item = [
    'Pilih Pengiriman',
    'Di Antar Kurir',
    'Di Ambil Sendiri',
  ];

  //END DROPDOWN

  final currentUser = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pesanan Cucian"),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => Nav()));
            },
            icon: Icon(Icons.arrow_back_ios_new)),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 15, right: 20, left: 20),
          child: SingleChildScrollView(
            child: Form(
                key: formKey,
                child: Column(
                  children: [
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("akun")
                            .where("uid",
                                isEqualTo: currentUser.currentUser!.uid)
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, i) {
                                  var data = snapshot.data!.docs[i];

                                  nama.text = data['nama'];
                                  Alamat.text = data['alamat'];
                                  telp.text = data['telepon'];

                                  return SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        //NAMA
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 2),
                                          child: Card(
                                            elevation: 1,
                                            shadowColor: Colors.black,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              side: BorderSide(
                                                color:
                                                    Colors.grey.withOpacity(1),
                                                width: 1,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: TextFormField(
                                                readOnly: true,
                                                style: TextStyle(fontSize: 16),
                                                controller: nama,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  labelText: "Nama Lengkap",
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Nama Harus Diisi';
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                        ),

                                        //ALAMAT
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 2),
                                          child: Card(
                                            elevation: 1,
                                            shadowColor: Colors.black,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              side: BorderSide(
                                                color:
                                                    Colors.grey.withOpacity(1),
                                                width: 1,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: SizedBox(
                                                height: 80,
                                                child: TextFormField(
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                  autofocus: false,
                                                  maxLines: null,
                                                  controller: Alamat,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                    labelText: "Alamat Lengkap",
                                                  ),
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Alamat Harus Diisi';
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                        //TELEPON
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 2),
                                          child: Card(
                                            elevation: 1,
                                            shadowColor: Colors.black,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              side: BorderSide(
                                                color:
                                                    Colors.grey.withOpacity(1),
                                                width: 1,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: TextFormField(
                                                style: TextStyle(fontSize: 16),
                                                controller: telp,
                                                keyboardType:
                                                    TextInputType.number,
                                                autofocus: false,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  labelText:
                                                      "Nomor Telepon/ Whatsapp",
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                        //TANGGAL
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 2),
                                          child: Card(
                                            elevation: 1,
                                            shadowColor: Colors.black,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              side: BorderSide(
                                                color:
                                                    Colors.grey.withOpacity(1),
                                                width: 1,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: TextFormField(
                                                style: TextStyle(fontSize: 16),
                                                readOnly: true,
                                                controller: tgl,
                                                keyboardType:
                                                    TextInputType.datetime,
                                                onTap: () async {
                                                  DateTime date =
                                                      DateTime.now();
                                                  DateTime? picked =
                                                      await showDatePicker(
                                                          context: context,
                                                          initialDate: date,
                                                          firstDate:
                                                              DateTime(2020),
                                                          lastDate:
                                                              DateTime(2025));

                                                  if (date != null) {
                                                    print(date);
                                                    String formattedDate =
                                                        DateFormat('dd-MM-yyyy')
                                                            .format(date);
                                                    print(formattedDate);

                                                    setState(() {
                                                      tgl.text = formattedDate;
                                                    });
                                                  }
                                                },
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  labelText: "Tanggal Order",
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                        //BERAT
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 2),
                                          child: Card(
                                            elevation: 1,
                                            shadowColor: Colors.black,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              side: BorderSide(
                                                color:
                                                    Colors.grey.withOpacity(1),
                                                width: 1,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: TextFormField(
                                                style: TextStyle(fontSize: 16),
                                                autofocus: false,
                                                controller: berat,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  labelText:
                                                      "Berat Cucian 'kg'",
                                                ),
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return 'Berat Cucian Harus Diisi';
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                        ),

                                        //Total
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 2),
                                          child: Card(
                                            elevation: 1,
                                            shadowColor: Colors.black,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              side: BorderSide(
                                                color:
                                                    Colors.grey.withOpacity(1),
                                                width: 1,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: TextFormField(
                                                style: TextStyle(fontSize: 16),
                                                readOnly: true,
                                                controller: total,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  labelText: "Total Bayar",
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 2),
                                          child: Card(
                                            elevation: 1,
                                            shadowColor: Colors.black,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              side: BorderSide(
                                                color:
                                                    Colors.grey.withOpacity(1),
                                                width: 1,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: TextFormField(
                                                style: TextStyle(fontSize: 16),
                                                readOnly: true,
                                                controller: bayar,
                                                keyboardType:
                                                    TextInputType.name,
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  labelText:
                                                      "Pembayaran COD only",
                                                  hintText: "Bayar Ditempat",
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: SizedBox(
                                            height: 40,
                                            width: 140,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.lightBlue,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Total();
                                                  total.text =
                                                      "Rp. ${hasil}.000";
                                                  status.text =
                                                      "Sedang Diproses";
                                                  bayar.text = "Bayar Ditempat";
                                                },
                                                child: Text('Total Bayar')),
                                          ),
                                        ),

                                        //PROSES
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: TextFormField(
                                            readOnly: true,
                                            controller: status,
                                            keyboardType: TextInputType.name,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Colors.red[600],
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15),
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              filled: true,
                                              fillColor: Colors.green,
                                              hintText: "Sedang Diproses",
                                              hintStyle: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Colors.white),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, left: 5, right: 5),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Pengiriman Laundry',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              SizedBox(
                                                width: 170,
                                                child: Card(
                                                  color: Color.fromARGB(
                                                      255, 240, 240, 240),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    side: BorderSide(
                                                      color: Colors.grey
                                                          .withOpacity(1),
                                                      width: 1,
                                                    ),
                                                  ),
                                                  child:
                                                      DropdownButtonHideUnderline(
                                                    child: DropdownButton(
                                                      value: dropdown,
                                                      icon: const Icon(Icons
                                                          .keyboard_arrow_down),
                                                      items: items
                                                          .map((String items) {
                                                        return DropdownMenuItem(
                                                          value: items,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Text(
                                                              items,
                                                              style: TextStyle(
                                                                  fontSize: 15),
                                                            ),
                                                          ),
                                                        );
                                                      }).toList(),
                                                      onChanged:
                                                          (String? data) {
                                                        setState(() {
                                                          dropdown = data!;
                                                          diambil.text = data;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        SizedBox(
                                          height: 5,
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5, left: 5, right: 5),
                                          child: Row(
                                            children: [
                                              Text(
                                                'Jika Pesanan Selesai?',
                                                style: TextStyle(
                                                  fontSize: 15,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              SizedBox(
                                                width: 170,
                                                child: Card(
                                                  color: Color.fromARGB(
                                                      255, 240, 240, 240),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    side: BorderSide(
                                                      color: Colors.grey
                                                          .withOpacity(1),
                                                      width: 1,
                                                    ),
                                                  ),
                                                  child:
                                                      DropdownButtonHideUnderline(
                                                    child: DropdownButton(
                                                      value: dropDown,
                                                      icon: const Icon(Icons
                                                          .keyboard_arrow_down),
                                                      items: item
                                                          .map((String items) {
                                                        return DropdownMenuItem(
                                                          value: items,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Text(
                                                              items,
                                                              style: TextStyle(
                                                                  fontSize: 15),
                                                            ),
                                                          ),
                                                        );
                                                      }).toList(),
                                                      onChanged:
                                                          (String? data) {
                                                        setState(() {
                                                          dropDown = data!;
                                                          selesai.text = data;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        SizedBox(
                                          height: 30,
                                        ),

                                        //IMAGE
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 5),
                                          child: Text(
                                            'Upload Foto Cucian Anda!',
                                            style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.red,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: InkWell(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 240, 240, 240),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  border: Border.all(
                                                      color: Colors.blue)),
                                              child: Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      _showPicker(context);
                                                    },
                                                    child: _photo != null
                                                        ? Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Container(
                                                              child: Image.file(
                                                                _photo!,
                                                                height: 200,
                                                                width: 240,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          )
                                                        : Container(
                                                            width: 150,
                                                            height: 150,
                                                            child: Icon(
                                                              Icons.camera_alt,
                                                              color: Colors
                                                                  .grey[800],
                                                            ),
                                                          ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),

                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: SizedBox(
                                              height: 40,
                                              width: 150,
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: Colors.blue[700],
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    if (formKey.currentState!
                                                        .validate()) {
                                                      final showImage =
                                                          await uploadFile();
                                                      FirebaseFirestore
                                                          firestore =
                                                          FirebaseFirestore
                                                              .instance;
                                                      CollectionReference cust =
                                                          firestore.collection(
                                                              "cust");

                                                      await cust.add({
                                                        "nama": nama.text,
                                                        "alamat": Alamat.text,
                                                        "telepon": telp.text,
                                                        "berat": berat.text,
                                                        "status": status.text,
                                                        "diambil": diambil.text,
                                                        "laundry selesai":
                                                            selesai.text,
                                                        "pembayaran":
                                                            bayar.text,
                                                        "total": total.text,
                                                        "tanggal": tgl.text,
                                                        "gambar": showImage,
                                                        "email": data['email']
                                                      });

                                                      Navigator.of(context).push(
                                                          MaterialPageRoute(
                                                              builder: (_) =>
                                                                  Nav()));
                                                    }

                                                    showDialog(
                                                      context: context,
                                                      builder: (context) =>
                                                          AlertDialog(
                                                        title: Text(
                                                            'Pemberitahuan'),
                                                        content: Container(
                                                          height: 70,
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                'Laundry Telah Tersimpan, Kurir akan mengambil cucian anda.',
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 15,
                                                                ),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    'Cucian akan selesai 2-3 hari',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        actions: [
                                                          ElevatedButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child:
                                                                  Text('Oke'))
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                  child: Text(
                                                    'Simpan Pesanan',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ))),
                                        )
                                      ],
                                    ),
                                  );
                                });
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                )),
          ),
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
