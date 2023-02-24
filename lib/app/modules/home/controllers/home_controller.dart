import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sound_generator/sound_generator.dart';
import 'package:sound_generator/waveTypes.dart';
import 'package:volume_controller/volume_controller.dart';
import 'package:yodo1mas/Yodo1MAS.dart';

import '../../../../constants/ad_service.dart';
import '../../../../main.dart';

class HomeController extends GetxController with SingleGetTickerProviderMixin {
  RxBool on_Off = false.obs;
  RxBool isRotate = false.obs;
  RxBool isTap = false.obs;
  RxBool isAnimationInit = false.obs;
  Rx<AnimationController>? animationController;
  Rx<AnimationController>? animationController1;
  RxDouble slider = 75.0.obs;
  RxInt milliseconds = 0.obs;
  double _volumeListenerValue = 0.0;
  double _setVolumeValue = 0.0;
  bool isPlaying = false;
  RxDouble frequency = 540.0.obs;
  RxInt speed = 1000.obs;
  double balance = 0.0;
  double volume = 1.0;
  waveTypes waveType = waveTypes.SINUSOIDAL;
  int sampleRate = 44100;
  RxInt a = 1000.obs;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      // await ads();
      isPlaying = false;
      SoundGenerator.init(sampleRate);
      SoundGenerator.onIsPlayingChanged.listen((value) {
        isPlaying = value;
      });
      SoundGenerator.setAutoUpdateOneCycleSample(true);
      SoundGenerator.refreshOneCycleData();
      VolumeController().listener((volume) {
        _volumeListenerValue = volume;
      });
      VolumeController().getVolume().then((volume) => _setVolumeValue = volume);
      Yodo1MAS.instance.setInterstitialListener((event, message) {
        switch (event) {
          case Yodo1MAS.AD_EVENT_OPENED:
            print('Interstitial AD_EVENT_OPENED');
            SoundGenerator.stop();
            break;
          case Yodo1MAS.AD_EVENT_ERROR:
            SoundGenerator.stop();
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
            Get.back();
            break;
          case Yodo1MAS.AD_EVENT_CLOSED:
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
            Get.back();
            if (on_Off.isTrue) {
              SoundGenerator.play();
              animationController!.refresh();
              SoundGenerator.setFrequency(frequency.value);
              print(SoundGenerator.getSampleRate);
              if (_volumeListenerValue <= 0.2) {
                VolumeController().setVolume(1, showSystemUI: false);
              }
              frequency.value = frequency.value;
            }
            break;
        }
      });
    });
  }

  Future<void> ads() async {
    // Yodo1MAS.instance.showRewardAd();
    await getIt<AdService>()
        .getAd(adType: AdService.interstitialAd)
        .then((value) {
      if (!value) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        Get.back();
      } else {
        Future.delayed(Duration(seconds: 5)).then((value) {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        });
      }
    }).catchError((error) {
      print("Error := $error");
    });
  }

  startSound() {
    if (_volumeListenerValue <= 0.2) {
      VolumeController().setVolume(1, showSystemUI: false);
    }
    speed.value = 1000;
    frequency.value = 540.0;
    SoundGenerator.setFrequency(frequency.value);
    SoundGenerator.play();
  }

  startAnimation() {
    animationController = AnimationController(
      duration: Duration(milliseconds: speed.value),
      vsync: this,
    ).obs;
    isAnimationInit.value = true;
    animationController!.value.repeat();
  }

  disposeAnimation() {
    animationController!.value.duration = Duration(seconds: 1);
    animationController!.value.forward(from: 0);
    Future.delayed(Duration(seconds: 1)).then((value) {
      animationController!.value.duration = Duration(seconds: 2);
      animationController!.value.forward(from: 0);
    });
    isAnimationInit.value = true;
    SoundGenerator.stop();
  }

  setDragAnimation() {
    double val = 0.0;
    if (animationController1 != null) {
      val = animationController1!.value.value;
      print(val);
    }
    animationController1 = AnimationController(
      duration: Duration(milliseconds: 3000),
      vsync: this,
    ).obs;
    animationController1!.value.forward(from: val == 1 ? 0 : val);
    animationController1!.refresh();
    isAnimationInit.refresh();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    animationController!.value.dispose();
    VolumeController().removeListener();
    super.onClose();
  }
}
