import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:step_counter/core/constants/texts.dart';

import '../../auth/views/login_page.dart';
import '../view_models.dart/profile_page_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ProfilePageModel {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    TextStyle? textStyle =
        themeData.textTheme.bodyMedium?.copyWith(color: appColors.whiteColor);

    return SafeArea(
      child: Scaffold(
          body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 100.w,
              height: 35.h,
              decoration: BoxDecoration(color: appColors.scaffoldBack),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    pickedFile != null
                        ? CircleAvatar(
                            radius: 24.w,
                            child: Image.file(
                              File(pickedFile!.path!),
                              width: 24.w,
                              fit: BoxFit.cover,
                            ),
                            backgroundColor: Colors.transparent,
                          )
                        : CircleAvatar(
                            radius: 24.w,
                            backgroundImage: NetworkImage(downloadUrl != null
                                ? downloadUrl!
                                : AppTexts().profileUrl),
                            backgroundColor: Colors.transparent,
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        pickedFile == null
                            ? IconButton(
                                onPressed: () {
                                  selectImage();
                                  setState(() {
                                    isImageLoaded = !isImageLoaded;
                                  });
                                },
                                icon: Icon(
                                  Icons.select_all,
                                  color: appColors.whiteColor,
                                ),
                              )
                            : IconButton(
                                onPressed: () async {
                                  uploadFile();

                                  setState(() {
                                    isImageLoaded = !isImageLoaded;
                                  });
                                },
                                icon: Icon(
                                  !isImageLoaded
                                      ? Icons.image_search
                                      : Icons.upload,
                                  color: appColors.whiteColor,
                                ),
                              )
                        /*
                        Visibility(
                          visible: pickedFile != null ? true : false,
                          child: IconButton(
                              onPressed: () async {
                                uploadFile();
                              },
                              icon: Icon(
                                Icons.upload,
                                color: appColors.whiteColor,
                              )),
                        ),
                        Visibility(
                          visible: pickedFile != null ? false : true,
                          child: IconButton(
                              onPressed: () {
                                selectImage();
                              },
                              icon: Icon(
                                Icons.select_all,
                                color: appColors.whiteColor,
                              )),
                        ),
                        */
                      ],
                    ),
                  ]),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w, bottom: 1.h),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  userName,
                  style: textStyle,
                ),
              ),
            ),
            ListTile(
              onTap: selectImage,
              leading: Icon(
                Icons.email,
                size: 25.sp,
                color: appColors.whiteColor,
              ),
              title: Text(
                user.email ?? 'Not Found',
                style: textStyle,
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Ayarlar",
                  style: textStyle,
                ),
              ),
            ),
            SizedBox(
              height: 3.h,
            ),
            ListTile(
              onTap: () {},
              leading: Icon(
                Icons.star_border,
                size: 25.sp,
                color: appColors.whiteColor,
              ),
              title: Text("Oy Ver", style: textStyle),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 14.sp,
                color: appColors.whiteColor,
              ),
            ),
            ListTile(
              onTap: () {},
              leading: Icon(
                Icons.height,
                size: 25.sp,
                color: appColors.whiteColor,
              ),
              title: Text("İndex Hesapla", style: textStyle),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 14.sp,
                color: appColors.whiteColor,
              ),
            ),
            ListTile(
              onTap: () async {
                await FirebaseAuth.instance.signOut();

                await routes.navigateToFuture(context, const LoginPage());
              },
              leading: Icon(
                pickedFile == null ? Icons.exit_to_app : Icons.upload,
                size: 25.sp,
                color: appColors.whiteColor,
              ),
              title: Text("Çıkış Yap", style: textStyle),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 14.sp,
                color: appColors.whiteColor,
              ),
            ),
            buildProgress()
          ],
        ),
      )),
    );
  }
}
