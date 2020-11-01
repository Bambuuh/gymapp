import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gymapp/modules/user.dart';
import 'package:gymapp/services/prefs.service.dart';

class UserProvider with ChangeNotifier {
  final String prefsKey = 'prefs_user';
  User user;

  Future<void> init() async {
    final data = await Prefs.getObjectByKey(prefsKey);
    if (data != null) {
      User prefUser = User.fromJson(data);
      setUser(prefUser);
    }
  }

  void saveData() {
    Prefs.storeObjectByKey(prefsKey, this.user);
  }

  void setUser(User user) {
    this.user = user;
    saveData();
    notifyListeners();
  }
}
