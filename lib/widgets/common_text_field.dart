import 'package:flutter/material.dart';
import 'package:to_do_app/constants/app_colors.dart';
import 'package:to_do_app/widgets/common_widgets.dart';

class CommonTextField extends StatelessWidget {
  final String? hintText;
  final String? initialValue;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final TextEditingController? textEditingController;
  final FocusNode? focusNode;

  CommonTextField(
      {super.key,
      this.validator,
      this.hintText,
      this.initialValue,
      this.textEditingController, this.focusNode, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // height: 45.0,
      child: TextFormField(
        cursorColor: AppColors.appColor,
        autovalidateMode: AutovalidateMode.onUserInteraction,
onChanged: onChanged,
        style: const TextStyle(fontSize: 14.0),
// controller: context.read<TodoBloc>().addTodoController,
        decoration: InputDecoration(
            // errorStyle: TextStyle(height: 0.2 , fontSize: 12),
            // errorMaxLines: 1,
            fillColor: AppColors.whiteColor,
            filled: true,
            hintText: hintText,
            hintStyle: textStyle,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(color: Colors.transparent)),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(color: Colors.red)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(color: Colors.transparent)),

            errorBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(color: Colors.transparent))),
        validator: validator ??
            (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a value';
              }
              return null;
            },
      ),
    );
  }
}
