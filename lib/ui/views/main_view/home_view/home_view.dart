import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:al_karama_app/core/enums/shimmer_type.dart';
import 'package:al_karama_app/ui/shared/colors.dart';
import 'package:al_karama_app/ui/shared/custom_widgets/custom_app_bar.dart';
import 'package:al_karama_app/ui/shared/custom_widgets/custom_text.dart';
import 'package:al_karama_app/ui/shared/shared_widgets/custom_news.dart';
import 'package:al_karama_app/ui/shared/shared_widgets/custom_shimmer.dart';
import 'package:al_karama_app/ui/shared/shared_widgets/custom_team.dart';
import 'package:al_karama_app/ui/shared/utils.dart';
import 'package:al_karama_app/ui/views/main_view/home_view/home_controller.dart';
import 'package:al_karama_app/ui/shared/shared_widgets/image_slider.dart';
import 'package:al_karama_app/ui/views/stuff_view/stuff_view.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: screenWidth(4)),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                foregroundColor: AppColors.whiteColor,
                backgroundColor: AppColors.blueColorOne,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
            child: CustomText(
              text: "الكادر",
              textColor: AppColors.whiteColor,
            ),
            onPressed: () {
              Get.to(() => StuffView());
            },
          ),
        ),
        backgroundColor: AppColors.backGroundColor,
        appBar: CustomAppBar(
          title: "نادي الكرامة الرياضي",
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
                  () => controller.isLoading.value
                      ? CustomShimmer(
                          shimmerType: ShimmerType.CUSTOM,
                          widget: Container(
                            decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(20)),
                            width: screenWidth(1),
                            height: screenWidth(1.7),
                          ),
                        )
                      : controller.nextMatch.value.channel == null
                          ? SizedBox()
                          : Container(
                              margin: EdgeInsets.only(
                                  left: screenWidth(40),
                                  right: screenWidth(40)),
                              width: screenWidth(1),
                              height: screenWidth(1.5),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: AppColors.grayColorTwo,
                                        blurRadius: 1,
                                        offset: Offset(2, 2))
                                  ],
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.blueColorOne),
                              child: Row(
                                children: [
                                  Image.network(
                                    controller.nextMatch.value.player!.image!,
                                    width: screenWidth(3.2),
                                    height: screenWidth(1.2),
                                    fit: BoxFit.fill,
                                    errorBuilder: (context, error, stackTrace) {
                                      return SizedBox(
                                        width: screenWidth(3.2),
                                        height: screenWidth(1.2),
                                      );
                                    },
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: EdgeInsets.all(screenWidth(30)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            child: Center(
                                              child: CustomText(
                                                  styleType:
                                                      TextStyleType.SUBTITLE,
                                                  text: "المباراة القادمة",
                                                  textColor:
                                                      AppColors.whiteColor),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              CustomTeam(
                                                  name: controller.nextMatch
                                                              .value!.team1 !=
                                                          null
                                                      ? controller
                                                              .nextMatch
                                                              .value!
                                                              .team1!
                                                              .name ??
                                                          ""
                                                      : "",
                                                  imageUrl: controller.nextMatch
                                                          .value.team1!.logo ??
                                                      "",
                                                  textColor:
                                                      AppColors.whiteColor),
                                              CustomText(
                                                text: "VS",
                                                styleType:
                                                    TextStyleType.SUBTITLE,
                                                textColor: AppColors.whiteColor,
                                              ),
                                              CustomTeam(
                                                  name: controller.nextMatch
                                                              .value!.team2 !=
                                                          null
                                                      ? controller
                                                              .nextMatch
                                                              .value!
                                                              .team2!
                                                              .name ??
                                                          ""
                                                      : "",
                                                  imageUrl: controller.nextMatch
                                                          .value.team2!.logo ??
                                                      "",
                                                  textColor:
                                                      AppColors.whiteColor)
                                            ],
                                          ),
                                          customRow(
                                            imageUrl:
                                                "assets/images/pngs/date.png",
                                            text: controller
                                                    .nextMatch.value!.date ??
                                                "",
                                          ),
                                          customRow(
                                            imageUrl:
                                                "assets/images/pngs/time.png",
                                            text: controller
                                                    .nextMatch.value!.time ??
                                                "",
                                          ),
                                          customRow(
                                            imageUrl:
                                                "assets/images/pngs/location.png",
                                            text: controller.nextMatch.value!
                                                    .playGround ??
                                                "",
                                          ),
                                          customRow(
                                            imageUrl:
                                                "assets/images/pngs/live.png",
                                            text: controller
                                                    .nextMatch.value.channel ??
                                                "",
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                ),
                SizedBox(
                  height: screenWidth(20),
                ),
                Obx(() => controller.isLoading.value
                    ? CustomShimmer(
                        shimmerType: ShimmerType.CUSTOM,
                        widget: Container(
                          margin: EdgeInsets.only(left: screenWidth(2)),
                          height: screenWidth(11),
                          width: screenWidth(5),
                          decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(30)),
                        ),
                      )
                    : controller.news.length == 0
                        ? SizedBox()
                        : CustomText(
                            text: "آخر الأخبار",
                            styleType: TextStyleType.CUSTOMTITLE,
                          )),
                SizedBox(
                  height: screenWidth(20),
                ),
                Obx(() => !controller.isLoading.value
                    ? Scrollbar(
                        thickness: 1,
                        child: ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: screenWidth(40),
                            );
                          },
                          itemCount: controller.news.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Obx(
                              () => CustomNews(
                                  onTap: () {
                                    controller.openCustomeNews(index);
                                  },
                                  newsModel: controller.news[index],
                                  imageUrl: controller.news[index].image,
                                  description:
                                      controller.news[index].content ?? "",
                                  date: controller.news[index].date ?? "",
                                  viewers:
                                      controller.news[index].content ?? ""),
                            );
                          },
                        ),
                      )
                    : CustomShimmer(shimmerType: ShimmerType.LIST)),
                SizedBox(
                  height: screenWidth(4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
