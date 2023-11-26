import 'package:eco_city/presentation/widgets/buttons/generalButton.dart';
import 'package:eco_city/utils/constants/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class NotFoundScreen extends StatefulWidget {
  const NotFoundScreen({super.key});

  @override
  State<NotFoundScreen> createState() => NotFoundScreenState();
}

class NotFoundScreenState extends State<NotFoundScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: const Text(
                  '404',
                  style: TextStyles.largestHeadlineTextStyle,
                ),
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: const Text(
                  'Страница не найдена',
                  style: TextStyles.greyCaptionTextStyle,
                ),
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: GeneralButton(
                  title: 'Перейти на главную',
                  isDisabled: false,
                  onPressed: () {
                    Get.toNamed('/startScreen');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
