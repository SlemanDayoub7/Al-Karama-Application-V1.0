import 'package:flutter/material.dart';
import 'package:al_karama_app/core/data/repository/museum_repository.dart';
import 'package:al_karama_app/core/enums/shimmer_type.dart';
import 'package:al_karama_app/ui/shared/colors.dart';
import 'package:al_karama_app/ui/shared/custom_widgets/custom_app_bar.dart';
import 'package:al_karama_app/ui/shared/custom_widgets/custom_image.dart';
import 'package:al_karama_app/ui/shared/custom_widgets/custom_text.dart';
import 'package:al_karama_app/ui/shared/shared_widgets/custom_shimmer.dart';
import 'package:al_karama_app/ui/shared/shared_widgets/custom_video.dart';
import 'package:al_karama_app/ui/shared/utils.dart';
import 'package:al_karama_app/ui/views/main_view/museum_view/museum_controller.dart';
import 'package:al_karama_app/ui/views/main_view/museum_view/museum_view_widgets/custom_about_club.dart';
import 'package:al_karama_app/ui/views/main_view/museum_view/museum_view_widgets/custom_boss.dart';
import 'package:al_karama_app/ui/views/main_view/museum_view/museum_view_widgets/custom_cup.dart';
import 'package:get/get.dart';

class MusemumView extends StatelessWidget {
  MusemumView({super.key});
  MuseumController controller = Get.put(MuseumController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: AppColors.backGroundColor,
            appBar: CustomAppBar(
              title: "المتحف",
              haveIconBack: false,
            ),
            body: Padding(
              padding: EdgeInsets.only(
                  right: screenWidth(40),
                  left: screenWidth(40),
                  bottom: screenWidth(40)),
              child: RefreshIndicator(
                color: AppColors.blueColorOne,
                onRefresh: () async {
                  await controller.getData();
                },
                child: ListView(
                  children: [
                    SizedBox(
                      height: screenWidth(20),
                    ),
                    Obx(
                      () => controller.musemum.value.aboutClub == null ||
                              controller.musemum.value.aboutClub!.length == 0
                          ? SizedBox()
                          : CustomText(
                              text: "عن النادي",
                              styleType: TextStyleType.CUSTOMTITLE,
                            ),
                    ),
                    SizedBox(
                      height: screenWidth(20),
                    ),
                    Obx(() => controller.isLoading.value
                        ? CustomShimmer(
                            shimmerType: ShimmerType.GROUP,
                            height: screenWidth(2.2),
                            width: screenWidth(1.7),
                          )
                        : controller.musemum.value.aboutClub == null ||
                                controller.musemum.value.aboutClub!.length == 0
                            ? SizedBox()
                            : Container(
                                width: screenWidth(1),
                                height: screenWidth(2),
                                child: ListView.separated(
                                  separatorBuilder: (context, index) {
                                    return SizedBox(width: screenWidth(20));
                                  },
                                  scrollDirection: Axis.horizontal,
                                  itemCount: controller
                                      .musemum.value.aboutClub!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return CustomAboutClub(
                                        text: controller.musemum.value
                                                .aboutClub![index].title ??
                                            "",
                                        imageUrl: controller.musemum.value
                                                .aboutClub![index].image ??
                                            "");
                                  },
                                ))),
                    SizedBox(
                      height: screenWidth(20),
                    ),
                    //  Obx(() => controller.isLoading.value
                    //           ? CustomShimmer(
                    //               shimmerType: ShimmerType.LIST,
                    //               axis: Axis.horizontal,
                    //             )
                    //           :
                    //            CustomImage(url:controller.musemum.value.strategies)),
                    Obx(() => controller.musemum.value.bosses == null ||
                            controller.musemum.value.bosses!.length == 0
                        ? SizedBox()
                        : CustomText(
                            text: "رؤساء النادي",
                            styleType: TextStyleType.CUSTOMTITLE,
                          )),
                    SizedBox(height: screenWidth(30)),
                    Obx(() => controller.isLoading.value
                        ? CustomShimmer(
                            shimmerType: ShimmerType.GROUP,
                          )
                        : controller.musemum.value.bosses == null ||
                                controller.musemum.value.bosses!.length == 0
                            ? SizedBox()
                            : Container(
                                width: screenWidth(1),
                                height: screenWidth(1.8),
                                child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return CustomBoss(
                                        imageUrl: controller.musemum.value
                                                .bosses![index].image ??
                                            "",
                                        name: controller.musemum.value
                                                .bosses![index].name ??
                                            "",
                                        date: controller.musemum.value
                                                .bosses![index].startYear ??
                                            "",
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return SizedBox(
                                        width: screenWidth(30),
                                      );
                                    },
                                    itemCount: controller
                                        .musemum.value.bosses!.length),
                              )),
                    SizedBox(
                      height: screenWidth(20),
                    ),
                    Obx(() => controller.primesClub.length == 0
                        ? SizedBox()
                        : CustomText(
                            text: "ألقاب نادي الكرامة",
                            styleType: TextStyleType.CUSTOMTITLE,
                          )),
                    SizedBox(height: screenWidth(30)),
                    Obx(() => controller.isLoading.value
                        ? CustomShimmer(
                            shimmerType: ShimmerType.GROUP,
                          )
                        : controller.primesClub.length == 0
                            ? SizedBox()
                            : Container(
                                width: screenWidth(1),
                                height: screenWidth(1.8),
                                child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return CustomCup(
                                        cupName:
                                            controller.primesClub[index].name ??
                                                "",
                                        date: controller
                                                .primesClub[index].seasone ??
                                            "",
                                        imageUrl: controller
                                                .primesClub[index].image ??
                                            "",
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return SizedBox(
                                        width: screenWidth(30),
                                      );
                                    },
                                    itemCount: controller.primesClub.length),
                              )),
                    SizedBox(
                      height: screenWidth(30),
                    ),
                    Obx(() => controller.musemum.value.primes == null ||
                            controller.musemum.value.primes!.length == 0
                        ? SizedBox()
                        : CustomText(
                            text: "الجوائز الفردية للاعبي  الكرامة",
                            styleType: TextStyleType.CUSTOMTITLE,
                          )),
                    SizedBox(height: screenWidth(30)),
                    Obx(() => controller.isLoading.value
                        ? CustomShimmer(
                            shimmerType: ShimmerType.GROUP,
                          )
                        : controller.primesPlayers.length == 0
                            ? SizedBox()
                            : Container(
                                width: screenWidth(1),
                                height: screenWidth(1.8),
                                child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return CustomBoss(
                                        imageUrl: controller
                                                .primesPlayers[index].image ??
                                            "",
                                        name: controller
                                                .primesPlayers[index].name ??
                                            " ",
                                        date: controller.primesPlayers[index]
                                                .description ??
                                            " ",
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return SizedBox(
                                        width: screenWidth(30),
                                      );
                                    },
                                    itemCount: controller.primesPlayers.length),
                              )),
                    SizedBox(height: screenWidth(30)),
                    Obx(() => controller.musemum.value.bestGoals == null ||
                            controller.musemum.value.bestGoals!.length == 0
                        ? SizedBox()
                        : CustomText(
                            text: "أجمل أهداف لاعبي الكرامة",
                            styleType: TextStyleType.CUSTOMTITLE,
                          )),
                    SizedBox(height: screenWidth(30)),
                    Obx(() => controller.isLoading.value
                        ? CustomShimmer(
                            shimmerType: ShimmerType.GROUP,
                            width: screenWidth(1.2),
                            height: screenWidth(3),
                          )
                        : controller.musemum.value.bestGoals == null ||
                                controller.musemum.value.bestGoals!.length == 0
                            ? SizedBox()
                            : Container(
                                width: screenWidth(1),
                                height: screenWidth(3.5),
                                child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return CustomVideo(
                                        color: AppColors.blueColorOne,
                                        title: controller
                                                .musemum
                                                .value
                                                .bestGoals![index]
                                                .description ??
                                            "",
                                        videoUrl: controller.musemum.value
                                                .bestGoals![index].url ??
                                            "",
                                        imageUrl: controller.imagesUrl[index],
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return SizedBox(
                                        width: screenWidth(30),
                                      );
                                    },
                                    itemCount: controller
                                        .musemum.value.bestGoals!.length),
                              )),
                    SizedBox(
                      height: screenWidth(4),
                    ),
                  ],
                ),
              ),
            )));
  }
}
