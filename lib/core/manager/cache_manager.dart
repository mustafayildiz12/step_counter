import 'dart:convert';

import '../models/user_model.dart';
import 'local_manager.dart';

class UserCacheManager {
  final SharedManager sharedManager;

  UserCacheManager(this.sharedManager);

  Future<void> saveUserData(List<UserModel> items) async {
    // Compute
    final _items =
        items.map((element) => jsonEncode(element.toJson())).toList();
    await sharedManager.saveStringList(SharedKeys.users, _items);
  }

  Future<void> saveDummyItems(List items) async {
    // Compute
    final _items =
        items.map((element) => jsonEncode(element.toJson())).toList();
    await sharedManager.saveStringList(SharedKeys.users, _items);
  }

  Future<void> saveListDummy(List items) async {
    // Compute
    final _items = items.map((element) => jsonEncode(element)).toList();
    await sharedManager.saveStringList(SharedKeys.dummy, _items);
  }

  List? getDummyItems() {
    // Compute
    return sharedManager.getStringList(SharedKeys.users);
  }

  List<UserModel>? getItems() {
    // Compute
    final itemsString = sharedManager.getStringList(SharedKeys.users);
    if (itemsString?.isNotEmpty ?? false) {
      return itemsString!.map((element) {
        final json = jsonDecode(element);
        if (json is Map<String, dynamic>) {
          return UserModel.fromJson(json);
        }
        return UserModel();
      }).toList();
    }
    return null;
  }
}
