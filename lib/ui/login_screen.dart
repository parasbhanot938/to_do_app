import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/bloc/login/login_bloc.dart';
import 'package:to_do_app/bloc/signup/signup_bloc.dart';
import 'package:to_do_app/constants/app_colors.dart';
import 'package:to_do_app/constants/app_images.dart';
import 'package:to_do_app/constants/app_strings.dart';
import 'package:to_do_app/ui/add_todo_screen.dart';
import 'package:to_do_app/ui/signup_screen.dart';
import 'package:to_do_app/widgets/common_button.dart';
import 'package:to_do_app/widgets/common_text_field.dart';
import 'package:to_do_app/widgets/common_widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: BlocConsumer<LoginBloc, LoginState>(
        listenWhen: (previous, current) => current is LoginActionState,
        buildWhen: (previous, current) => current is! LoginActionState,
        listener: (context, state) {
          if (state is ShowSnackBarActionState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.messsage),
              backgroundColor: AppColors.appColor,
            ));
          } else if (state is NavigatToSignupActionState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SignupScreen(),
                ));
          } else if (state is NavigateToTodoScreenActionState) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTodoScreen(
                    email: state.email,
                  ),
                ));
          }
        },
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            alignment: Alignment.center,
            child: Form(
              key: context.read<LoginBloc>().formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    AppStrings.welcomeBack,
                    style:
                        TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  imageAsset(
                      image: AppImages.boy,
                      height: MediaQuery.of(context).size.height * 0.3),
                  const SizedBox(
                    height: 40,
                  ),
                  CommonTextField(
                    hintText: AppStrings.enterYourEmailAddress,
                    onChanged: (p0) {
                      context
                          .read<LoginBloc>()
                          .add(OnChangeEvent(map: {"emailAddress": p0}));
                    },
                    validator: (value) {
                      if (value == null || value == "") {
                        return AppStrings.pleaseEnterEmail;
                      } else if (!isValidEmail(value)) {
                        return AppStrings.pleaseEnterValidEmail;
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CommonTextField(
                    hintText: AppStrings.enterPassword,
                    validator: (value) {
                      if (value == null || value == "") {
                        return AppStrings.pleaseEnterPassword;
                      } else {
                        return null;
                      }
                    },
                    onChanged: (p0) {
                      context
                          .read<LoginBloc>()
                          .add(OnChangeEvent(map: {"password": p0}));
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  CommonButton(
                    onPress: () {
                      context.read<LoginBloc>().add(SignInButtonPressedEvent(
                            email:
                                context.read<LoginBloc>().emailController.text,
                            password: context
                                .read<LoginBloc>()
                                .passwordController
                                .text,
                          ));
                    },
                    title: AppStrings.signIn,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: AppStrings.dontHaveAnAccount, style: textStyle),
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => context
                              .read<LoginBloc>()
                              .add(SignUpClickedEvent()),
                        text: AppStrings.signup,
                        style: textStyle.copyWith(
                            color: AppColors.appColor,
                            fontWeight: FontWeight.bold)),
                  ]))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
