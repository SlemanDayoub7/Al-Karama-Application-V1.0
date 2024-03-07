import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:al_karama_app/core/data/models/events_model.dart';
import 'package:al_karama_app/core/data/models/museum_model.dart';
import 'package:al_karama_app/core/data/models/news_model.dart';
import 'package:al_karama_app/core/data/models/next_match_model.dart';
import 'package:al_karama_app/core/data/repository/museum_repository.dart';
import 'package:al_karama_app/core/data/repository/news_repository.dart';
import 'package:al_karama_app/core/data/repository/next_match_repository.dart';
import 'package:al_karama_app/core/translation/app_translation.dart';
import 'package:al_karama_app/ui/shared/custom_widgets/custom_toast.dart';
import 'package:al_karama_app/ui/shared/utils.dart';
import 'package:get/get.dart';

class MuseumController extends GetxController {
  RxBool isLoading = true.obs;
  bool haveWrong = false;
  Rx<MuseumModel> musemum = MuseumModel().obs;
  RxList<BestGoals> bestGoals = <BestGoals>[].obs;
  List<BestGoals> temp = <BestGoals>[].obs;
  RxList<Primes> primesPlayers = <Primes>[].obs;
  RxList<Primes> primesClub = <Primes>[].obs;
  RxList<String> imagesUrl = <String>[].obs;
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
    primesPlayers.clear();
    primesClub.clear();
    bestGoals.clear();
    await MuseumRepository().getMuseum().then((value) =>
        value.fold((l) => haveWrong = true, (r) => musemum.value = r));
    if (haveWrong) {
      CustomToast.showMeassge(message: tr("key_some_thing_wrong"));
    } else {
      if (musemum.value.primes != null)
        musemum.value.primes!.forEach((element) {
          element.type == 'personal'
              ? primesPlayers.add(element)
              : primesClub.add(element);
        });
      if (musemum.value.bestGoals != null) {
        musemum.value.bestGoals!.forEach((element) {
          imagesUrl.add(getImageOfVideo(element.url ?? ""));
        });
      }
    }

    isLoading.value = haveWrong = false;
  }
}
