import 'package:eco_city/data/repositories/authenticationApiClient.dart';
import 'package:eco_city/domain/validation/authorization/authorizationValidate.dart';
import 'package:eco_city/presentation/widgets/buttons/lightButton.dart';
import 'package:eco_city/presentation/widgets/checkboxes/checkbox.dart';
import 'package:eco_city/presentation/widgets/inputs/passwordField.dart';
import 'package:eco_city/presentation/widgets/inputs/textField.dart';
import 'package:eco_city/utils/constants/colors.dart';
import 'package:eco_city/utils/constants/textStyles.dart';
import 'package:eco_city/utils/helpers/parsePhoneNumber.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthorizationScreen extends StatefulWidget {
  const AuthorizationScreen({super.key});

  @override
  State<AuthorizationScreen> createState() => AuthorizationScreenState();
}

class AuthorizationScreenState extends State<AuthorizationScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool loginButtonPressed = false;

  bool isRemember = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
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
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 40),
                        child: const Text(
                          'С возвращением!',
                          style: TextStyles.generalHeadlineTextStyle,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 30),
                        child: GeneralTextField(
                          controller: phoneController,
                          label: 'Phone',
                          keyboardType: TextInputType.phone,
                          validator: (value) =>
                              AuthorizationValidate.validatePhone(
                                  value, loginButtonPressed),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: GeneralPasswordField(
                          controller: passwordController,
                          label: 'Password',
                          validator: (value) =>
                              AuthorizationValidate.validatePassword(
                                  value, loginButtonPressed),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GeneralCheckbox(
                              value: isRemember,
                              label: 'Запомнить меня',
                              onChanged: (value) {
                                setState(() {
                                  isRemember = !isRemember;
                                });
                              },
                            ),
                            InkWell(
                              onTap: () {
                                Get.offAndToNamed('/restorePassword');
                              },
                              borderRadius: BorderRadius.circular(6),
                              child: const Text(
                                'Забыли пароль?',
                                style: TextStyles.greyCaptionTextStyle,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: LightButton(
                          title: 'Войти',
                          isDisabled: false,
                          onPressed: () async {
                            setState(() {
                              loginButtonPressed = true;
                            });

                            final phoneValidationResult =
                                AuthorizationValidate.validatePhone(
                                    phoneController.text, true);

                            final passwordValidationResult =
                                AuthorizationValidate.validatePassword(
                                    passwordController.text, true);

                            if (phoneValidationResult == null &&
                                passwordValidationResult == null) {
                              try {
                                AuthenticationApiClient().login(
                                    context,
                                    parsePhoneNumber(phoneController.text),
                                    passwordController.text);
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
                        alignment: Alignment.center,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: const Text(
                          'Новый пользователь?',
                          style: TextStyles.greyCaptionTextStyle,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 10),
                        child: InkWell(
                          onTap: () {
                            Get.offAndToNamed('/registration');
                          },
                          borderRadius: BorderRadius.circular(6),
                          child: const Text(
                            'Зарегистрируйтесь!',
                            style: TextStyles.greenCaptionTextStyle,
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
