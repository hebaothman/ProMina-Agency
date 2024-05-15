import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:untitled/core/utils/app_colors.dart';
import 'package:untitled/core/utils/constants.dart';
import 'package:untitled/core/utils/media_query_values.dart';
import 'package:untitled/features/login/domain/use_cases/login.dart';
import 'package:untitled/features/login/presentation/cubit/login_cubit.dart';
import 'package:untitled/features/login/presentation/widgets/email.dart';
import 'package:untitled/features/login/presentation/widgets/password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  Widget _loginButton() {
    return BlocListener(
      bloc: BlocProvider.of<LoginCubit>(context),
      listener: (context, state) {
        if(state is LoginLoadingState){
          Constants.showLoadingDialog(context);
        }else if (state is LoginLoadedState){
          Constants.hideLoadingDialog(context);
          // Navigator.pushReplacementNamed(context, Routes.applicantHomeRoute);
        }else if (state is LoginErrorState) {
          Constants.hideLoadingDialog(context);
          Constants.showDefaultSnackBar(context: context, text: state.error.toString());
        }
      },


      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SizedBox(
          width: context.width,
          height: (Device.get().isTablet) ? 70.0 : 50.0,
          child: TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: AppColors.blueColor,
                      width: 1,
                      style: BorderStyle.solid
                  ),
                  borderRadius: BorderRadius.circular(5)
              ),
              backgroundColor: AppColors.blueColor,
              foregroundColor: AppColors.whiteColor,
              textStyle: TextStyle(
                color: AppColors.whiteColor,
              ),
            ),
            onPressed: () {
              _submitLoginForm();
            },
            child: Text(
              "SUBMIT ",
              style: TextStyle(
                fontSize: (Device.get().isTablet) ? Theme.of(context).textTheme.labelLarge!.fontSize : Theme.of(context).textTheme.titleMedium!.fontSize,
                fontWeight: FontWeight.bold
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _contentBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: context.height/2.6),
          SizedBox(
              width: context.width/1.2,
              height: context.height/2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.whiteColor.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(25.0)
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: context.height/20),
                        Center(
                            child: Text(
                              'LOG IN',
                              style: TextStyle(
                                  fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
                                  fontWeight: FontWeight.bold
                              ),
                            )
                        ),
                        FormBuilder(
                          key: _fbKey,
                          autovalidateMode: AutovalidateMode.disabled,
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 25.0),
                                child: Email(),
                              ),
                              const Password(),
                              SizedBox(height: context.height/20),
                              _loginButton(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: false,
        // bottom: false,
        child: Center(
          child: Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover
              )
            ),
            child: _contentBody()
          ),
        ),
      ),
    );
  }

  void _submitLoginForm() async {
    if (_fbKey.currentState!.saveAndValidate()) {
      BlocProvider.of<LoginCubit>(context).userLogin(
        LoginParams(email: _fbKey.currentState!.value['email'], password: _fbKey.currentState!.value['password'])
      );
    }
  }

}
