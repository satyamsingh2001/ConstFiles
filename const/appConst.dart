import '../auth/views/registration_screen/bank_details.dart';
import '../auth/views/registration_screen/owner_details.dart';
import '../auth/views/registration_screen/store_detatils.dart';
import '../auth/views/registration_screen/store_timing.dart';
import '../auth/views/registration_screen/upload_document_screen.dart';
import '../bottomNavbar/views/bottom_nav_bar_screen.dart';
import '../exports.dart';

const int accept = 1;
const int reject = 0;

registrationPageStep({stepNo}) {
  switch (stepNo) {
    case 0:
      return Get.offAll(() => const BottomNavbarScreen());
    case 1:
      return Get.offAll(() => const OwnerDetails());
    case 2:
      return Get.offAll(() => const StoreDetailsScreen());
    case 3:
      return Get.offAll(() => const StoreTiming());
    case 4:
      return Get.offAll(() => const BankDetailsScreen());
    case 5:
      return Get.offAll(() => const UploadDocumentScreen());
  }
}
