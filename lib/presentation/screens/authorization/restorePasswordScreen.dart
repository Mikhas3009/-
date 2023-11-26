import 'package:eco_city/data/repositories/apiClient.dart';
import 'package:eco_city/domain/validation/authorization/authorizationValidate.dart';
import 'package:eco_city/presentation/widgets/buttons/generalButton.dart';
import 'package:eco_city/presentation/widgets/inputs/textField.dart';
import 'package:eco_city/utils/constants/colors.dart';
import 'package:eco_city/utils/constants/textStyles.dart';
import 'package:eco_city/utils/helpers/parsePhoneNumber.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestorePasswordScreen extends StatefulWidget {
  const RestorePasswordScreen({super.key});

  @override
  State<RestorePasswordScreen> createState() => RestorePasswordScreenState();
}

class RestorePasswordScreenState extends State<RestorePasswordScreen> {
  TextEditingController phoneController = TextEditingController();

  bool sendPasswordButtonPressed = false;

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
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 40),
                        child: const Text(
                          'Восстановление пароля',
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
                                  value, sendPasswordButtonPressed),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: GeneralButton(
                          title: 'Отправить пароль',
                          isDisabled: false,
                          onPressed: () async {
                            setState(() {
                              sendPasswordButtonPressed = true;
                            });

                            final phoneValidationResult =
                                AuthorizationValidate.validatePhone(
                                    phoneController.text, true);

                            if (phoneValidationResult == null) {
                              print(parsePhoneNumber(phoneController.text));

                              final requestData = {
                                'phone': parsePhoneNumber(phoneController.text),
                              };

                              try {
                                final response = await ApiClient()
                                    .post('restorePassword', requestData);
                                print(
                                    'Response status code: ${response.statusCode}');
                                print('Response body: ${response.body}');
                              } catch (e) {
                                print('Error: $e');
                              }

                              print("SUCCESS");
                            } else {
                              print("ERRORS");
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
                            Get.offAndToNamed('/authorization');
                          },
                          borderRadius: BorderRadius.circular(6),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Перейти к авторизации',
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
