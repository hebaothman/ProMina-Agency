import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:untitled/core/utils/app_colors.dart';
import 'package:untitled/core/utils/constants.dart';

class Email extends StatelessWidget {
  const Email({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var validators = FormBuilderValidators.compose([
      FormBuilderValidators.required(),
      FormBuilderValidators.email(errorText: "Email must be valid")
    ]);
    return Constants.commonTextForm(context: context, name: "email", hintText: 'Email', validators: validators, keyboardType: TextInputType.emailAddress, textCapitalization: TextCapitalization.none, fillColor: AppColors.whiteColor, textColor: AppColors.darkGreyColor);
  }
}
