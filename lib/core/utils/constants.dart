import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:untitled/core/utils/app_colors.dart';

class Constants{
  static Widget commonTextForm({required BuildContext context, required String name, TextEditingController? controller, String? hintText, Icon? icon, String? Function(String?)? validators, required TextInputType keyboardType, required TextCapitalization textCapitalization, List<TextInputFormatter>? inputFormatter, bool? passwordField, Function(String?)? onChanged, required Color textColor, required Color fillColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 7.5),
      child: FormBuilderTextField(
        name: name,
        controller: controller,
        // This style is for text field text color
        style: TextStyle(fontSize: Theme.of(context).textTheme.titleMedium!.fontSize, color: textColor),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(fontSize: Theme.of(context).textTheme.titleMedium!.fontSize, color: textColor),
          prefix: const Padding(
            padding: EdgeInsets.all(5.0),
          ),
          contentPadding: (Device.get().isTablet) ? const EdgeInsets.symmetric(vertical: 30.0) : const EdgeInsets.symmetric(vertical: 12.0),
          filled: true,
          fillColor: fillColor,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.errorBorderColor),
            borderRadius: BorderRadius.circular(25.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.whiteColor.withOpacity(0.47)),
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
        validator: validators,
        textAlign: TextAlign.start,
        keyboardType: keyboardType,
        textCapitalization: textCapitalization,
        inputFormatters: inputFormatter,
        onChanged: onChanged,
        obscureText: (passwordField != null) ? passwordField : false,
      ),
    );
  }
  //Normal and Bold Texts
  static Widget boldText({required BuildContext context, required String text, int? maxLines, Color? color, double? fontSize}){
    return AutoSizeText(
      text,
      style: TextStyle(
          color: (color != null) ? color : Theme.of(context).primaryColorDark,
          fontSize: (fontSize != null) ? fontSize : (Device.get().isTablet) ? Theme.of(context).textTheme.headlineSmall!.fontSize : Theme.of(context).textTheme.titleMedium!.fontSize,
          fontWeight: FontWeight.bold
      ),
      maxLines: (maxLines != null) ? maxLines : 1,
    );
  }
  static Widget normalText({required BuildContext context, required String text, int? maxLines, Color? color, TextDecoration? textDecoration, double? fontSize, TextDirection? textDirection}){
    return AutoSizeText(
      text,
      style: TextStyle(
        color: (color != null) ? color : AppColors.blackColor,
        fontSize: (fontSize != null) ? fontSize : (Device.get().isTablet) ? Theme.of(context).textTheme.titleLarge!.fontSize : Theme.of(context).textTheme.titleSmall!.fontSize,
        decoration: textDecoration
      ),
      maxLines: (maxLines != null) ? maxLines : 1,
      textDirection: (textDirection != null) ? textDirection : TextDirection.ltr,
    );
  }
  //No Data Found and Circular Indicator Widget
  static Widget noData(BuildContext context, Color textColor) {
    return Center(
        child: Text(
            'No Data Found',
            style: TextStyle(
                color: textColor,
                fontSize: (Device.get().isTablet) ? Theme.of(context).textTheme.headlineSmall!.fontSize : Theme.of(context).textTheme.titleMedium!.fontSize,
                fontWeight: FontWeight.bold
            )
        )
    );
  }
  static Widget circularIndicator(BuildContext context) {
    return SimpleDialog(
      backgroundColor: Colors.transparent,
      children: <Widget>[
        Center(
          child: Card(
            child: Container(
              color: Colors.transparent,
              width: 80,
              height: 80,
              padding: const EdgeInsets.all(12.0),
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
  static Widget errorText(BuildContext context, String msg) {
    return Center(child: Constants.normalText(context: context, text: msg));
  }
  static void showDefaultSnackBar({required BuildContext context, required String text, VoidCallback? onPress, bool? showDuration}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Theme.of(context).primaryColor,

        content: Text(
          text,
          style: TextStyle(
              color: Theme.of(context).canvasColor,
              fontSize: (Device.get().isTablet) ? Theme.of(context).textTheme.headlineSmall!.fontSize : Theme.of(context).textTheme.titleMedium!.fontSize,
              fontWeight: FontWeight.bold
          ),
        ),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {
            if (showDuration == null) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            } else {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
            }
            if(onPress != null) {
              onPress();
            }
          },
        ),
        duration: (showDuration == null) ? const Duration(seconds: 5) : const Duration(seconds: 10),
      ),
    );
  }
  ///Loading Dialog
  static Widget loadingDialog(BuildContext context){
    return PopScope(
      canPop: true,
      onPopInvoked : (didPop) async => false,
      child: Center(
        child: Card(
          child: Container(
            color: Colors.transparent,
            width: 80,
            height: 80,
            padding: const EdgeInsets.all(12.0),
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }
  static void showLoadingDialog(BuildContext context, {Key? key}) => showDialog<void>(context: context, useRootNavigator: false, barrierDismissible: false, builder: (_) => loadingDialog(context),).then((_) => FocusScope.of(context).requestFocus(FocusNode()));
  static void hideLoadingDialog(BuildContext context) => Navigator.pop(context);
}