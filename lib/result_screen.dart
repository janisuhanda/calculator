import 'dart:convert';

import 'package:flutter/material.dart';

import 'file_storage.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key, required this.text, required this.storage});
  final String text;
  final FileStorage storage;

  @override
  Widget build(BuildContext context) {
    List datanya = text.split("");
    String calculator = "";
    String hasil = "";
    if (datanya.length > 2) {
      calculator = datanya[0] + datanya[1] + datanya[2];
      if (datanya[1] == "+") {
        hasil = (int.parse(datanya[0]) + int.parse(datanya[2])).toString();
        // print(int.parse(datanya[0]) + int.parse(datanya[2]));
      } else if (datanya[1] == "-") {
        hasil = (int.parse(datanya[0]) - int.parse(datanya[2])).toString();
        // print(int.parse(datanya[0]) - int.parse(datanya[2]));
      } else if (datanya[1] == "x") {
        hasil = (int.parse(datanya[0]) * int.parse(datanya[2])).toString();
        // print(int.parse(datanya[0]) * int.parse(datanya[2]));
      } else if (datanya[1] == "/") {
        hasil = (int.parse(datanya[0]) / int.parse(datanya[2])).toString();
        // print(int.parse(datanya[0]) / int.parse(datanya[2]));
      } else {
        hasil = "no defined";
        // print("no defined");
      }
      // cek file
      storage.cekFile().then((value) {
        //read file value true jika ada file nya
        if (value) {
          storage.readResult().then((data) {
            var wow = jsonDecode(data.toString());
            List datanya = [
              {"data": calculator, "hasil": hasil}
            ];
            // tambah list data
            datanya.addAll(wow);
            var result = jsonEncode(datanya);
            storage.writeResult(result);
          });
        } else {
          List datanya = [
            {"data": calculator, "hasil": hasil}
          ];
          var result = jsonEncode(datanya);
          storage.writeResult(result);
        }
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Result'),
      ),
      body: Column(
        children: [
          // Container(
          //   padding: const EdgeInsets.all(30.0),
          //   child: Text("${text}"),
          // ),
          Container(
            padding: const EdgeInsets.all(30.0),
            child: Text("calculator : ${calculator} = ${hasil}"),
          ),
          // ElevatedButton(
          //     onPressed: () {
          //       print(datanya.toString());
          //       if (datanya[1] == "+") {
          //         print(int.parse(datanya[0]) + int.parse(datanya[2]));
          //       } else if (datanya[1] == "-") {
          //         print(int.parse(datanya[0]) - int.parse(datanya[2]));
          //       } else if (datanya[1] == "x") {
          //         print(int.parse(datanya[0]) * int.parse(datanya[2]));
          //       } else if (datanya[1] == "/") {
          //         print(int.parse(datanya[0]) / int.parse(datanya[2]));
          //       } else {
          //         print("no defined");
          //       }
          //     },
          //     child: Text("test")),
        ],
      ),
    );
  }
}
