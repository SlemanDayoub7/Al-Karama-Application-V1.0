import 'package:al_karama_app/core/data/models/stuff_model.dart';
import 'package:al_karama_app/core/data/repository/stuff_repository.dart';
import 'package:al_karama_app/core/translation/app_translation.dart';
import 'package:al_karama_app/ui/shared/custom_widgets/custom_toast.dart';
import 'package:al_karama_app/ui/shared/utils.dart';
import 'package:get/get.dart';

class StuffController extends GetxController {
  RxBool isLoading = false.obs;
  bool haveWrong = false;
  DateTime dateTime = DateTime.now();
  RxString currentSeason = ''.obs;
  Rx<StuffModel> stuff = StuffModel().obs;
  @override
  void onInit() async {
    await getData();
    currentSeason.value =
        (dateTime.year - 1).toString() + '-' + dateTime.year.toString();
    super.onInit();
  }

  Future<void> getData() async {
    if (!isOnline) {
      CustomToast.showMeassge(message: tr("key_no_internet"));
      return;
    }
    isLoading.value = true;
    stuff.value = StuffModel();
    await StuffRepository().getStuff().then(
        (value) => value.fold((l) => haveWrong = true, (r) => stuff.value = r));
    if (haveWrong) {
      CustomToast.showMeassge(message: tr("key_some_thing_wrong"));
    }
    isLoading.value = haveWrong = false;
  }
}
