import 'package:eco_city/data/repositories/apiClient.dart';
import 'package:eco_city/data/repositories/authenticationApiClient.dart';
import 'package:eco_city/domain/models/registration/registrationModel.dart'
    as regData;
import 'package:eco_city/domain/validation/registration/registrationValidate.dart';
import 'package:eco_city/presentation/widgets/buttons/generalButton.dart';
import 'package:eco_city/presentation/widgets/inputs/passwordField.dart';
import 'package:eco_city/presentation/widgets/inputs/textField.dart';
import 'package:eco_city/utils/constants/colors.dart';
import 'package:eco_city/utils/constants/textStyles.dart';
import 'package:eco_city/utils/helpers/parsePhoneNumber.dart';
import 'package:eco_city/utils/helpers/showSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalDataScreen extends StatefulWidget {
  const PersonalDataScreen({super.key});

  @override
  State<PersonalDataScreen> createState() => PersonalDataScreenState();
}

class PersonalDataScreenState extends State<PersonalDataScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  bool registrationButtonPressed = false;

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
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(
                            left: 20, right: 20, top: 100),
                        alignment: Alignment.center,
                        child: const Text(
                          'Регистрация',
                          style: TextStyles.bigHeadlineTextStyle,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        alignment: Alignment.center,
                        child: Text(
                          'Введите персональные данные',
                          style: TextStyles.greyCaptionTextStyle
                              .copyWith(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        alignment: Alignment.center,
                        child: GeneralTextField(
                          controller: nameController,
                          label: 'ФИО',
                          keyboardType: TextInputType.text,
                          validator: (value) =>
                              RegistrationValidate.validateName(
                                  value, registrationButtonPressed),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        alignment: Alignment.center,
                        child: GeneralTextField(
                          controller: emailController,
                          label: 'Email',
                          keyboardType: TextInputType.text,
                          validator: (value) =>
                              RegistrationValidate.validateEmail(
                                  value, registrationButtonPressed),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        alignment: Alignment.center,
                        child: GeneralTextField(
                          controller: addressController,
                          label: 'Адрес',
                          keyboardType: TextInputType.text,
                          validator: (value) =>
                              RegistrationValidate.validateAddress(
                                  value, registrationButtonPressed),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        alignment: Alignment.center,
                        child: GeneralPasswordField(
                          controller: passwordController,
                          label: 'Пароль',
                          validator: (value) =>
                              RegistrationValidate.validatePassword(
                                  value, registrationButtonPressed),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        alignment: Alignment.center,
                        child: GeneralPasswordField(
                          controller: passwordConfirmController,
                          label: 'Подтвердите пароль',
                          validator: (value) =>
                              RegistrationValidate.validatePassword(
                                  value, registrationButtonPressed),
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
                              registrationButtonPressed = true;
                            });

                            final nameValidationResult =
                                RegistrationValidate.validateName(
                                    nameController.text, true);
                            final emailValidationResult =
                                RegistrationValidate.validateEmail(
                                    emailController.text, true);
                            final addressValidationResult =
                                RegistrationValidate.validateAddress(
                                    addressController.text, true);
                            final passwordValidationResult =
                                RegistrationValidate.validatePassword(
                                    passwordController.text, true);
                            final passwordConfirmValidationResult =
                                RegistrationValidate.validatePassword(
                                    passwordConfirmController.text, true);

                            if (nameValidationResult == null &&
                                emailValidationResult == null &&
                                addressValidationResult == null &&
                                passwordValidationResult == null &&
                                passwordConfirmValidationResult == null) {
                              print(
                                  '${parsePhoneNumber(regData.userPhone)} ${nameController.text} ${emailController.text} ${addressController.text} ${passwordController.text} ${passwordConfirmController.text}');
                              if (passwordController.text ==
                                  passwordConfirmController.text) {
                                try {
                                  AuthenticationApiClient().register(
                                      context,
                                      nameController.text,
                                      parsePhoneNumber(regData.userPhone),
                                      'dsadsadsadsadas',
                                      passwordController.text,
                                      emailController.text,
                                      addressController.text,
                                      'Ekatirenburg');
                                } catch (error) {
                                  // ignore: avoid_print
                                  print(error);
                                }
                              } else {
                                showSnackBar(context, 'Пароли не совпадают');
                              }
                            } else {
                              print('=====VALIDATION ERROR=====');
                            }
                          },
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
