import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:step_counter/ui/pages/home/views/chat_page.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/texts.dart';
import '../../../../core/model/user_model.dart';
import '../../../../core/routes/route_class.dart';

class FriendListPage extends StatefulWidget {
  const FriendListPage({Key? key}) : super(key: key);

  @override
  State<FriendListPage> createState() => _FriendListPageState();
}

class _FriendListPageState extends State<FriendListPage> {
  final user = FirebaseAuth.instance.currentUser!;
  final AppColors appColors = AppColors();
  final NavigationRoutes routes = NavigationRoutes();

  Stream<List<UserModel>> readUsers() => FirebaseFirestore.instance
      .collection("users")
      .orderBy("step", descending: true)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => UserModel.fromJson(doc.data())).toList());

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Scaffold(
        body: StreamBuilder<List<UserModel>>(
      stream: readUsers(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var users = snapshot.data;

          return ListView.builder(
              itemCount: users?.length,
              itemBuilder: ((context, index) {
                return InkWell(
                  onTap: () {
                    routes.navigateToWidget(
                        context,
                        ChatPage(
                          uid: users?[index].uid ?? 'null',
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
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
                  ),
                );
              }));
        }
        if (snapshot.hasError) {
          print(snapshot.error);
        }
        return Center(
            child: CircularProgressIndicator(
          color: appColors.whiteColor,
        ));
      },
    ));
  }
}
