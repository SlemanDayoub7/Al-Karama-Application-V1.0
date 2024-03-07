import 'package:al_karama_app/ui/shared/custom_widgets/custom_image.dart';
import 'package:flutter/material.dart';
import 'package:al_karama_app/core/data/models/news_model.dart';
import 'package:al_karama_app/ui/shared/colors.dart';
import 'package:al_karama_app/ui/shared/custom_widgets/custom_text.dart';
import 'package:al_karama_app/ui/shared/utils.dart';
import 'package:al_karama_app/ui/views/details_news_view/details_news_view.dart';
import 'package:get/get.dart';

class CustomNews extends StatelessWidget {
  final String description;
  final String date;
  final String viewers;
  final String? imageUrl;
  final Function? onTap;
  final NewsModel? newsModel;
  const CustomNews(
      {super.key,
      required this.description,
      required this.date,
      required this.viewers,
      this.imageUrl,
      this.newsModel,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap!();
      },
      child: Container(
        margin: EdgeInsets.only(left: screenWidth(50), right: screenWidth(50)),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: AppColors.grayColorTwo,
                blurRadius: 1,
                offset: Offset(2, 2))
          ],
          borderRadius: BorderRadius.circular(20),
          color: AppColors.whiteColor,
        ),
        padding: EdgeInsets.all(screenWidth(30)),
        width: screenWidth(1.1),
        height: screenWidth(3.4),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CustomImage(
                  url: imageUrl ?? "",
                  width: screenWidth(3),
                  height: screenWidth(3.4),
                  fit: BoxFit.fill),
            ),
            SizedBox(
              width: screenWidth(40),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: description,
                    max_lines: 2,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Image.asset("assets/images/pngs/time_1.png",
                          width: screenWidth(20),
                          height: screenWidth(20),
                          fit: BoxFit.fill),
                      SizedBox(
                        width: screenWidth(40),
                      ),
                      CustomText(text: date),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
