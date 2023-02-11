import 'package:blower/constants/ad_service.dart';
import 'package:blower/constants/timer_service.dart';

import '../../main.dart';

void setUp() {
  getIt.registerSingleton<TimerService>(TimerService());
  getIt.registerSingleton<AdService>(AdService());
}
