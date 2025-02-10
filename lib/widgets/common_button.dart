import 'package:flutter/material.dart';
import 'package:to_do_app/constants/app_colors.dart';

class CommonButton extends StatelessWidget {
  final String title;
  VoidCallback onPress;

  CommonButton({super.key, required this.title, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.5,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.appColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5), // Add border radius here
            ),
          ),
          onPressed: onPress,
          child: Text(title,style: const TextStyle(color: AppColors.whiteColor,fontSize: 14.0,fontWeight:
          FontWeight.w500
          ),)),
    );
  }
}
