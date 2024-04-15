import 'package:aagyo_vendor/const/const_width.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../exports.dart';

class InternetService {
  final listener =
      InternetConnection().onStatusChange.listen((InternetStatus status) {
    switch (status) {
      case InternetStatus.connected:
        debugPrint("internet connected");
        Get.back();
        break;
      case InternetStatus.disconnected:
        _noInternet();
        debugPrint("internet disconnected");
        break;
    }
  });
}

_noInternet() {
  return Get.dialog(
    barrierDismissible: false,

    WillPopScope(
      onWillPop: () async => false,
      child: Dialog(alignment: Alignment.topCenter,
        child: Container(
          padding: EdgeInsets.all(width2),
          child: Row(
            children: [
              const CircularProgressIndicator(color: AppColors.primary,),
              10.width,
              const Text("No internet connection",style: AppTextStyles.f15Bold,),
            ],
          ),
        ),
      ),
    ),
  );
}
