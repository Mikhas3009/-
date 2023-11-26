import 'package:eco_city/utils/constants/colors.dart';
import 'package:eco_city/utils/constants/textStyles.dart';
import 'package:flutter/material.dart';

class ModerationNewsCard extends StatelessWidget {
  final String newsId;
  final String newsTopic;
  final String newsDescription;
  final String newsCategory;
  final String newsAddress;
  final Image newsImage;
  final VoidCallback onTap;

  const ModerationNewsCard({
    super.key,
    required this.newsId,
    required this.newsTopic,
    required this.newsDescription,
    required this.newsImage,
    required this.onTap,
    required this.newsCategory,
    required this.newsAddress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
        decoration: const BoxDecoration(
          color: AppColors.inputBackground,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 10),
              alignment: Alignment.center,
              child: Text(
                newsTopic,
                style: TextStyles.generalHeadlineTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 10),
              child: Container(
                height: 1,
                color: AppColors.greyColor,
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Text(
                newsDescription,
                style: TextStyles.greyCaptionTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
