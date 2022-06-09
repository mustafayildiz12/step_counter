import 'package:flutter/material.dart';
import 'package:step_counter/core/constants/colors.dart';
import 'package:step_counter/core/model/user_model.dart';
import 'package:step_counter/ui/pages/home/views/bottom_navigation_page.dart';

import '../../core/manager/cache_manager.dart';
import '../../core/manager/local_manager.dart';
import '../../core/routes/route_class.dart';

class SaveUserInfo extends StatefulWidget {
  const SaveUserInfo({Key? key}) : super(key: key);

  @override
  State<SaveUserInfo> createState() => _SaveUserInfoState();
}

class _SaveUserInfoState extends State<SaveUserInfo> {
  late final UserCacheManager userCacheManager;
  final NavigationRoutes routes = NavigationRoutes();
  List<UserModel> info = [];
  @override
  void initState() {
    super.initState();
    initalazeAndSave();
  }

  Future<void> initalazeAndSave() async {
    final SharedManager manager = SharedManager();

    await manager.init().whenComplete(() {
      userCacheManager = UserCacheManager(manager);
    });

    info = userCacheManager.getItems() ?? [];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().darkGreen,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("User Info"),
      ),
      body: Column(
        children: [
          IconButton(
              onPressed: () {
                routes.navigateToWidget(context, const BottomNavigationPage());
              },
              icon: const Icon(Icons.arrow_back_ios_outlined)),
          const Text("User Info"),
          Text(info[0].name ?? 'İsim boş'),
          Text(info[0].email ?? 'Email boş'),
          Text(info[0].uid ?? 'Uuid boş'),
          Text(info[0].profileUrl ?? 'Profil boş'),
        ],
      ),
    );
  }
}
