import 'package:flutter/material.dart';
import 'package:al_karama_app/core/enums/shimmer_type.dart';
import 'package:al_karama_app/ui/shared/colors.dart';
import 'package:al_karama_app/ui/shared/custom_widgets/custom_app_bar.dart';
import 'package:al_karama_app/ui/shared/custom_widgets/custom_image.dart';
import 'package:al_karama_app/ui/shared/custom_widgets/custom_text.dart';
import 'package:al_karama_app/ui/shared/shared_widgets/custom_shimmer.dart';
import 'package:al_karama_app/ui/shared/utils.dart';
import 'package:al_karama_app/ui/views/fans_view/fans_view.dart';
import 'package:al_karama_app/ui/views/main_view/about_club_view/about_club_controller.dart';
import 'package:al_karama_app/ui/views/main_view/museum_view/museum_controller.dart';
import 'package:get/get.dart';

class AboutClubView extends StatelessWidget {
  AboutClubView({super.key});
  AboutClubController controller = Get.put(AboutClubController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backGroundColor,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: screenWidth(4)),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                foregroundColor: AppColors.whiteColor,
                backgroundColor: AppColors.blueColorOne,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30))),
            child: CustomText(text: "الرابطة"),
            onPressed: () {
              Get.to(() => FansView());
            },
          ),
        ),
        appBar: CustomAppBar(
          title: "عن النادي",
          haveIconBack: false,
        ),
        body: Padding(
          padding: EdgeInsets.only(
            right: screenWidth(40),
            left: screenWidth(40),
          ),
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
                Obx(() => controller.isLoading.value
                    ? CustomShimmer(
                        shimmerType: ShimmerType.CUSTOM,
                        widget: ListView.separated(
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: screenWidth(20),
                            );
                          },
                          shrinkWrap: true,
                          itemCount: 3,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int index) {
                            return Column(children: [
                              Container(
                                width: screenWidth(1),
                                height: screenWidth(2),
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              SizedBox(height: screenWidth(20)),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                height: screenWidth(12),
                                width: screenWidth(1),
                              )
                            ]);
                          },
                        ))
                    : controller.musemum.value.aboutClub == null
                        ? SizedBox()
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, i) {
                              return Column(children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    controller
                                        .musemum.value.aboutClub![i].image!,
                                    width: screenWidth(1),
                                    height: screenWidth(2),
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return SizedBox();
                                    },
                                  ),
                                ),
                                SizedBox(height: screenWidth(20)),
                                CustomText(
                                  text: controller
                                          .musemum.value.aboutClub![i].title ??
                                      "",
                                  styleType: TextStyleType.SUBTITLE,
                                ),
                                CustomText(
                                    overflow: TextOverflow.visible,
                                    text: controller
                                        .musemum.value.aboutClub![i].content!)
                              ]);
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: screenWidth(40),
                              );
                            },
                            itemCount:
                                controller.musemum.value.aboutClub!.length)),
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
