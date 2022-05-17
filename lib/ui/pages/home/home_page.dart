import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:sizer/sizer.dart';
import 'package:step_counter/core/constants/colors.dart';
import 'package:step_counter/core/routes/route_class.dart';

import '../../../core/constants/texts.dart';
import '../../../core/model/user_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;
  final AppColors appColors = AppColors();
  final NavigationRoutes routes = NavigationRoutes();

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("All Users"),
          centerTitle: true,
        ),
        body: StreamBuilder<List<UserModel>>(
          stream: readUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var users = snapshot.data;
              Logger().i(users?.first);

              return ListView.builder(
                  itemCount: users?.length,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        // shape: const StadiumBorder(side: BorderSide()),
                        color: appColors.darkGreen,
                        child: ListTile(
                            leading: CircleAvatar(
                              radius: 8.w,
                              backgroundImage: NetworkImage(
                                  users?[index].profileUrl ??
                                      AppTexts().profileUrl),
                              backgroundColor: Colors.transparent,
                            ),
                            title: Text(
                              users?[index].name ?? 'user.name',
                              style: themeData.textTheme.bodyMedium
                                  ?.copyWith(color: appColors.whiteColor),
                            ),
                            subtitle: Text(users?[index].email ?? 'user.email',
                                style: themeData.textTheme.bodySmall
                                    ?.copyWith(color: appColors.whiteColor)),
                            trailing: Text(
                                'Puan: ' + users![index].step.toString(),
                                style: themeData.textTheme.bodySmall
                                    ?.copyWith(color: appColors.whiteColor))),
                      ),
                    );
                  }));
            }
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            return const CircularProgressIndicator();
          },
        ));
  }

  Stream<List<UserModel>> readUsers() => FirebaseFirestore.instance
      .collection("users")
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList());
}
