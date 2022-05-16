import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:step_counter/core/constants/texts.dart';
import 'package:step_counter/core/model/user_model.dart';

import '../../../core/constants/colors.dart';
import '../../../core/routes/route_class.dart';
import '../auth/login_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AppColors appColors = AppColors();
  final user = FirebaseAuth.instance.currentUser!;

  final NavigationRoutes routes = NavigationRoutes();

  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  String? downloadUrl;
  var name;

  Future uploadFile() async {
    final path = 'files/${user.email}/${user.uid}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);

    setState(() {
      uploadTask = ref.putFile(file);
    });
    final snapshot = await uploadTask!.whenComplete(() {
      setState(() {});
    });

    final uploadedUrl = await snapshot.ref.getDownloadURL();
    print(uploadedUrl);

    await FirebaseFirestore.instance
        .collection("users")
        .doc(user.email)
        .collection("userInfo")
        .doc("profile")
        .update({"profileUrl": uploadedUrl});
    setState(() {
      uploadTask = null;
    });
  }

  Future selectImage() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return;

    setState(() {
      pickedFile = result.files.first;
    });
  }

  @override
  void initState() {
    checkProfileImage();

    super.initState();
  }

  checkProfileImage() async {
    String currentUrl = await FirebaseStorage.instance
        .ref()
        .child("files")
        .child(user.email!)
        .child(user.uid)
        .getDownloadURL();

    setState(() {
      downloadUrl = currentUrl;
    });
  }

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
                        ? Image.file(
                            File(pickedFile!.path!),
                            width: 24.w,
                            fit: BoxFit.cover,
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
                        IconButton(
                            onPressed: () {
                              uploadFile();
                            },
                            icon: Icon(
                              Icons.upload,
                              color: appColors.whiteColor,
                            )),
                        IconButton(
                            onPressed: () {
                              selectImage();
                            },
                            icon: Icon(
                              Icons.select_all,
                              color: appColors.whiteColor,
                            )),
                      ],
                    ),
                  ]),
            ),
            //  Text(document.collection("name").toString()),
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

  Stream<List<UserModel>> readUsers() => FirebaseFirestore.instance
      .collection("users")
      .doc(user.email!)
      .collection("userInfo")
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList());

  Widget buildProgress() => StreamBuilder<TaskSnapshot>(
      stream: uploadTask?.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final data = snapshot.data;
          double progress = data!.bytesTransferred / data.totalBytes;

          return SizedBox(
            height: 50,
            child: Stack(
              fit: StackFit.expand,
              children: [
                LinearProgressIndicator(
                  value: progress,
                  color: appColors.dialogGreen,
                ),
                Center(
                  child: Text(
                    '${(100 * progress).roundToDouble()}%',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: appColors.whiteColor),
                  ),
                )
              ],
            ),
          );
        }
        return SizedBox(
          height: 50,
        );
      });
}
