import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sound_generator/sound_generator.dart';

import '../../../../constants/sizeConstant.dart';
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
                          padding: EdgeInsets.only(
                              // right: MySize.getWidth(8),
                              // left: MySize.getWidth(8),
                              top: MySize.getHeight(15)),
                          child: Text("Candle Blower",
                              style: GoogleFonts.lemon(
                                  textStyle: TextStyle(
                                      color: Colors.grey.shade50,
                                      fontWeight: FontWeight.w400,
                                      fontSize: MySize.getHeight(25)))),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: MySize.getHeight(30)),
                          child: Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              Container(
                                height: MySize.getHeight(120),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      MySize.getHeight(12)),
                                  child: Image.asset(
                                    "assets/scale.png",
                                  ),
                                ),
                              ),
                              Container(
                                width: MySize.getWidth(275),
                                height: MySize.getHeight(30),
                                child: Stack(
                                  children: [
                                    AnimatedPositioned(
                                      right: controller.isTap.isTrue
                                          ? MySize.getWidth(
                                              controller.slider.value)
                                          : MySize.getWidth(240),
                                      duration: Duration(seconds: 3),
                                      child: Image.asset(
                                        "assets/triangle.png",
                                        height: 30,
                                        width: 30,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(height: MySize.getHeight(30)),
                            GestureDetector(
                              onTap: () {
                                controller.on_Off.value =
                                    !controller.on_Off.value;
                                controller.isTap.value =
                                    !controller.isTap.value;
                                if (controller.on_Off.isTrue) {
                                  controller.isRotate.value = true;
                                }
                                if (controller.on_Off.isTrue) {
                                  if (controller.isRotate.isTrue) {
                                    controller.startAnimation();
                                  }
                                } else {
                                  controller.desposeAnimation();
                                }
                                controller.slider.value = 80;
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(60),
                                    border:
                                        Border.all(color: Colors.grey.shade50)),
                                child: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  radius: MySize.getHeight(35),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.all(MySize.getHeight(3)),
                                    child: (controller.on_Off.isFalse)
                                        ? Image.asset("assets/switch_green.png")
                                        : Image.asset("assets/switch_red.png"),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: MySize.getHeight(30),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (controller.slider.value > 10) {
                                      controller.slider.value =
                                          controller.slider.value - 10;
                                    }
                                    controller.frequency =
                                        controller.frequency + 20;
                                    SoundGenerator.setFrequency(
                                        controller.frequency);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(
                                            MySize.getHeight(62))),
                                    height: MySize.getHeight(46),
                                    width: MySize.getWidth(140),
                                    child: Center(
                                      child: Text(
                                        "Boost",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: MySize.getHeight(20)),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 25),
                                GestureDetector(
                                  onTap: () {
                                    if (controller.slider.value < 240) {
                                      controller.slider.value =
                                          controller.slider.value + 10;
                                    }
                                    controller.frequency =
                                        controller.frequency - 20;
                                    SoundGenerator.setFrequency(
                                        controller.frequency);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(
                                            MySize.getHeight(62))),
                                    height: MySize.getHeight(46),
                                    width: MySize.getWidth(140),
                                    child: Center(
                                      child: Text(
                                        "Low",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: MySize.getHeight(20)),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ]),
                ),
              ),
              Spacer(),
              (controller.on_Off.isTrue)
                  ? Container(
                      height: MySize.getHeight(300),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          (controller.on_Off.isTrue)
                              ? Image.asset(
                                  "assets/fan_holder_on.png",
                                  height: MySize.getHeight(350),
                                )
                              : Image.asset(
                                  "assets/fan_holder.png",
                                  height: MySize.getHeight(350),
                                ),
                          if (controller.isRotate.isTrue)
                            Positioned(
                              child: RotationTransition(
                                turns: Tween(begin: 0.0, end: 1.0)
                                    .animate(controller.animationController!),
                                child: Image.asset(
                                  "assets/fan1.png",
                                  height: MySize.getHeight(220),
                                ),
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
                                height: MySize.getHeight(350),
                              ),
                              Positioned(
                                child: RotationTransition(
                                  turns: Tween(begin: 0.0, end: 1.0)
                                      .animate(controller.animationController!),
                                  child: Image.asset(
                                    "assets/fan1.png",
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
                                            "assets/fan1.png",
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
                                          "assets/fan1.png",
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
