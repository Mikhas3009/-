import 'package:eco_city/data/repositories/authenticationApiClient.dart';
import 'package:eco_city/domain/models/registration/registrationModel.dart'
    as regData;
import 'package:eco_city/domain/validation/registration/registrationValidate.dart';
import 'package:eco_city/presentation/widgets/buttons/generalButton.dart';
import 'package:eco_city/presentation/widgets/inputs/textField.dart';
import 'package:eco_city/utils/constants/colors.dart';
import 'package:eco_city/utils/constants/textStyles.dart';
import 'package:eco_city/utils/helpers/parsePhoneNumber.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController phoneController = TextEditingController();

  bool nextButtonPressed = false;

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
                          'Введите ваш номер телефона для верификации аккаунта',
                          style: TextStyles.greyCaptionTextStyle
                              .copyWith(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 12),
                        alignment: Alignment.center,
                        child: GeneralTextField(
                          controller: phoneController,
                          label: 'Phone',
                          keyboardType: TextInputType.phone,
                          validator: (value) =>
                              RegistrationValidate.validatePhone(
                                  value, nextButtonPressed),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        alignment: Alignment.center,
                        child: GeneralButton(
                          title: 'Далее',
                          isDisabled: false,
                          onPressed: () async {
                            setState(() {
                              nextButtonPressed = true;
                            });

                            final phoneValidationResult =
                                RegistrationValidate.validatePhone(
                                    phoneController.text, true);
                            regData.userPhone = phoneController.text;
                            if (phoneValidationResult == null) {
                              try {
                                AuthenticationApiClient().checkPhone(context,
                                    parsePhoneNumber(phoneController.text));
                              } catch (error) {
                                // ignore: avoid_print
                                print(error);
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
                            Get.offAndToNamed('/startScreen');
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
