import 'dart:convert';
import 'package:eco_city/presentation/widgets/buttons/generalButton.dart';
import 'package:eco_city/presentation/widgets/buttons/lightButton.dart';
import 'package:eco_city/utils/constants/colors.dart';
import 'package:eco_city/utils/constants/textStyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repositories/apiClient.dart';
import '../../../utils/helpers/showSnackBar.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => StartScreenState();
}

class StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Image.asset(
                          "assets/images/authorization_header_general.png",
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Image.asset(
                          "assets/images/authorization_logo.png",
                          height: 200,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 40),
                        child: const Text(
                          'Добро пожаловать!',
                          style: TextStyles.generalHeadlineTextStyle,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: GeneralButton(
                          title: 'Создать аккаунт',
                          isDisabled: false,
                          onPressed: () {
                            Get.toNamed('/registration');
                          },
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: LightButton(
                          title: 'Войти',
                          isDisabled: false,
                          onPressed: () {
                            Get.toNamed('/authorization');
                          },
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.offAndToNamed('/notFound');
                              },
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                "assets/images/icon_viber.png",
                                height: 40,
                                width: 40,
                              ),
                            ),
                            const SizedBox(
                              width: 32,
                            ),
                            InkWell(
                              onTap: () {
                                Get.offAndToNamed('/notFound');
                              },
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                "assets/images/icon_telegram.png",
                                height: 40,
                                width: 40,
                              ),
                            ),
                            const SizedBox(
                              width: 32,
                            ),
                            InkWell(
                              onTap: () {
                                Get.offAndToNamed('/notFound');
                              },
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                "assets/images/icon_vk.png",
                                height: 40,
                                width: 40,
                              ),
                            ),
                            const SizedBox(
                              width: 32,
                            ),
                            InkWell(
                              onTap: () {
                                Get.offAndToNamed('/notFound');
                              },
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                "assets/images/icon_whatsapp.png",
                                height: 40,
                                width: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: Text(
                          'Вы можете найти нас здесь',
                          style: TextStyles.greyCaptionTextStyle
                              .copyWith(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
