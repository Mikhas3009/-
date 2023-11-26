import 'dart:async';
import 'package:eco_city/data/repositories/authenticationApiClient.dart';
import 'package:eco_city/domain/models/registration/registrationModel.dart'
    as regData;
import 'package:eco_city/domain/validation/registration/registrationValidate.dart';
import 'package:eco_city/presentation/widgets/buttons/generalButton.dart';
import 'package:eco_city/presentation/widgets/buttons/lightButton.dart';
import 'package:eco_city/presentation/widgets/inputs/textField.dart';
import 'package:eco_city/utils/constants/colors.dart';
import 'package:eco_city/utils/constants/textStyles.dart';
import 'package:eco_city/utils/helpers/showSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifyPhoneScreen extends StatefulWidget {
  const VerifyPhoneScreen({super.key});

  @override
  State<VerifyPhoneScreen> createState() => VerifyPhoneScreenState();
}

class VerifyPhoneScreenState extends State<VerifyPhoneScreen> {
  TextEditingController codeController = TextEditingController();

  bool nextButtonPressed = false;

  int seconds = 30;

  @override
  void initState() {
    super.initState();
    startTimer();
    AuthenticationApiClient().verifyPhone(context, '1234567890');
  }

  void startTimer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        setState(() {
          seconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  String getFormattedTime() {
    String formattedSeconds = seconds < 10 ? '0$seconds' : '$seconds';
    return '00:$formattedSeconds';
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
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: Image.asset(
                          "assets/images/registration_header.png",
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 30),
                        alignment: Alignment.center,
                        child: const Text(
                          'Регистрация',
                          style: TextStyles.bigHeadlineTextStyle,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 12),
                        alignment: Alignment.center,
                        child: Text(
                          'Введите код, отправленный на номер',
                          style: TextStyles.greyCaptionTextStyle
                              .copyWith(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        alignment: Alignment.center,
                        child: Text(
                          regData.userPhone,
                          style: TextStyles.greenCaptionTextStyle
                              .copyWith(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 30),
                        alignment: Alignment.center,
                        child: GeneralTextField(
                          controller: codeController,
                          label: 'Code',
                          keyboardType: TextInputType.number,
                          maxlength: 4,
                          validator: (value) =>
                              RegistrationValidate.validateCode(
                                  value, nextButtonPressed),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: Text(
                          getFormattedTime(),
                          style: TextStyles.greyCaptionTextStyle,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: LightButton(
                          title: 'Повторить код',
                          isDisabled:
                              getFormattedTime() == '00:00' ? false : true,
                          onPressed: () {
                            setState(() {
                              seconds = 30;
                              startTimer();
                              AuthenticationApiClient()
                                  .verifyPhone(context, '21321312312');
                            });
                          },
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: GeneralButton(
                          title: 'Далее',
                          isDisabled: false,
                          onPressed: () {
                            setState(() {
                              nextButtonPressed = true;
                            });

                            final codeValidationResult =
                                RegistrationValidate.validateCode(
                                    codeController.text, true);

                            if (codeValidationResult == null) {
                              if (codeController.text == regData.userCode) {
                                Get.offAndToNamed('/personalData');
                              } else {
                                showSnackBar(context, 'Неверно введенный код');
                              }
                            } else {
                              print('=====VALIDATION ERROR=====');
                            }
                          },
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: InkWell(
                          onTap: () {
                            Get.offAndToNamed('/registration');
                          },
                          borderRadius: BorderRadius.circular(6),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Вернуться назад',
                                style: TextStyles.greenCaptionTextStyle,
                              ),
                              Icon(
                                Icons.arrow_right_alt_rounded,
                                color: AppColors.greenColor,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
