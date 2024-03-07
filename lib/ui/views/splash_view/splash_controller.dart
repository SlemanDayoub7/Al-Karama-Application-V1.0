import 'package:al_karama_app/core/data/models/sports_model.dart';
import 'package:al_karama_app/core/data/repository/sports_repository.dart';
import 'package:al_karama_app/core/translation/app_translation.dart';
import 'package:al_karama_app/ui/shared/custom_widgets/custom_toast.dart';
import 'package:al_karama_app/ui/shared/utils.dart';
import 'package:al_karama_app/ui/views/landing_view/landing_view.dart';
import 'package:al_karama_app/ui/views/main_view/main_view.dart';
import 'package:get/get.dart';

class splashController extends GetxController {
  @override
  void onInit() async {
    Future.delayed(Duration(seconds: 1))
        .then((value) => Get.off(() => LandingView()));
    super.onInit();
  }
}
