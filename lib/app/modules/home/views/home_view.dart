import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                  height: MySize.getHeight(300),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              right: MySize.getWidth(8),
                              left: MySize.getWidth(8),
                              top: MySize.getHeight(15)),
                          child: Row(
                            children: [
                              Icon(
                                Icons.share,
                                color: Colors.grey,
                                size: MySize.getHeight(30),
                              ),
                              Spacer(),
                              Text("Candle Blower",
                                  style: TextStyle(
                                      color: Colors.grey.shade50,
                                      fontWeight: FontWeight.bold,
                                      fontSize: MySize.getHeight(30))),
                              Spacer(),
                              Image.asset(
                                "assets/no-ads.png",
                                height: MySize.getHeight(30),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: MySize.getHeight(30)),
                          child: Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              Container(
                                height: MySize.getHeight(100),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      MySize.getHeight(12)),
                                  child: Image.asset(
                                    "assets/scale.png",
                                  ),
                                ),
                              ),
                              Container(
                                width: MySize.getWidth(230),
                                height: MySize.getHeight(20),
                                child: Stack(
                                  children: [
                                    AnimatedPositioned(
                                      right:
                                          controller.isTap.isTrue ? 0.0 : 150,
                                      duration: Duration(seconds: 3),
                                      child: CircleAvatar(
                                        radius: 10,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              right: MySize.getWidth(70),
                              top: MySize.getHeight(30),
                              left: MySize.getWidth(70)),
                          child: Row(
                            children: [
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
                              Spacer(),
                              Container(
                                  width: MySize.getWidth(100),
                                  child: Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          controller.frequency =
                                              controller.frequency + 20;
                                          SoundGenerator.setFrequency(
                                              controller.frequency);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      MySize.getHeight(8))),
                                          height: 30,
                                          child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  "assets/up.png",
                                                  height: 10,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: MySize.getWidth(20),
                                                ),
                                                Text(
                                                  "Boost",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ]),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      GestureDetector(
                                        onTap: () {
                                          controller.frequency =
                                              controller.frequency - 20;
                                          SoundGenerator.setFrequency(
                                              controller.frequency);
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      MySize.getHeight(8))),
                                          height: 30,
                                          child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Image.asset(
                                                  "assets/down.png",
                                                  height: 15,
                                                  color: Colors.white,
                                                ),
                                                SizedBox(
                                                  width: MySize.getWidth(22),
                                                ),
                                                Text(
                                                  "Low",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ]),
                                        ),
                                      )
                                    ],
                                  ))
                            ],
                          ),
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
                                  "assets/fan.png",
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
                                    "assets/fan.png",
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
                                            "assets/fan.png",
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
                                          "assets/fan.png",
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
