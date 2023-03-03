import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  final String email;
  const Home({super.key, required this.email});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final name = TextEditingController();
  final nik = TextEditingController();
  final position = TextEditingController();

  @override
  List dataKaryawan = [];
  void getEmployee() async {
    Dio dio = Dio();
    var url = "https://63a167d8a543280f775561e5.mockapi.io/flutter";
    dio.options.headers['content-Type'] = 'application/json';

    final response = await dio.get(
      url,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    if (response.data['message'] == 200) {
      setState(() {
        dataKaryawan = response.data['data'];
      });
    } else {
      print('gagal');
    }
  }

  void addEmployee() async {
    Dio dio = Dio();
    var url = "https://63a167d8a543280f775561e5.mockapi.io/flutter";
    dio.options.headers['content-Type'] = 'application/json';

    final response = await dio.post(
      url,
      queryParameters: {
        "name": name.text,
        "nik": nik.text,
        "position": position.text
      },
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    if (response.data['status'] == 200) {
      Get.snackbar('Berhasil', 'Berhasil menambahkan Karyawan');
    } else {
      Get.snackbar('Gagal', 'Gagal menambahkan Karyawan');
    }
  }

  void initState() {
    // TODO: implement initState
    getEmployee();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          Text('Hi ..' + widget.email),
          SizedBox(
            height: 10,
          ),
          Column(
            children: List.generate(dataKaryawan.length, (index) {
              return Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text((index + 1).toString() + '. '),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('Nama : '),
                              Text(dataKaryawan[index]['name']),
                            ],
                          ),
                          Row(
                            children: [
                              Text('NIK : '),
                              Text(dataKaryawan[index]['nik']),
                            ],
                          ),
                          Row(
                            children: [
                              Text('Position : '),
                              Text(dataKaryawan[index]['position']),
                            ],
                          ),
                          Container(
                            child: Text('Lihat Detail'),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              );
            }),
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name :'),
              TextField(
                controller: name,
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('NIK :'),
              TextField(
                controller: nik,
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Position :'),
              TextField(
                controller: position,
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              addEmployee();
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              color: Colors.blue,
              child: Text(
                'Add Karyawan',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
