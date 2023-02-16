import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sound_generator/sound_generator.dart';
import 'package:sound_generator/waveTypes.dart';
import 'package:volume_controller/volume_controller.dart';
import 'package:yodo1mas/Yodo1MAS.dart';

import '../../../../constants/ad_service.dart';
import '../../../../constants/timer_service.dart';
import '../../../../main.dart';
import '../../../routes/app_pages.dart';

class HomeController extends GetxController with SingleGetTickerProviderMixin {
  RxBool on_Off = false.obs;
  RxBool isRotate = false.obs;
  RxBool isTap = false.obs;
  RxBool isAnimationInit = false.obs;
  AnimationController? animationController;
  Rx<AnimationController>? animationController1;
  RxDouble slider = 75.0.obs;
  RxInt milliseconds = 0.obs;
  double _volumeListenerValue = 0;
  double _getVolume = 0;
  double _setVolumeValue = 0;
  bool isPlaying = false;
  double frequency = 540;
  double balance = 0;
  double volume = 1;
  waveTypes waveType = waveTypes.SINUSOIDAL;
  int sampleRate = 44100;

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await ads();
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
            if (on_Off.isTrue) {
              SoundGenerator.stop();
            }
            break;
          case Yodo1MAS.AD_EVENT_ERROR:
            getIt<TimerService>().verifyTimer();
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
            Get.back();
            print('Interstitial AD_EVENT_ERROR' + message);
            break;
          case Yodo1MAS.AD_EVENT_CLOSED:
            getIt<TimerService>().verifyTimer();
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
            Get.back();
            if (on_Off.isTrue) {
              SoundGenerator.play();
              SoundGenerator.setFrequency(1290);
            }
            break;
        }
      });
    });
  }

  Future<void> ads() async {
    await getIt<AdService>()
        .getAd(adType: AdService.interstitialAd)
        .then((value) {
      if (!value) {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        Get.back();
      }
    }).catchError((error) {
      print("Error := $error");
    });
  }

  startAnimation() async {
    if (_volumeListenerValue <= 0.2) {
      // VolumeController().setVolume(1, showSystemUI: false);
    }
    SoundGenerator.setFrequency(frequency);

    SoundGenerator.play();
    animationController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    isAnimationInit.value = true;
    animationController!.repeat();
  }

  disposeAnimation() {
    SoundGenerator.stop();
    frequency = 540;
    animationController!.duration = Duration(seconds: 1);
    animationController!.forward(from: 0);
    Future.delayed(Duration(seconds: 1)).then((value) {
      animationController!.duration = Duration(seconds: 2);
      animationController!.forward(from: 0);
    });
    isAnimationInit.value = true;
  }

  setDragAnimation() {
    double val = 0;
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
    animationController!.dispose();
    VolumeController().removeListener();
    super.onClose();
  }
}
