import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:untitled/core/utils/app_colors.dart';
import 'package:untitled/core/utils/constants.dart';

class Password extends StatelessWidget {
  const Password({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var validators = FormBuilderValidators.compose([
      FormBuilderValidators.required(),
      FormBuilderValidators.minLength(3, errorText: 'Password must be greater than 3'),
    ]);
    return Constants.commonTextForm(context: context, name: "password", hintText: 'Password', validators: validators, keyboardType: TextInputType.emailAddress, textCapitalization: TextCapitalization.none, fillColor: AppColors.whiteColor, textColor: AppColors.darkGreyColor, passwordField: true);
  }
}
