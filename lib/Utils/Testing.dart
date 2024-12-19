import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Testing extends StatefulWidget {
  const Testing({super.key});

  @override
  State<Testing> createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  final List local = [
    {'name': 'ENGLISH', 'locale': Locale('en', 'US')},
    {'name': 'தமிழ்', 'locale': Locale('ta', 'IN')}, // Tamil (India)
    // {'name': 'ಕನ್ನಡ', 'locale': Locale('kn', 'IN')}, // Kannada (India)
  ];

  updateLanguage(Locale locale) {
    Get.back();
    Get.updateLocale(locale);
  }

  showLanguage(BuildContext context) {
    showDialog(
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: Text('Choose'),
            content: Container(
              width: double.maxFinite,
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: local.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        print("VALUES:${local[index]['locale']}");
                        updateLanguage(local[index]['locale']);
                      },
                      child: Text(local[index]['name']));
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    color: Colors.blue,
                  );
                },
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tested'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'hello'.tr,
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'message'.tr,
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              onPressed: () {
                showLanguage(context);
              },
              child: Text(
                'ON TAP',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
    );
  }
}
