import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../../Api_Connect/ApiConnect.dart';
import '../../Provider/MenuDataProvider.dart';
import '../../ResponseModel/GetUserServiceResponse.dart';
import '../../ResponseModel/GetViewPdfResponse.dart';
import '../../UI/VastuConsulting/pdf_viewer_page.dart';
import '../../Utils/AppPreference.dart';

class GetPdfViewController extends GetxController {
  late MenuDataProvider userDataProvider;
  ApiConnect _connect = Get.put(ApiConnect());
  RxBool isLoading = RxBool(false);
  RxList<UserServiceData> servicesData = RxList();
  RxInt selectedIndex = RxInt(0);
  //RxList<GetViewPdfResponseData> getViewPdfData = RxList();
  GetViewPdfResponseData getViewPdfData = GetViewPdfResponseData();
  final Rx<File?> pdfFile = Rx<File?>(null);


  @override
  void onInit() {
    userDataProvider =
        Provider.of<MenuDataProvider>(Get.context!, listen: false);
    //getUserServices();
    //getViewPdf();
    super.onInit();
  }

  getUserServices() async {
    Map<String, dynamic> payload = {
      'loginUserId': AppPreference().getLoginUserId.toString(),

    };
    isLoading.value = true;
    print("getUserServicesPayload:$payload");
    var response = await _connect.getUserServicesCall(payload);
    debugPrint("getUserServicesResponse: ${response.toJson()}");
    if (!response.error!) {
      servicesData.value = response.data!;
      isLoading.value = false;
    } else {}
  }
  getViewPdf(String url) async {
    Map<String, dynamic> payload = {
      'loginUserId': AppPreference().getLoginUserId.toString(),
      'remedyId':  userDataProvider.getUserServicesData!.remedyId.toString(),
    };
    isLoading.value = true;
    print("getPdfViewPayload:$payload");
    var response = await _connect.getViewPdfCall(payload);
    debugPrint("getPdfViewResponse: ${response.toJson()}");
    if (!response.error!) {
      getViewPdfData = response.data!;


      isLoading.value = false;

    } else {}
  }

  // Future<void> loadPdf(String url) async {
  //   try {
  //     final response = await http.get(Uri.parse(url));
  //     if (response.statusCode == 200) {
  //       Directory tempDir = await getTemporaryDirectory();
  //       String tempPath = tempDir.path;
  //       String fileName = url.split('/').last;
  //       String filePath = '$tempPath/$fileName';
  //       File file = File(filePath);
  //       await file.writeAsBytes(response.bodyBytes);
  //       pdfFile.value = file;
  //       isLoading.value = false;
  //     } else {
  //       throw Exception('Failed to download file');
  //     }
  //   } catch (e) {
  //     print('Error loading PDF: $e');
  //     isLoading.value = false;
  //   }
  // }

  Future<File> loadPdfFromNetwork(String url) async {
    final response = await http.post(Uri.parse(url));
    final bytes = response.bodyBytes;
    return _storeFile(url, bytes);
  }

  Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    if (kDebugMode) {
      print('$file');
    }
    return file;
  }
  Future<File> getPdfFile(String pdfData) async {
    // Get the temporary directory path
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    // Create a temporary file
    File pdfFile = File('$tempPath/temp.pdf');

    // Write the PDF data to the file
    await pdfFile.writeAsBytes(Uint8List.fromList(pdfData.codeUnits));

    return pdfFile;
  }
  // void openPdf(BuildContext context, File file, String url) {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (context) => PdfViewerPage(
  //         file: file,
  //         url: url,
  //       ),
  //     ),
  //   );
 // }
}
