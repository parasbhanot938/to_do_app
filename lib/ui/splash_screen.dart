import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:to_do_app/bloc/splash/splash_bloc.dart';
import 'package:to_do_app/constants/app_images.dart';
import 'package:to_do_app/main.dart';
import 'package:to_do_app/ui/add_todo_screen.dart';
import 'package:to_do_app/ui/signup_screen.dart';
import 'package:to_do_app/widgets/common_widgets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SplashBloc>().add(FetchInitialEvent());

    return Scaffold(
      body: BlocListener<SplashBloc, SplashState>(
        listenWhen: (previous, current) => current is SplashActionState,
        listener: (context, state) {
          if(state is NavigateToSignupActionState){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SignupScreen(),));
          }
          else if(state is NavigateToAddTodoScreenActionState){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  AddTodoScreen(email: state.userModel.email,),));


          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              imageAsset(
                height:MediaQuery.of(context).size.height*0.25,
                fit: BoxFit.fitHeight,
                image:
                AppImages.girlSitting,
              ),
              const Text('Get things done with TODo',style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.w600),)
            ],
          ),
        ),
      ),

    );
  }
}
