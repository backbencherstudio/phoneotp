import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:albertyg/view/widgets/primary_button.dart';
import '../../model_view/login_screen_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController controller = TextEditingController();
  final ValueNotifier<PhoneNumber> numberNotifier =
      ValueNotifier(PhoneNumber(isoCode: 'NG'));

  @override
  void dispose() {
    controller.dispose();
    numberNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 100.h),
                  Text(
                    "Enter your phone number",
                    style:
                        TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16.h),
                  ValueListenableBuilder<PhoneNumber>(
                    valueListenable: numberNotifier,
                    builder: (context, phoneNumber, child) {
                      return InternationalPhoneNumberInput(
                        onInputChanged: (PhoneNumber number) {
                          numberNotifier.value = number;
                        },
                        selectorConfig: const SelectorConfig(
                          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                          useBottomSheetSafeArea: true,
                        ),
                        autoValidateMode: AutovalidateMode.onUserInteraction,
                        textFieldController: controller,
                        formatInput: true,
                        keyboardType: const TextInputType.numberWithOptions(
                          signed: true,
                          decimal: false,
                        ),
                        inputDecoration: InputDecoration(
                          hintText: "Enter Phone No",
                          hintStyle: TextStyle(fontSize: 14.sp),
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.phone),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1),
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1),
                          ),
                          errorBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 1),
                          ),
                          focusedErrorBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 1),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 32.h),
                  Consumer<LoginScreenProvider>(
                      builder: (_, loginScreenProvider, child) {
                    return loginScreenProvider.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                            color: Color(0xFF04505A),
                          ))
                        : PrimaryButton(
                            title: "Submit",
                            onTap: loginScreenProvider.isLoading
                                ? () {
                                    debugPrint("\nWait, button is loading!\n");
                                  }
                                : () async {
                                    debugPrint("\nSubmit Button Pressed\n");
                                    if (formKey.currentState!.validate()) {
                                      String phoneNumber =
                                          numberNotifier.value.phoneNumber ??
                                              "";
                                      await loginScreenProvider.sendOTP(
                                          context, phoneNumber);
                                      debugPrint("\nEnd of sending otp\n");

                                    }
                                  },
                          );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
