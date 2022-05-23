import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:sizer/sizer.dart';
import 'package:timezone/data/latest.dart' as tz;

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/dialogs.dart';
import '../../../../core/constants/service/notofication_service.dart';
import '../../../../core/manager/local_manager.dart';
import '../../../../core/routes/route_class.dart';
import '../profile_page.dart';

abstract class ProfilePageModel extends State<ProfilePage> {
  final AppColors appColors = AppColors();
  final user = FirebaseAuth.instance.currentUser!;
  final _firestore = FirebaseFirestore.instance;
  final SharedManager manager = SharedManager();

  final NavigationRoutes routes = NavigationRoutes();

  PlatformFile? pickedFile;
  UploadTask? uploadTask;
  String? downloadUrl;

  var logger = Logger();
  Map<String, dynamic>? userData;

  Future uploadFile() async {
    final path = 'files/${user.email}/${user.uid}';
    final file = File(pickedFile!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);

    setState(() {
      uploadTask = ref.putFile(file);
    });
    final snapshot = await uploadTask!.whenComplete(() {
      setState(() {
        showMyDialog(context, "Güncellendi", "Profil fotoğrafınız güncellendi",
            DialogType.SUCCES);
      });
    });

    final uploadedUrl = await snapshot.ref.getDownloadURL();
    print(uploadedUrl);

    await _firestore
        .collection("users")
        .doc(user.email)
        .update({"profileUrl": uploadedUrl});
    setState(() {
      uploadTask = null;
    });
  }

  Future getOneData() async {
    CollectionReference ref = _firestore.collection("users");

    var profileRef = ref.doc(user.email);
    var profileData = await profileRef.get();
    Map<String, dynamic> mapData = profileData.data() as Map<String, dynamic>;

    setState(() {
      userData = mapData;
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
    tz.initializeTimeZones();
    checkProfileImage();
    getOneData();
    manager.init();
    NotificationService()
        .showNotification(
          1234,
          "Yürüme zamanı",
          "Günlük egzersizini aksatma",
        )
        .onError((error, stackTrace) => print(error));
    print("Bildirim atıldı");
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
          height: 5.h,
        );
      });
}
