import 'package:al_karama_app/core/data/models/news_model.dart';
import 'package:al_karama_app/core/data/models/next_match_model.dart';
import 'package:al_karama_app/core/data/models/player_detail_model.dart';
import 'package:al_karama_app/core/data/models/sports_model.dart';
import 'package:al_karama_app/core/data/repository/news_repository.dart';
import 'package:al_karama_app/core/data/repository/next_match_repository.dart';
import 'package:al_karama_app/core/data/repository/sports_repository.dart';
import 'package:al_karama_app/core/data/repository/stuff_repository.dart';
import 'package:al_karama_app/ui/shared/utils.dart';
import 'package:al_karama_app/ui/views/details_news_view/details_news_view.dart';
import 'package:get/get.dart';
import '../../../../core/translation/app_translation.dart';
import '../../shared/custom_widgets/custom_toast.dart';

class PlayerController extends GetxController {
  RxBool isLoading = true.obs;
  bool haveWrong = false;
  String playerId = '';
  Rx<PlayerDetailModel> playerDetail = PlayerDetailModel().obs;
  PlayerController({required this.playerId});
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
    playerDetail.value = PlayerDetailModel();
    await StuffRepository().getPlayerDetail(playerId).then(
      (value) {
        value.fold((l) => haveWrong = true, (r) => playerDetail.value = r);
      },
    );

    if (haveWrong) {
      CustomToast.showMeassge(message: tr("key_some_thing_wrong"));
    }

    isLoading.value = haveWrong = false;
  }
}
