import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/core/utils/app_colors.dart';
import 'package:untitled/core/utils/constants.dart';
import 'package:untitled/core/utils/media_query_values.dart';
import 'package:untitled/features/gallery/domain/use_cases/get_images.dart';
import 'package:untitled/features/gallery/domain/use_cases/upload.dart';
import 'package:untitled/features/gallery/presentation/cubit/upload_cubit.dart';
import 'package:untitled/features/login/domain/entities/userToken.dart';

class GalleryScreen extends StatefulWidget {
  final UserToken userToken;
  const GalleryScreen({super.key, required this.userToken});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  var _imageFile;
  
  @override
  void initState(){
    BlocProvider.of<UploadCubit>(context).getImages(
      TokenParams(token: widget.userToken.token,)
    );
    super.initState();
  }

  Widget _galleryButton() {
    return GestureDetector(
      onTap: (){
        Constants().onImageButtonPressed(ImageSource.gallery).then((value){
          setState(() {
            if(value.runtimeType == XFile) {
              _imageFile = value;
              _uploadImage();
            } else{
              print(value);
              Constants.showDefaultSnackBar(context: context, text: value);
            }
          });
        });
        Navigator.of(context, rootNavigator: true).pop("Discard");
      },
      child: Container(
        height: context.height/10,
        width: context.width/2.0,
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(30.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: AppColors.purpleColor,
        ),
        child: Row(
          children: [
            Image.asset('assets/images/upload.png'),
            Text('Gallery', style: TextStyle(fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize),),
          ],
        ),
      ),
    );
  }

  Widget _cameraButton() {
    return GestureDetector(
      onTap: (){
        Constants().onImageButtonPressed(ImageSource.camera).then((value){
          setState(() {
            if(value.runtimeType == XFile) {
              _imageFile = value;
              _uploadImage();
            } else{
              print(value);
              Constants.showDefaultSnackBar(context: context, text: value);
            }
          });
        });
        Navigator.of(context, rootNavigator: true).pop("Discard");
      },
      child: Container(
        height: context.height/10,
        width: context.width/2.0,
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(30.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: AppColors.purpleColor,
        ),
        child: Row(
          children: [
            Image.asset('assets/images/upload.png'),
            Text('Camera', style: TextStyle(fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize),),
          ],
        ),
      ),
    );
  }

  Widget _popUpWindow() {
    return BlocListener(
      bloc: BlocProvider.of<UploadCubit>(context),
      listener: (context, state) {
        if(state is UploadLoadingState){
          Constants.showLoadingDialog(context);
        }else if (state is UploadLoadedState){
          Constants.hideLoadingDialog(context);
          Constants.showDefaultSnackBar(context: context, text: state.uploadImage.message);
        }else if (state is UploadErrorState) {
          Constants.hideLoadingDialog(context);
          Constants.showDefaultSnackBar(context: context, text: state.error.toString());
        }
      },
      child: SizedBox(
        width: context.width/1.2,
        height: context.height/2.5,
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
                  _galleryButton(),
                  _cameraButton(),
                ],
              ),
            ),
          ),
        )
    ),
);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          top: false,
          bottom: false,
          child: Center(
            child: Container(
              constraints: const BoxConstraints.expand(),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/gallery.png'),
                  fit: BoxFit.fill
                )
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: context.height/20,
                    left: 15,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome',
                          style: TextStyle(
                            fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize
                          ),
                        ),
                        Text(
                          widget.userToken.user.name,
                          style: TextStyle(
                            fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize
                          ),
                        )
                      ],
                    )
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: Image.asset(
                      'assets/images/profile.png'
                    )
                  ),
                  Positioned(
                    top: context.height/6,
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (){

                          },
                          child: Container(
                            height: context.height/14,
                            width: context.width/3,
                            padding: const EdgeInsets.all(10.0),
                            margin: const EdgeInsets.all(30.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: AppColors.whiteColor,
                            ),
                            child: Row(
                              children: [
                                Image.asset('assets/images/logout.png'),
                                const Text('log out'),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            showDialog(context:context, builder: (BuildContext context){
                              return Dialog(
                                backgroundColor: Colors.transparent,
                                insetPadding: const EdgeInsets.all(10),
                                child: _popUpWindow(),
                              );
                            });
                          },
                          child: Container(
                            height: context.height/14,
                            width: context.width/3,
                            padding: const EdgeInsets.all(10.0),
                            margin: const EdgeInsets.all(30.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: AppColors.whiteColor,
                            ),
                            child: Row(
                              children: [
                                Image.asset('assets/images/upload.png'),
                                const Text('upload'),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // BlocBuilder(
                  //     builder: (_, state) {
                  //       if(state is GetImagesLoadingState){
                  //         return Constants.circularIndicator(context);
                  //       }else if (state is GetImagesLoadedState) {
                  //         List images = state.uploadImage.data;
                  //         return Padding(
                  //           padding: EdgeInsets.only(top: context.height/3,),
                  //           child: GridView.builder(
                  //             shrinkWrap: true,
                  //             padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  //             gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                  //               crossAxisCount: 3,
                  //               mainAxisSpacing: 10,
                  //               crossAxisSpacing: 10,
                  //             ),
                  //             itemCount: images.length,
                  //             itemBuilder: (context, index) {
                  //               return Container(
                  //                 decoration: BoxDecoration(
                  //                   borderRadius: BorderRadius.circular(25.0),
                  //                 ),
                  //                 child: Center(child: Image.network(images[index])),
                  //               );
                  //             },
                  //           ),
                  //         );
                  //       }else if (state is GetImagesErrorState) {
                  //         return Constants.errorText(context, state.error.toString());
                  //       }
                  //       return Container();
                  //     }
                  // )

                ],
              )
            ),
          )
      ),
    );
  }

  void _uploadImage() async {
    if (_imageFile != null) {
      BlocProvider.of<UploadCubit>(context).imageUpload(
        TokenImageParams(token: widget.userToken.token, imagePath: _imageFile.path, imageName: 'img')
      );
    } else {
      Constants.showDefaultSnackBar(context: context, text: 'Your image must be picked before uploading');
    }
  }

}

class UserNameArguments extends Equatable{
  final UserToken userToken;

  const UserNameArguments({required this.userToken});

  @override
  List<Object?> get props => [userToken];



}