import 'package:flutter/material.dart';
import 'package:step_counter/ui/pages/home/view_models.dart/friend_list_model.dart';

import '../../../../core/models/user_model.dart';
import 'widgets/friend_list.dart';

class FriendListPage extends StatefulWidget {
  const FriendListPage({Key? key}) : super(key: key);

  @override
  State<FriendListPage> createState() => _FriendListPageState();
}

class _FriendListPageState extends FriendListModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<List<UserModel>>(
      stream: readUsers(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var users = snapshot.data;

          return ListView.builder(
            itemCount: users?.length,
            itemBuilder: (context, index) {
              /*String? uid = users?[index].uid;
              lastMessages.add(uidList);*/

              return FriendList(
                  users: users,
                  uidList: lastMessages,
                  index: index,
                  last: last,
                  voidCallback: getLastMessage);
            },
          );
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
