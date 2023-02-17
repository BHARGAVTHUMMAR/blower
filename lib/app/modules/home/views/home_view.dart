import 'package:blower/constants/ad_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sound_generator/sound_generator.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import '../../../../constants/sizeConstant.dart';
import '../../../../main.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetWidget<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MySize().init(context);
    return Obx(() {
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(MySize.getHeight(10)),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius:
                          BorderRadius.circular(MySize.getHeight(12))),
                  height: MySize.getHeight(400),
                  width: MySize.getWidth(400),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: MySize.getHeight(15)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Spacer(),
                              Text("Candle Blower",
                                  style: GoogleFonts.lemon(
                                      textStyle: TextStyle(
                                          color: Colors.grey.shade50,
                                          fontWeight: FontWeight.w400,
                                          fontSize: MySize.getHeight(25)))),
                              SizedBox(
                                width: 30,
                              ),
                              InkWell(
                                onTap: () {
                                  Share.share(
                                      'check out my app https://play.google.com/store/apps/details?id=com.mobilexperts.candle.blower');
                                },
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      right: MySize.getWidth(20)),
                                  child: Image.asset(
                                    "assets/share.png",
                                    height: 20,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Container(
                              height: MySize.getHeight(285),
                              width: MySize.getWidth(400),
                              child: SfRadialGauge(
                                enableLoadingAnimation: false,
                                axes: <RadialAxis>[
                                  RadialAxis(
                                      minimum: 0,
                                      maximum: 150,
                                      interval: 20,
                                      minorTicksPerInterval: 9,
                                      showAxisLine: false,
                                      showTicks: false,
                                      showLabels: false,
                                      radiusFactor: 0.8,
                                      labelOffset: 8,
                                      ranges: <GaugeRange>[
                                        GaugeRange(
                                            startValue: 0,
                                            endValue: 30,
                                            startWidth: 0.265,
                                            sizeUnit: GaugeSizeUnit.factor,
                                            endWidth: 0.265,
                                            color: const Color.fromRGBO(
                                                52, 193, 119, 1)),
                                        GaugeRange(
                                            startValue: 30,
                                            endValue: 60,
                                            startWidth: 0.265,
                                            sizeUnit: GaugeSizeUnit.factor,
                                            endWidth: 0.265,
                                            color: const Color.fromRGBO(
                                                37, 160, 139, 1)),
                                        GaugeRange(
                                            startValue: 60,
                                            endValue: 90,
                                            startWidth: 0.265,
                                            sizeUnit: GaugeSizeUnit.factor,
                                            endWidth: 0.265,
                                            color: const Color.fromRGBO(
                                                253, 197, 10, 1)),
                                        GaugeRange(
                                            startValue: 90,
                                            endValue: 120,
                                            startWidth: 0.265,
                                            sizeUnit: GaugeSizeUnit.factor,
                                            endWidth: 0.265,
                                            color: const Color.fromRGBO(
                                                250, 112, 78, 1)),
                                        GaugeRange(
                                            startValue: 120,
                                            endValue: 150,
                                            startWidth: 0.265,
                                            sizeUnit: GaugeSizeUnit.factor,
                                            endWidth: 0.265,
                                            color: const Color.fromRGBO(
                                                217, 53, 81, 1)),
                                      ],
                                      pointers: <GaugePointer>[
                                        NeedlePointer(
                                          value: (controller.on_Off.isTrue)
                                              ? controller.slider.value
                                              : 0,
                                          needleStartWidth: 0,
                                          needleEndWidth: 5,
                                          animationType:
                                              AnimationType.easeOutBack,
                                          enableAnimation: true,
                                          animationDuration: 3000,
                                          knobStyle: KnobStyle(
                                              knobRadius: 0.06,
                                              borderColor: Color(0xFFFF2E2E),
                                              color: Colors.white,
                                              borderWidth: 0.035),
                                          tailStyle: TailStyle(
                                              color: Color(0xFFFF2E2E),
                                              width: 4,
                                              length: 0.15),
                                          needleColor: Color(0xFFFF2E2E),
                                        )
                                      ],
                                      axisLabelStyle:
                                          GaugeTextStyle(fontSize: 10),
                                      majorTickStyle: const MajorTickStyle(
                                          length: 0.25,
                                          lengthUnit: GaugeSizeUnit.factor),
                                      minorTickStyle: const MinorTickStyle(
                                          length: 0.13,
                                          lengthUnit: GaugeSizeUnit.factor,
                                          thickness: 1))
                                ],
                              ),
                            ),
                            Positioned(
                              child: GestureDetector(
                                onTap: () async {
                                  controller.on_Off.value =
                                      !controller.on_Off.value;
                                  controller.speed.value = 1000;
                                  controller.isTap.value =
                                      !controller.isTap.value;
                                  if (controller.on_Off.isTrue) {
                                    controller.isRotate.value = true;
                                  }
                                  if (controller.on_Off.isTrue) {
                                    if (controller.isRotate.isTrue) {
                                      if (kDebugMode) {
                                        controller.startAnimation();
                                      } else {
                                        await controller.ads().then(
                                          (value) {
                                            controller.startAnimation();
                                          },
                                        );
                                      }
                                    }
                                  } else {
                                    controller.disposeAnimation();
                                  }

                                  controller.slider.value = 75;
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(60),
                                      border: Border.all(
                                          color: Colors.grey.shade50)),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    radius: MySize.getHeight(35),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.all(MySize.getHeight(3)),
                                      child: (controller.on_Off.isFalse)
                                          ? Image.asset(
                                              "assets/switch_green.png")
                                          : Image.asset(
                                              "assets/switch_red.png"),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: MySize.getHeight(10),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (controller.slider.value > 3) {
                                      controller.slider.value =
                                          controller.slider.value - 5;
                                      if (controller.on_Off.isTrue) {
                                        if (controller.speed.value < 1600) {
                                          controller.speed.value =
                                              controller.speed.value + 50;
                                        }
                                        Future.delayed(Duration(seconds: 3))
                                            .then((value) {
                                          controller.startAnimation();
                                        });
                                      }
                                      if (controller.frequency.value > 1.0) {
                                        controller.frequency.value =
                                            controller.frequency.value - 30;
                                        SoundGenerator.setFrequency(
                                            controller.frequency.value);
                                      }
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(
                                            MySize.getHeight(62))),
                                    height: MySize.getHeight(46),
                                    width: MySize.getWidth(140),
                                    child: Center(
                                      child: Text("Low",
                                          style: GoogleFonts.lemon(
                                              textStyle: TextStyle(
                                                  color: Colors.grey.shade50,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize:
                                                      MySize.getHeight(20)))),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 25),
                                GestureDetector(
                                  onTap: () {
                                    if (controller.slider.value < 150) {
                                      controller.slider.value =
                                          controller.slider.value + 5;
                                      controller.frequency.value =
                                          controller.frequency.value + 30.0;
                                      if (controller.on_Off.isTrue) {
                                        if (controller.speed.value > 200) {
                                          controller.speed.value =
                                              controller.speed.value - 50;
                                        }
                                        Future.delayed(Duration(seconds: 3))
                                            .then((value) {
                                          controller.startAnimation();
                                        });
                                      }
                                      SoundGenerator.setFrequency(
                                          controller.frequency.value);
                                    } else {
                                      if (kDebugMode) {
                                        controller.ads();
                                      }
                                      SoundGenerator.stop();
                                    }
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(
                                            MySize.getHeight(62))),
                                    height: MySize.getHeight(46),
                                    width: MySize.getWidth(140),
                                    child: Center(
                                      child: Text("Boost",
                                          style: GoogleFonts.lemon(
                                              textStyle: TextStyle(
                                                  color: Colors.grey.shade50,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize:
                                                      MySize.getHeight(20)))),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ]),
                ),
              ),
              getIt<AdService>().getBanners(),
              Spacer(),
              (controller.on_Off.isTrue)
                  ? Container(
                      height: MySize.getHeight(300),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            "assets/fan_holder.png",
                            color: Color(0xff252B40),
                            height: MySize.getHeight(350),
                          ),
                          if (controller.isRotate.isTrue)
                            Positioned(
                              child: RotationTransition(
                                turns: Tween(begin: 0.0, end: 1.0).animate(
                                    controller.animationController!.value),
                                child: Image.asset(
                                  "assets/FAN_Main.png",
                                  height: MySize.getHeight(220),
                                ),
                              ),
                            ),
                          if (controller.isRotate.isTrue)
                            Positioned(
                              bottom: 6,
                              right: 35,
                              child: Image.asset(
                                "assets/arrow.gif",
                                height: MySize.getHeight(50),
                                width: MySize.getWidth(50),
                              ),
                            )
                        ],
                      ),
                    )
                  : (controller.isAnimationInit.isTrue)
                      ? Container(
                          height: MySize.getHeight(300),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                "assets/fan_holder.png",
                                color: Color(0xff252B40),
                                height: MySize.getHeight(350),
                              ),
                              Positioned(
                                child: RotationTransition(
                                  turns: Tween(begin: 0.0, end: 1.0).animate(
                                      controller.animationController!.value),
                                  child: Image.asset(
                                    "assets/FAN_Main.png",
                                    height: MySize.getHeight(220),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container(
                          height: MySize.getHeight(300),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                "assets/fan_holder.png",
                                color: Color(0xff252B40),
                                height: MySize.getHeight(350),
                              ),
                              (controller.animationController1 != null)
                                  ? Positioned(
                                      child: GestureDetector(
                                        onHorizontalDragStart: (a) {
                                          controller.setDragAnimation();
                                          controller.update();
                                        },
                                        child: RotationTransition(
                                          turns: Tween(begin: 0.0, end: 1.0)
                                              .animate(controller
                                                  .animationController1!.value),
                                          child: Image.asset(
                                            "assets/FAN_Main.png",
                                            height: MySize.getHeight(220),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Positioned(
                                      child: GestureDetector(
                                        onHorizontalDragStart: (a) {
                                          controller.setDragAnimation();
                                          controller.update();
                                        },
                                        child: Image.asset(
                                          "assets/FAN_Main.png",
                                          height: MySize.getHeight(220),
                                        ),
                                      ),
                                    )
                            ],
                          ),
                        ),
            ],
          ),
        ),
      );
    });
  }
}
