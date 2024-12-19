import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record_mp3/record_mp3.dart';

class VoiceMessageViewController extends GetxController {

  int i = 0;
  RxString? recordFilePath = RxString("");
  late AudioPlayer audioPlayer;
  late final RecorderController recorderController;
  RxString? path= RxString("");
  RxString? musicFile = RxString("");
  RxBool isLoading =  RxBool(false);
  RxBool isRecording =  RxBool(false);
  RxBool isRecordingCompleted =  RxBool(false);

  late Directory appDirectory;



  void getDir() async {
    appDirectory = await getApplicationDocumentsDirectory();
    path!.value = "${appDirectory.path}/recording.m4a";
    isLoading.value = false;

  }

  void initialiseControllers() {
    recorderController = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 44100;
  }

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      musicFile!.value = result.files.single.path!;

    } else {
      debugPrint("File not picked");
    }
  }

  @override
  void dispose() {
    recorderController.dispose();
    super.dispose();
  }




  @override
  void onInit() async {
    super.onInit();
    audioPlayer = AudioPlayer();
    getDir();
    recorderController = RecorderController()
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 44100;
  }

  Future<bool> checkPermission() async {
    Map<Permission, PermissionStatus> permissions =
    await [Permission.storage, Permission.microphone].request();
    print(permissions[Permission.microphone]);
    return permissions[Permission.microphone] == PermissionStatus.granted;
  }

  Future<String> getFilePath() async {
    Directory storageDirectory = await getApplicationDocumentsDirectory();
    String sdPath = storageDirectory.path + "/record";
    var d = Directory(sdPath);
    if (!d.existsSync()) {
      d.createSync(recursive: true);
    }
    return "$sdPath/test_${i++}.mp3";
  }

  void startRecord() async {
    audioPlayer = AudioPlayer();

    bool hasPermission = await checkPermission();
    if (hasPermission) {
      if (recordFilePath != null && File(recordFilePath!.value).existsSync()) {
        File(recordFilePath!.value).deleteSync();
        print("record1$recordFilePath");
      }



      recordFilePath!.value = await getFilePath();
      print("record2$recordFilePath");

      RecordMp3.instance.start(recordFilePath!.value, (type) {});

    } else {}
  }



  void stopRecord() {
    bool s = RecordMp3.instance.stop();
    if (s) {

    }
  }

  void play() {
    if (recordFilePath != null && File(recordFilePath!.value).existsSync()) {
      audioPlayer.setFilePath(recordFilePath!.value);
      audioPlayer.play();
    }
  }

  void resumeRecord() {
    bool s = RecordMp3.instance.resume();
    if (s) {}
  }

  void pauseRecord() {
    if (RecordMp3.instance.status == RecordStatus.PAUSE) {
      bool s = RecordMp3.instance.resume();
      if (s) {}
    } else {
      bool s = RecordMp3.instance.pause();
      if (s) {}
    }
  }
  void startOrStopRecording() async {
    try {
      if (isRecording.value) {
        recorderController.reset();
        path!.value = (await recorderController.stop(false))!;
        if (path != null) {
          isRecordingCompleted. value = true;
          debugPrint(path!.value);
          debugPrint("Recorded file size: ${File(path!.value).lengthSync()}");
        }
      } else {
        await recorderController.record(path: path!.value); // Path is optional
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isRecording.value = !isRecording.value;

    }
  }

  void refreshWave() {
    if (isRecording.value) recorderController.refresh();
  }
}
