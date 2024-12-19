import 'dart:math';

import 'package:astromaagic/Components/forms.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_waveform/just_waveform.dart';
import 'package:rxdart/rxdart.dart' as rx;
import 'package:rxdart/rxdart.dart';
import 'package:simple_waveform_progressbar/simple_waveform_progressbar.dart';
import '../../Components/theme.dart';

import '../../Controller/GeneralPredictionsController/GeneralPredictionVoiceMessageScreenController.dart';
import 'GeneralPredictionScreenThree.dart';

class PositionData {
  const PositionData(
    this.position,
    this.bufferedPosition,
    this.duration,
  );

  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;
}

class GeneralPredictionVoiceMessageScreen
    extends GetView<GeneralPredictionVoiceMessageController> {
  const GeneralPredictionVoiceMessageScreen({super.key});

  Stream<PositionData> get positionDataStream =>
      rx.Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          controller.audioPlayer.positionStream,
          controller.audioPlayer.bufferedPositionStream,
          controller.audioPlayer.durationStream,
          (position, bufferedPosition, duration) =>
              PositionData(position, bufferedPosition, duration!));

  @override
  Widget build(BuildContext context) {
    final progressStream = BehaviorSubject<WaveformProgress>();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    GeneralPredictionVoiceMessageController controller =
        Get.put(GeneralPredictionVoiceMessageController());
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 55,
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
        title: Text(
          'CHOOSE YOUR PRICE SLOT'.tr,
          maxLines: 2,
          style: TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: 14,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[],
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/images/backgroundImage.png",
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 30, top: 20),
              width: width,
              child: Expanded(
                child: Text(
                  'generalPredictions'.tr,
                  maxLines: 1,
                  style: GoogleFonts.lato(
                    color: AppTheme.containerBackground,
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: 30,
              ),
              width: width,
              child: Expanded(
                child: Text(
                  'solutionText'.tr,
                  maxLines: 1,
                  style: GoogleFonts.lato(
                    color: AppTheme.containerBackground,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      width: width * 0.9,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: AppTheme.primaryColor,
                          ),
                          color: AppTheme.primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'No of questions'.tr,
                                style: GoogleFonts.lato(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Response time'.tr,
                                style: GoogleFonts.lato(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Meeting duration'.tr,
                                style: GoogleFonts.lato(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Fees in INR'.tr,
                                style: GoogleFonts.lato(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Fees in USD'.tr,
                                style: GoogleFonts.lato(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                  width: width * 0.25,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: AppTheme.screenBackground,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: AppTheme.screenBackground,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Full chart',
                                        style: GoogleFonts.lato(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '2 Hrs',
                                        style: GoogleFonts.lato(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        'N/A',
                                        style: GoogleFonts.lato(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '₹ 1000',
                                        style: GoogleFonts.lato(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '\$ 25',
                                        style: GoogleFonts.lato(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15, top: 10),
              width: width,
              height: height * 0.1,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: AppTheme.primaryColor, width: 2)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTapDown: (TapDownDetails details) {
                      controller.startRecord();
                      Fluttertoast.showToast(
                        msg: "Record Starting",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                      );
                    },
                    onTapUp: (TapUpDetails details) {
                      controller.stopRecord();
                      controller.isAudio.value = true;
                      Fluttertoast.showToast(
                        msg: "Record Stop",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.05,
                        width: MediaQuery.of(context).size.width * 0.1,
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.mic,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Obx(
              () => Visibility(
                visible: controller.isAudio.value,
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 100,
                      height: 60,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        //color: AppTheme.primaryColor,
                      ),
                      child: Row(
                        children: [
                          //SizedBox(width: 20),
                          StreamBuilder<PlayerState>(
                              stream: controller.audioPlayer.playerStateStream,
                              builder: (context, snapshot) {
                                final playerState = snapshot.data;
                                final processingState =
                                    playerState?.processingState;
                                final playing = playerState?.playing;
                                if (!(playing ?? false)) {
                                  return IconButton(
                                      onPressed: () {
                                        controller.play();
                                      },
                                      icon: Icon(
                                        Icons.play_arrow_rounded,
                                        size: 30,
                                        color: AppTheme.white,
                                      ));
                                } else if (processingState !=
                                    ProcessingState.completed) {
                                  return IconButton(
                                      onPressed: controller.audioPlayer.pause,
                                      icon: Icon(Icons.pause_rounded,
                                          size: 30, color: AppTheme.white));
                                }
                                return Icon(Icons.play_arrow_rounded,
                                    color: AppTheme.white);
                              }),
                          SizedBox(
                            width: 30,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 15),
                            width: 180,
                            child: StreamBuilder(
                                stream: positionDataStream,
                                builder: (context, snapshot) {
                                  final positionData = snapshot.data;
                                  //if (snapshot.hasError) {
                                  //   return Center(
                                  //     child: Text(
                                  //       'Error: ${snapshot.error}',
                                  //       style: Theme.of(context).textTheme.titleLarge,
                                  //       textAlign: TextAlign.center,
                                  //     ),
                                  //   );
                                  // }
                                  // final progress = snapshot.data?.progress ?? 0.0;
                                  // final waveform = snapshot.data?.waveform;
                                  // if (waveform == null) {
                                  //   return Center(
                                  //     child: Text(
                                  //       '${(100 * progress).toInt()}%',
                                  //       style: Theme.of(context).textTheme.titleLarge,
                                  //     ),
                                  //   );
                                  // }
                                  // return AudioWaveformWidget(
                                  //   waveform: waveform,
                                  //   start: Duration.zero,
                                  //   duration: waveform.duration,
                                  // );

                                  return ProgressBar(
                                    barCapShape: BarCapShape.square,
                                    progressBarColor: AppTheme.primaryColor,
                                    bufferedBarColor: AppTheme.white,
                                    progress:
                                        positionData?.position ?? Duration.zero,
                                    buffered: positionData?.bufferedPosition ??
                                        Duration.zero,
                                    thumbColor: AppTheme.primaryColor,
                                    thumbRadius: 7,
                                    total:
                                        positionData?.duration ?? Duration.zero,
                                    onSeek: controller.audioPlayer.seek,
                                    timeLabelTextStyle:
                                        TextStyle(color: AppTheme.primaryColor),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Button(
                      widthFactor: 0.85,
                      heightFactor: 0.06,
                      onPressed: () {
                        Get.to(GeneralPredictionScreenThree());
                      },
                      child: Text("continue".tr,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ))),
                ),
              ],
            ),
            // SingleChildScrollView(
            //   child: Container(
            //     width: width,
            //     height: height - 225,
            //     child: ListView.builder(
            //       itemCount: 5,
            //       itemBuilder: (context, index) {
            //         return travelList(context, index);
            //       },
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  Widget travelList(BuildContext context, int index) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Container(
              width: width * 0.9,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: AppTheme.primaryColor,
                  ),
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'No of questions',
                        style: GoogleFonts.lato(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Response time',
                        style: GoogleFonts.lato(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Meeting duration',
                        style: GoogleFonts.lato(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Fees in INR',
                        style: GoogleFonts.lato(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Fees in USD',
                        style: GoogleFonts.lato(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                          width: width * 0.35,
                          margin:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            color: AppTheme.screenBackground,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: AppTheme.screenBackground,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Full chart',
                                style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                '2 Hrs',
                                style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'N/A',
                                style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                '₹ 1000',
                                style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                '\$ 25',
                                style: GoogleFonts.lato(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ))
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}

class AudioWaveformWidget extends StatefulWidget {
  final Color waveColor;
  final double scale;
  final double strokeWidth;
  final double pixelsPerStep;
  final Waveform waveform;
  final Duration start;
  final Duration duration;

  const AudioWaveformWidget({
    Key? key,
    required this.waveform,
    required this.start,
    required this.duration,
    this.waveColor = Colors.blue,
    this.scale = 1.0,
    this.strokeWidth = 5.0,
    this.pixelsPerStep = 8.0,
  }) : super(key: key);

  @override
  _AudioWaveformState createState() => _AudioWaveformState();
}

class _AudioWaveformState extends State<AudioWaveformWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: CustomPaint(
        painter: AudioWaveformPainter(
          waveColor: widget.waveColor,
          waveform: widget.waveform,
          start: widget.start,
          duration: widget.duration,
          scale: widget.scale,
          strokeWidth: widget.strokeWidth,
          pixelsPerStep: widget.pixelsPerStep,
        ),
      ),
    );
  }
}

class AudioWaveformPainter extends CustomPainter {
  final double scale;
  final double strokeWidth;
  final double pixelsPerStep;
  final Paint wavePaint;
  final Waveform waveform;
  final Duration start;
  final Duration duration;

  AudioWaveformPainter({
    required this.waveform,
    required this.start,
    required this.duration,
    Color waveColor = Colors.blue,
    this.scale = 1.0,
    this.strokeWidth = 5.0,
    this.pixelsPerStep = 8.0,
  }) : wavePaint = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round
          ..color = waveColor;

  @override
  void paint(Canvas canvas, Size size) {
    if (duration == Duration.zero) return;

    double width = size.width;
    double height = size.height;

    final waveformPixelsPerWindow = waveform.positionToPixel(duration).toInt();
    final waveformPixelsPerDevicePixel = waveformPixelsPerWindow / width;
    final waveformPixelsPerStep = waveformPixelsPerDevicePixel * pixelsPerStep;
    final sampleOffset = waveform.positionToPixel(start);
    final sampleStart = -sampleOffset % waveformPixelsPerStep;
    for (var i = sampleStart.toDouble();
        i <= waveformPixelsPerWindow + 1.0;
        i += waveformPixelsPerStep) {
      final sampleIdx = (sampleOffset + i).toInt();
      final x = i / waveformPixelsPerDevicePixel;
      final minY = normalise(waveform.getPixelMin(sampleIdx), height);
      final maxY = normalise(waveform.getPixelMax(sampleIdx), height);
      canvas.drawLine(
        Offset(x + strokeWidth / 2, max(strokeWidth * 0.75, minY)),
        Offset(x + strokeWidth / 2, min(height - strokeWidth * 0.75, maxY)),
        wavePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant AudioWaveformPainter oldDelegate) {
    return false;
  }

  double normalise(int s, double height) {
    if (waveform.flags == 0) {
      final y = 32768 + (scale * s).clamp(-32768.0, 32767.0).toDouble();
      return height - 1 - y * height / 65536;
    } else {
      final y = 128 + (scale * s).clamp(-128.0, 127.0).toDouble();
      return height - 1 - y * height / 256;
    }
  }
}
