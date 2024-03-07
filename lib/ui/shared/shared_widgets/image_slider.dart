import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:al_karama_app/ui/shared/colors.dart';
import 'package:al_karama_app/ui/shared/custom_widgets/custom_image.dart';
import 'package:al_karama_app/ui/shared/custom_widgets/custom_text.dart';
import 'package:al_karama_app/ui/shared/shared_widgets/custom_team.dart';
import 'package:al_karama_app/ui/shared/utils.dart';
import 'package:al_karama_app/ui/views/main_view/home_view/home_controller.dart';
import 'package:get/get.dart';

class ImageSlider extends StatelessWidget {
  final List<String>? imageUrls;

  final Function? onChanged;
  ImageSlider({super.key, this.imageUrls, this.onChanged});
  HomeController controller = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Container(
        width: screenWidth(1),
        height: screenWidth(1.1),
        child: CarouselSlider(
          options: CarouselOptions(
              onPageChanged: (index, reason) {
                onChanged!();
              },
              scrollPhysics: BouncingScrollPhysics(),
              autoPlay: true,
              aspectRatio: 2,
              height: screenWidth(1),
              viewportFraction: 1),
          items: [
            ...List.generate(imageUrls!.length, (index) {
              return imageUrls != null
                  ? CustomImage(
                      imageUrl: imageUrls![0],
                      width: screenWidth(1),
                      height: screenWidth(1),
                      boxFit: BoxFit.fill)
                  : SizedBox();
            })
          ],
        ));
  }
}

class customRow extends StatelessWidget {
  final String imageUrl;
  final String text;
  const customRow({
    super.key,
    required this.imageUrl,
    required this.text,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          imageUrl,
          width: screenWidth(17),
          height: screenWidth(17),
        ),
        SizedBox(width: screenWidth(40)),
        CustomText(
          textColor: AppColors.whiteColor,
          text: text,
          styleType: TextStyleType.SMALL,
        ),
      ],
    );
  }
}
