import 'dart:io';
import 'package:email_auth/email_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:myapp/controller/authentication_controller.dart';
import 'package:myapp/model/user_model.dart';
import 'package:myapp/screen/authentication_screen/login_screen.dart';
import 'package:myapp/screen/authentication_screen/verification_otp_screen.dart';
import 'package:myapp/services/current_location/get_current_location.dart';
import 'package:myapp/utils/colors.dart';
import 'package:myapp/widgets/our_elevated_button.dart';
import 'package:myapp/widgets/our_flutter_toast.dart';
import 'package:myapp/widgets/our_password_field.dart';
import 'package:myapp/widgets/our_sized_box.dart';
import 'package:myapp/widgets/our_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  File? file;

  TextEditingController _name_controller = TextEditingController();
  TextEditingController _phone_controller = TextEditingController();
  TextEditingController _email_controller = TextEditingController();
  TextEditingController _password_controller = TextEditingController();
  TextEditingController _location_controller = TextEditingController();

  final _name_node = FocusNode();
  final _phone_node = FocusNode();
  final _email_node = FocusNode();
  final _password_node = FocusNode();

  pickImage() async {
    try {
      final picker = ImagePicker();

      XFile? result = await picker.pickImage(source: ImageSource.gallery);
      if (result != null) {
        setState(() {});
        file = File(result.path);
      } else {
        // User canceled the picker
      }
    } catch (e) {
      print("$e =========");
    }
  }

  sendOTP(UserModel usermodel) async {
    print("Inside send OTP screen");
    Get.find<AuthenticationController>().toggle(true);

    EmailAuth emailAuth = EmailAuth(sessionName: "Sample session");
    bool result = await emailAuth.sendOtp(
        recipientMail: _email_controller.value.text, otpLength: 5);
    if (result) {
      OurToast().showSuccessToast("OTP Sent");
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return VerificationOtpScreen(
          usermodel: usermodel,
          file: file!,
        );
      }));
      Get.find<AuthenticationController>().toggle(false);
    } else {
      OurToast().showSuccessToast("Oops, OTP sending failed");
      Get.find<AuthenticationController>().toggle(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Obx(
          () => ModalProgressHUD(
            progressIndicator: SpinKitFadingCircle(
              size: ScreenUtil().setSp(60),
              itemBuilder: (BuildContext context, int index) {
                return DecoratedBox(
                  decoration: BoxDecoration(
                    color: index.isEven ? logoColor : Colors.green,
                  ),
                );
              },
            ),
            inAsyncCall: Get.find<AuthenticationController>().processing.value,
            child: Scaffold(
              body: SafeArea(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setSp(20),
                    vertical: ScreenUtil().setSp(10),
                  ),
                  child: SingleChildScrollView(
                      child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          pickImage();
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                            ScreenUtil().setSp(20),
                          ),
                          child: Container(
                            child: file == null
                                ? Image.asset(
                                    "assets/images/user_icon.png",
                                    height: ScreenUtil().setSp(200),
                                    width: ScreenUtil().setSp(200),
                                  )
                                : Image.file(
                                    file!,
                                    height: ScreenUtil().setSp(200),
                                    width: ScreenUtil().setSp(200),
                                    fit: BoxFit.fitWidth,
                                  ),
                          ),
                        ),
                      ),
                      const OurSizedBox(),
                      CustomTextField(
                        start: _name_node,
                        end: _email_node,
                        icon: Icons.person,
                        controller: _name_controller,
                        validator: (value) {},
                        title: "Name",
                        type: TextInputType.name,
                        number: 0,
                      ),
                      const OurSizedBox(),
                      CustomTextField(
                        start: _email_node,
                        end: _password_node,
                        icon: Icons.mail,
                        controller: _email_controller,
                        validator: (value) {},
                        title: "Email",
                        type: TextInputType.emailAddress,
                        number: 0,
                      ),
                      const OurSizedBox(),
                      PasswordForm(
                        start: _password_node,
                        end: _phone_node,
                        controller: _password_controller,
                        validator: (value) {},
                        title: "Password",
                        number: 0,
                      ),
                      const OurSizedBox(),
                      CustomTextField(
                        start: _phone_node,
                        icon: Icons.phone,
                        controller: _phone_controller,
                        validator: (value) {},
                        title: "Phone",
                        type: TextInputType.number,
                        number: 1,
                      ),
                      const OurSizedBox(),
                      CustomTextField(
                          // length: 5,
                          icon: Icons.location_on,
                          // readonly: true,
                          type: TextInputType.name,
                          controller: _location_controller,
                          title: "Location",
                          validator: (value) {},
                          number: 1),
                      const OurSizedBox(),
                      OurElevatedButton(
                        title: "Get my current location",
                        function: () async {
                          Get.find<AuthenticationController>().toggle(true);
                          String? location =
                              await GetCurrentLocation().getCurrentLocation();
                          setState(() {
                            _location_controller.text = location!;
                            print("===============");
                            print(_location_controller.text);
                          });
                          Get.find<AuthenticationController>().toggle(false);
                        },
                      ),
                      OurSizedBox(),
                      OurElevatedButton(
                        title: "Send OTP to email",
                        function: () {
                          if (file == null) {
                            OurToast().showErrorToast("Select profile image");
                          } else if (_name_controller.text.trim().isEmpty ||
                              _phone_controller.text.trim().isEmpty ||
                              _email_controller.text.trim().isEmpty ||
                              _password_controller.text.trim().isEmpty ||
                              _location_controller.text.trim().isEmpty) {
                            OurToast().showErrorToast("Fields can't be empty");
                          } else {
                            UserModel userModel = UserModel(
                              name: _name_controller.text.trim(),
                              email: _email_controller.text.trim(),
                              password: _password_controller.text.trim(),
                              phone: _phone_controller.text.trim(),
                              location: _location_controller.text.trim(),
                            );
                            sendOTP(userModel);
                          }
                        },
                      ),
                    ],
                  )),
                ),
              ),
              bottomNavigationBar: Container(
                alignment: Alignment.center,
                height: ScreenUtil().setSp(30),
                width: double.infinity,
                margin: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setSp(20),
                  vertical: ScreenUtil().setSp(10),
                ),
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                            text: "Already have an account?  ",
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(20),
                              // color: Colors.black,
                              fontWeight: FontWeight.w600,
                            )
                            // style: paratext,
                            ),
                        TextSpan(
                          text: 'Login',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return const LoginScreen();
                              }));
                            },
                          style: TextStyle(
                            color: logoColor,
                            fontWeight: FontWeight.w600,
                            fontSize: ScreenUtil().setSp(20),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
