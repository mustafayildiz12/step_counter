import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/texts.dart';
import '../../../core/model/user_model.dart';
import 'view_models.dart/home_page_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends HomePageModel {
  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Tüm Kullanıcılar"),
          centerTitle: true,
        ),
        body: StreamBuilder<List<UserModel>>(
          stream: readUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var users = snapshot.data;

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
            return Center(
                child: CircularProgressIndicator(
              color: appColors.whiteColor,
            ));
          },
        ));
  }
}
