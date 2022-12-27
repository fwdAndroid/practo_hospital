import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';

class UploadFiles extends StatefulWidget {
  const UploadFiles({super.key});

  @override
  State<UploadFiles> createState() => _UploadFilesState();
}

class _UploadFilesState extends State<UploadFiles> {
  Map<int, double> downloadProgress = {};
  PlatformFile? platformFile;
  File? file;
  UploadTask? uploadTask;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (platformFile != null)
            Expanded(
              child: Stack(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Center(
                      child: Image.file(
                    File(platformFile!.path!),
                    width: 100,
                    fit: BoxFit.cover,
                    height: 30,
                  )),
                ],
              ),
            ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(fixedSize: Size(300, 40)),
            onPressed: upload,
            child: Text("Upload Files"),
          ),
          buildProgress(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(fixedSize: Size(300, 40)),
            onPressed: selectFiles,
            child: Text("Select Files"),
          ),
        ],
      ),
    );
  }

  void upload() async {
    final path = 'files/${platformFile!.name}';
    final file = File(platformFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);
    setState(() {
      uploadTask = ref.putFile(file);
    });

    final snapshot = await uploadTask!.whenComplete(() {});
    final downloadUrl = await snapshot.ref.getDownloadURL();
    print(downloadUrl);
    setState(() {
      uploadTask = null;
    });
  }

  void selectFiles() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;
    setState(() {
      platformFile = result.files.first;
    });
  }

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
      stream: uploadTask?.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data!;
          double progress = data.bytesTransferred / data.totalBytes;
          return SizedBox(
            height: 20,
            child: Stack(
              children: [
                CircularProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.green,
                ),
                Center(
                  child: Text(
                    '${(100 * progress).roundToDouble()}%',
                    style: TextStyle(color: Colors.red),
                  ),
                )
              ],
            ),
          );
        } else {
          return SizedBox(
            height: 10,
          );
        }
      });
 
    // void downloadFile(Reference ref) async {
    //   final url = await ref.getDownloadURL();
    //   final tempDir = await getTemporaryDirectory();
    //   final path = '${tempDir.path}/${ref.name}';
    //   await Dio().download(
    //     url,
    //     path,
    //     onReceiveProgress: (count, total) {
    //       double progress = count / total;
    //       setState(() {
    //         downloadProgress[index] = progress;
    //       });
    //     },
    //   );

    //   if (url.contains('.mp4')) {
    //     await GallerySaver.saveVideo(path, toDcim: true);
    //   } else if (url.contains('.jpg')) {
    //     await GallerySaver.saveImage(path, toDcim: true);
    //   }
    // }
  
}
