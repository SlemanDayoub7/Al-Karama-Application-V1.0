import 'package:al_karama_app/core/data/models/match_detail_model.dart';
import 'package:al_karama_app/core/enums/cart_type.dart';
import 'package:al_karama_app/ui/shared/colors.dart';
import 'package:al_karama_app/ui/shared/shared_widgets/custom_player_cart.dart';
import 'package:al_karama_app/ui/views/match_detail_view/match_detail_widgets/player_substitutions.dart';
import 'package:al_karama_app/ui/views/match_detail_view/match_detail_widgets/team_plan.dart';
import 'package:flutter/material.dart';
import 'package:al_karama_app/core/data/models/match_model.dart';
import 'package:al_karama_app/ui/shared/custom_widgets/custom_app_bar.dart';
import 'package:al_karama_app/ui/shared/custom_widgets/custom_text.dart';
import 'package:al_karama_app/ui/shared/utils.dart';
import 'package:al_karama_app/ui/views/main_view/matches_view/matches_view_widgets/custom_match.dart';
import 'package:al_karama_app/ui/views/match_detail_view/match_detail_controller.dart';
import 'package:get/get.dart';

class MatchDetailView extends StatelessWidget {
  final Football football;
  final matchDetailController controller;
  MatchDetailView({super.key, required this.football})
      : controller =
            Get.put(matchDetailController(matchId: football.uuid ?? ""));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          haveIconBack: true,
          title: "تفاصيل المباره",
        ),
        body: RefreshIndicator(
          color: AppColors.blueColorOne,
          onRefresh: () async {
            await controller.getData();
          },
          child: ListView(
            children: [
              SizedBox(
                height: screenWidth(20),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: screenWidth(30),
                    right: screenWidth(30),
                    bottom: screenWidth(30)),
                child: CustomMatch(
                  isCurrentMatch: true,
                  match: football,
                ),
              ),
              Container(
                margin: EdgeInsetsDirectional.only(
                    end: screenWidth(10), start: screenWidth(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...List.generate(controller.tabs.length, (index) {
                      return InkWell(
                        onTap: () {
                          controller.selectedTab.value = index;
                        },
                        child: Obx(() {
                          return Container(
                            height: screenWidth(7),
                            decoration: BoxDecoration(
                                border: controller.selectedTab.value == index
                                    ? Border(
                                        bottom: BorderSide(
                                            color: Colors.black,
                                            width: screenWidth(150)))
                                    : null),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  text: controller.tabs[index],
                                  styleType: TextStyleType.TITLE,
                                )
                              ],
                            ),
                          );
                        }),
                      );
                    })
                  ],
                ),
              ),
              SizedBox(height: screenWidth(15)),
              Obx(
                () => controller.selectedTab.value == 0
                    ? TeamPlane(
                        plan: football.plan ?? "",
                      )
                    : controller.selectedTab.value == 1
                        ? controller.match.value.replacments == null
                            ? SizedBox()
                            : ListView.separated(
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: screenWidth(30),
                                  );
                                },
                                itemCount:
                                    controller.match.value.beanched!.length,
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (BuildContext context, int index) {
                                  return SwitchPlayers(
                                    inPlayer: controller.match.value
                                            .replacments![index].inplayer ??
                                        Inplayer(),
                                    outPlayer: controller.match.value
                                            .replacments![index].outplayer ??
                                        Inplayer(),
                                  );
                                },
                              )
                        : controller.match.value.beanched == null
                            ? SizedBox()
                            : Padding(
                                padding: EdgeInsets.only(
                                    left: screenWidth(30),
                                    right: screenWidth(30)),
                                child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: screenWidth(40),
                                    childAspectRatio: 0.8,
                                    crossAxisCount: 2,
                                  ),
                                  itemCount:
                                      controller.match.value.beanched!.length,
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return CustomPlayerCart(
                                      cartType: CartType.BENCH,
                                      beanched: controller
                                          .match.value.beanched![index],
                                    );
                                  },
                                ),
                              ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
