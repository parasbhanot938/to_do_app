import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/bloc/login/login_bloc.dart';
import 'package:to_do_app/bloc/signup/signup_bloc.dart';
import 'package:to_do_app/constants/app_colors.dart';
import 'package:to_do_app/constants/app_strings.dart';
import 'package:to_do_app/ui/add_todo_screen.dart';
import 'package:to_do_app/ui/login_screen.dart';
import 'package:to_do_app/widgets/common_button.dart';
import 'package:to_do_app/widgets/common_text_field.dart';
import 'package:to_do_app/widgets/common_widgets.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: BlocConsumer<SignupBloc, SignupState>(
        listenWhen: (previous, current) => current is SignupActionState,
        buildWhen: (previous, current) => current is! SignupActionState,
        listener: (context, state) {
          if (state is ShowMessageActionState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(AppStrings.userAlreadyExistsPleaseSignIn),
              backgroundColor: AppColors.appColor,
            ));
          } else if (state is NavigateToAddTodoActionState) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  AddTodoScreen(email: state.email,),
                ));
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ));
          }
        },
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            alignment: Alignment.center,
            child: Form(
              key: context.read<SignupBloc>().formKey,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    AppStrings.welcomeOnboard,
                    style:
                        TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    AppStrings.letHelpYouMeetUpYourTask,
                    style: TextStyle(
                        fontSize: 14.0,
                        color: AppColors.appColor,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  CommonTextField(
                    hintText: AppStrings.enterFullName,
                    validator: (value) {
                      if (value == null || value == "") {
                        return AppStrings.pleaseEnterFullName;
                      } else {
                        return null;
                      }
                    },
                    onChanged: (p0) {
                      context
                          .read<SignupBloc>()
                          .add(OnChangedEvent(map: {"fullName": p0}));
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CommonTextField(
                    hintText: AppStrings.enterYourEmailAddress,
                    onChanged: (p0) {
                      context
                          .read<SignupBloc>()
                          .add(OnChangedEvent(map: {"emailAddress": p0}));
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
                    hintText: AppStrings.createPassword,
                    validator: (value) {
                      if (value == null || value == "") {
                        return AppStrings.pleaseEnterPasswprd;
                      } else {
                        return null;
                      }
                    },
                    onChanged: (p0) {
                      context
                          .read<SignupBloc>()
                          .add(OnChangedEvent(map: {"password": p0}));
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CommonTextField(
                    hintText: AppStrings.confirmPassword,
                    onChanged: (p0) {
                      context
                          .read<SignupBloc>()
                          .add(OnChangedEvent(map: {"confirmPassword": p0}));
                    },
                    validator: (value) {
                      if (value == null || value == "") {
                        return AppStrings.pleaseEnterConfirmPassowrd;
                      } else if (value ==
                          (context
                              .read<SignupBloc>()
                              .passwordController
                              .text)) {
                        return null;
                      } else {
                        return AppStrings.passwordDontMatch;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  CommonButton(
                    onPress: () {
                      context.read<SignupBloc>().add(SignupButtonPressedEvent(
                          fullName: context
                              .read<SignupBloc>()
                              .fullNameController
                              .text,
                          email:
                              context.read<SignupBloc>().emailController.text,
                          password: context
                              .read<SignupBloc>()
                              .confirmPassController
                              .text));
                    },
                    title:AppStrings.signup,
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  RichText(
                      text: TextSpan(children: [
                    TextSpan(
                        text: AppStrings.alreadyHaveAnAccount, style: textStyle),
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => context
                              .read<SignupBloc>()
                              .add(SignInClickedEvent()),
                        text: AppStrings.signIn,
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
