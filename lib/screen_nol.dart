import 'package:flutter/material.dart';
import 'package:flutter_text_recognition/cek/cek_page.dart';
import 'package:flutter_text_recognition/screen_file.dart';
import 'screen_camera.dart';

class ScreenNol extends StatelessWidget {
  const ScreenNol({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                  child: ListView.builder(
                itemCount: 20,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text("input :"),
                      subtitle: Text("result :"),
                    ),
                  );
                },
              )),
              ElevatedButton(
                  onPressed: () => showDialog(
                        context: context,
                        builder: (BuildContext context) => Dialog(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CameraScreen(),
                                        ));
                                  },
                                  child: Text("Camera")),
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => FileScreen(),
                                        ));
                                  },
                                  child: Text("Gallery")),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Close'),
                              ),
                            ],
                          ),
                        ),
                      ),
                  child: Text("Add input")),
              // ElevatedButton(
              //     onPressed: () {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) => CekPage(),
              //           ));
              //     },
              //     child: Text("CekPage")),
              StorageOption(),
            ],
          ),
        ),
      ),
    );
  }
}

enum Storageoption { filestorage, databasetorage }

class StorageOption extends StatefulWidget {
  const StorageOption({super.key});

  @override
  State<StorageOption> createState() => _StorageOptionState();
}

class _StorageOptionState extends State<StorageOption> {
  Storageoption? _storeoption = Storageoption.filestorage;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text("Use file storage"),
          trailing: Radio<Storageoption>(
              value: Storageoption.filestorage,
              groupValue: _storeoption,
              onChanged: (value) {
                setState(() {
                  _storeoption = value;
                });
              }),
        ),
        ListTile(
          title: Text("Use Database storage"),
          trailing: Radio<Storageoption>(
              value: Storageoption.databasetorage,
              groupValue: _storeoption,
              onChanged: (value) {
                setState(() {
                  _storeoption = value;
                });
              }),
        ),
      ],
    );
  }
}
