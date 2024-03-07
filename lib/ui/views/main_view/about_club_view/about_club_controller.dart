import 'package:dartz/dartz.dart';
import 'package:al_karama_app/core/data/models/events_model.dart';
import 'package:al_karama_app/core/data/models/museum_model.dart';
import 'package:al_karama_app/core/data/models/news_model.dart';
import 'package:al_karama_app/core/data/models/next_match_model.dart';
import 'package:al_karama_app/core/data/repository/museum_repository.dart';
import 'package:al_karama_app/ui/shared/utils.dart';
import 'package:get/get.dart';

import '../../../../core/translation/app_translation.dart';
import '../../../shared/custom_widgets/custom_toast.dart';

class AboutClubController extends GetxController {
  RxBool isLoading = true.obs;
  bool haveWrong = false;
  Rx<MuseumModel> musemum = MuseumModel().obs;
  @override
  void onInit() async {
    await getData();

    super.onInit();
  }

  getData() async {
    if (!isOnline) {
      CustomToast.showMeassge(message: tr("key_no_internet"));
      return;
    }

    isLoading.value = true;
    musemum.value = MuseumModel();
    await MuseumRepository().getMuseum().then((value) =>
        value.fold((l) => haveWrong = true, (r) => musemum.value = r));
    if (haveWrong) {
      CustomToast.showMeassge(message: tr("key_wrong_message"));
    }
    isLoading.value = haveWrong = false;
  }
}
