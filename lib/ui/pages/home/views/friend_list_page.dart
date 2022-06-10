import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:step_counter/ui/pages/home/view_models.dart/friend_list_model.dart';
import 'package:step_counter/ui/pages/home/views/chat_page.dart';

import '../../../../core/constants/texts.dart';
import '../../../../core/models/user_model.dart';

class FriendListPage extends StatefulWidget {
  const FriendListPage({Key? key}) : super(key: key);

  @override
  State<FriendListPage> createState() => _FriendListPageState();
}

class _FriendListPageState extends FriendListModel {
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
