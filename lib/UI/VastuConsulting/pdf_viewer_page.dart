import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import '../../Components/theme.dart';

var dio = Dio();

class PdfViewerPage extends StatefulWidget {
  final File file;
  final String url;

  const PdfViewerPage({
    Key? key,
    required this.file,
    required this.url,
  }) : super(key: key);

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  late String _localPath;
  late bool _permissionReady;
  late TargetPlatform? platform;
  bool isDownloading = false;

  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) {
      platform = TargetPlatform.android;
    } else {
      platform = TargetPlatform.iOS;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    //  FlutterDownloader.initialize();
    //   GetPdfViewController controller = Get.put(GetPdfViewController());

    final name = basename(widget.file.path);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "PDF View",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: AppTheme.screenBackground,
          leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.keyboard_arrow_left,
              color: Colors.white,
              size: 30,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                Fluttertoast.showToast(
                  msg: "Sharing  PDF",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                );
                // Share the PDF file
                await Share.shareXFiles([XFile(widget.file.path)]);
              },
              icon: const Icon(
                Icons.share,
                color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () async {
                if (isDownloading == true) {
                  return;
                }

                _permissionReady = await _checkPermission();
                print(_permissionReady);
                if (_permissionReady) {
                  await _prepareSaveDir();
                  print("Downloading");
                  Fluttertoast.showToast(
                    msg: "Downloading...",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                  );
                  isDownloading = true;
                  try {
                    var uniq = DateTime.now().second.toString();
                    await Dio().download(widget.url,
                        _localPath + "/" + "AstroMaagic" + uniq + ".pdf");
                    isDownloading = false;
                    print("Download Completed.");
                    Fluttertoast.showToast(
                      msg: "Download Complete",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                    );
                  } catch (e) {
                    isDownloading = false;
                    Fluttertoast.showToast(
                      msg: "Download Failed.",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.black,
                      textColor: Colors.white,
                    );
                    print("Download Failed.\n\n" + e.toString());
                  }
                }

                //  downloadPDF();

                // await saveFile(widget.url, "sample.pdf");
                // ScaffoldMessenger.of(context).showSnackBar(
                //   const SnackBar(
                //     content: Text(
                //       'successfully saved to internal storage "PDF_Download" folder',
                //       style: TextStyle(color: Colors.white),
                //     ),
                //   ),
                // );

                // final path =
                //    ExternalPath.getExternalStoragePublicDirectory(
                //        ExternalPath.DIRECTORY_DOWNLOADS);
                //
                //    //String fullPath = tempDir.path + "/boo2.pdf'";
                //    String fullPath = "$path/test.pdf";
                //    print('full path ${fullPath}');
              },
              icon: const Icon(
                Icons.download_rounded,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: PDFView(
          filePath: widget.file.path,
        ),
      ),
    );
  }

  Future<bool> saveFile(String url, String fileName) async {
    try {
      if (await _requestPermission(Permission.storage)) {
        Directory? directory;
        directory = await getExternalStorageDirectory();
        String newPath = "";
        List<String> paths = directory!.path.split("/");
        for (int x = 1; x < paths.length; x++) {
          String folder = paths[x];
          if (folder != "Android") {
            newPath += "/" + folder;
          } else {
            break;
          }
        }
        newPath = newPath + "/PDF_Download";
        directory = Directory(newPath);

        File saveFile = File(directory.path + "/$fileName");
        if (kDebugMode) {
          print(saveFile.path);
        }
        if (!await directory.exists()) {
          await directory.create(recursive: true);
        }
        if (await directory.exists()) {
          await Dio().download(
            url,
            saveFile.path,
          );
        }
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  Future<bool> _checkPermission() async {
    print("Status1");
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      var release = androidInfo.version.release;

      if (int.parse(release) >= 10) {
        return true;
      }

      print("Status2");
      final status = await Permission.storage.status;
      print("Status3");
      if (status != PermissionStatus.granted) {
        print("Status4");
        final result = await Permission.storage.request();
        print("Status5");
        if (result == PermissionStatus.granted) {
          print("Status6");

          return true;
        }
      } else {
        print("Status7");
        return true;
      }
    } else {
      print("Status8");
      return true;
    }
    print("Status9");
    return false;
  }

  Future<void> _prepareSaveDir() async {
    _localPath = (await _findLocalPath())!;

    print(_localPath);
    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  Future<String?> _findLocalPath() async {
    if (platform == TargetPlatform.android) {
      return "/storage/emulated/0/Download";
    } else {
      var directory = await getApplicationDocumentsDirectory();
      return directory.path + Platform.pathSeparator + 'Download';
    }
  }
}
