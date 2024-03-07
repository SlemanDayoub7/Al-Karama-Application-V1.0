import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:al_karama_app/core/data/repository/sports_repository.dart';
import 'package:al_karama_app/core/enums/connectivityStatus.dart';
import 'package:al_karama_app/core/services/connectivity_service.dart';
import 'package:al_karama_app/ui/shared/utils.dart';
import 'package:get/get.dart';

import '../core/data/models/sports_model.dart';

class MyAppController extends GetxController {
  @override
  RxList<SportsModel> sports = <SportsModel>[].obs;
  Connectivity connectivity = Connectivity();
  void onInit() async {
    checkConnection();
    super.onInit();
  }

  void checkConnection() async {
    ConnectivityStatus status =
        connectivitySerivce.getStatus(await connectivity.checkConnectivity());

    connectivitySerivce.connectivityStatusController.add(status);
    isOnline = status == ConnectivityStatus.ONLINE;

    connectivitySerivce.connectivityStatusController.stream.listen((event) {
      isOnline = event == ConnectivityStatus.ONLINE;
    });
  }
}
