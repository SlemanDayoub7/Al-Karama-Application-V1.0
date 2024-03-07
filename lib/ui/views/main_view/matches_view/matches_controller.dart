import 'package:al_karama_app/core/data/models/match_model.dart';
import 'package:al_karama_app/core/data/repository/match_repository.dart';
import 'package:al_karama_app/core/translation/app_translation.dart';
import 'package:al_karama_app/ui/shared/custom_widgets/custom_toast.dart';
import 'package:al_karama_app/ui/shared/utils.dart';
import 'package:al_karama_app/ui/views/match_detail_view/match_detail_controller.dart';
import 'package:al_karama_app/ui/views/match_detail_view/match_detail_view.dart';
import 'package:get/get.dart';

class MatcheController extends GetxController {
  RxBool isLoading = true.obs;
  bool haveWrong = false;
  Rx<MatchModel> matches = MatchModel().obs;
  Rx<MatchModel> finishedMatch = MatchModel().obs;
  @override
  void onInit() async {
    await getData();
    super.onInit();
  }

  goToMatchDetail(Football football) {
    Get.to(() => MatchDetailView(
          football: football,
        ));
  }

  getData() async {
    if (!isOnline) {
      CustomToast.showMeassge(message: tr("key_no_internet"));
      return;
    }
    isLoading.value = true;
    matches.value = MatchModel();
    finishedMatch.value = MatchModel();
    await MatchRepository().getMatches().then((value) =>
        value.fold((l) => haveWrong = true, (r) => matches.value = r));
    await MatchRepository().getFinishedMatch().then((value) =>
        value.fold((l) => haveWrong = true, (r) => finishedMatch.value = r));
    if (haveWrong) {
      CustomToast.showMeassge(message: tr("key_wrong_message"));
    }
    isLoading.value = false;
  }
}
