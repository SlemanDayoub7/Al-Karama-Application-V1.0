import 'package:al_karama_app/ui/views/landing_view/landing_view.dart';
import 'package:get/get.dart';

class splashController extends GetxController {
  @override
  void onInit() async {
    Future.delayed(Duration(microseconds: 50))
        .then((value) => Get.off(() => LandingView()));
    super.onInit();
  }
}
