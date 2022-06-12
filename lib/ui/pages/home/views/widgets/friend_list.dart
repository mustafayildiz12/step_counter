import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../../core/constants/texts.dart';
import '../../../../../core/models/user_model.dart';
import '../../../../../core/routes/route_class.dart';
import '../chat_page.dart';

class FriendList extends StatelessWidget {
  FriendList(
      {Key? key,
      required this.users,
      required this.uidList,
      required this.last,
      required this.index,
      required this.voidCallback})
      : super(key: key);

  List<UserModel>? users;
  List<String?> uidList;
  int index;
  String last;
  Function voidCallback;

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return InkWell(
      onTap: () {
        NavigationRoutes().navigateToWidget(
            context,
            ChatPage(
              uid: users?[index].uid ?? 'null',
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: AppColors().darkGreen,
          child: ListTile(
            leading: CircleAvatar(
              minRadius: 5.w,
              maxRadius: 5.w,
              backgroundImage: NetworkImage(
                users?[index].profileUrl ?? AppTexts().profileUrl,
              ),
              backgroundColor: Colors.transparent,
            ),
            title: Text(
              users?[index].name ?? 'user.name',
              style: themeData.textTheme.bodyMedium
                  ?.copyWith(color: AppColors().whiteColor),
            ),
            subtitle: FutureBuilder<String>(
              future: voidCallback(users?[index].uid),
              builder: (context, AsyncSnapshot<String> snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data as String,
                      style: themeData.textTheme.bodySmall
                          ?.copyWith(color: AppColors().whiteColor));
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }

                return Text('....',
                    style: themeData.textTheme.bodySmall
                        ?.copyWith(color: AppColors().whiteColor));
              },
            ),
          ),
        ),
      ),
    );
  }
}
