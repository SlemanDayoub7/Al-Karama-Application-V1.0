import 'package:flutter/material.dart';
import 'package:al_karama_app/core/enums/shimmer_type.dart';

import 'package:al_karama_app/ui/shared/colors.dart';
import 'package:al_karama_app/ui/shared/custom_widgets/custom_app_bar.dart';
import 'package:al_karama_app/ui/shared/custom_widgets/custom_text.dart';
import 'package:al_karama_app/ui/shared/shared_widgets/custom_shimmer.dart';
import 'package:al_karama_app/ui/shared/utils.dart';
import 'package:al_karama_app/ui/views/main_view/matches_view/matches_controller.dart';
import 'package:al_karama_app/ui/views/match_detail_view/match_detail_view.dart';
import 'package:al_karama_app/ui/views/main_view/matches_view/matches_view_widgets/custom_match.dart';
import 'package:get/get.dart';

class MatchesView extends StatelessWidget {
  MatchesView({super.key});
  MatcheController controller = Get.put(MatcheController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          title: "المباريات",
          haveIconBack: false,
        ),
        body: RefreshIndicator(
          color: AppColors.blueColorOne,
          onRefresh: () async {
            await controller.getData();
          },
          child: ListView(
            children: [
              SizedBox(
                height: screenWidth(30),
              ),
              Obx(() => controller.isLoading.value
                  ? CustomShimmer(
                      shimmerType: ShimmerType.CUSTOM,
                      widget: Container(
                        decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(15)),
                        margin: EdgeInsets.only(
                            left: screenWidth(30), right: screenWidth(30)),
                        height: screenWidth(3),
                        width: screenWidth(1),
                      ),
                    )
                  : controller.finishedMatch.value.football == null
                      ? SizedBox()
                      : controller.matches.value.football!.length == 0
                          ? SizedBox()
                          : Container(
                              width: screenWidth(1),
                              height: screenWidth(2.1),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: screenWidth(30),
                                        right: screenWidth(30)),
                                    child: CustomMatch(
                                      isCurrentMatch: true,
                                      match: controller.finishedMatch.value
                                          .football![controller.finishedMatch
                                              .value.football!.length -
                                          1],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: InkWell(
                                      onTap: () {
                                        controller.goToMatchDetail(controller
                                            .finishedMatch
                                            .value
                                            .football![controller.finishedMatch
                                                .value.football!.length -
                                            1]);
                                      },
                                      child: Container(
                                        padding:
                                            EdgeInsets.all(screenWidth(70)),
                                        decoration: BoxDecoration(
                                            color: AppColors.blueColorOne,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        width: screenWidth(3),
                                        height: screenWidth(11),
                                        child: Center(
                                          child: CustomText(
                                            styleType: TextStyleType.SMALL,
                                            text: "تفاصيل المبارة",
                                            textColor: AppColors.orangeColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )),
              SizedBox(
                height: screenWidth(15),
              ),
              Obx(() => controller.isLoading.value
                  ? CustomShimmer(
                      shimmerType: ShimmerType.CUSTOM,
                      widget: Container(
                        margin: EdgeInsets.only(
                            left: screenWidth(30), right: screenWidth(30)),
                        decoration: BoxDecoration(
                            color: AppColors.whiteColor,
                            borderRadius: BorderRadius.circular(30)),
                        width: screenWidth(1),
                        height: screenWidth(20),
                      ),
                    )
                  : controller.matches.value.football == null
                      ? SizedBox()
                      : controller.matches.value.football!.length == 0
                          ? SizedBox()
                          : Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 1,
                                    color: Colors.black,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: screenWidth(50),
                                      right: screenWidth(50)),
                                  child: CustomText(
                                    text: "المباريات القادمة",
                                    styleType: TextStyleType.SUBTITLE,
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 1,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            )),
              SizedBox(
                height: screenWidth(15),
              ),
              Obx(() => Padding(
                  padding: EdgeInsets.all(screenWidth(30)),
                  child: controller.isLoading.value
                      ? CustomShimmer(shimmerType: ShimmerType.LIST)
                      : controller.matches.value.football == null
                          ? SizedBox()
                          : controller.matches.value.football!.length == 0
                              ? SizedBox()
                              : ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      controller.matches.value.football!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return CustomMatch(
                                      isCurrentMatch: false,
                                      match: controller
                                          .matches.value.football![index],
                                    );
                                  },
                                ))),
              SizedBox(
                height: screenWidth(4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
