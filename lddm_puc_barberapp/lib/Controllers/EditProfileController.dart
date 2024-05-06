import 'package:flutter/cupertino.dart';
import 'package:lddm_puc_barberapp/data/profileMock.dart';
import '../Models/Profile/ProfileField.dart';
import '../Models/User/User.dart';

class EditProfileController extends ChangeNotifier {
  String selectedLabel = "";
  List<ProfileField> mockProfile = MOCK_PROFILE;

  final Map<String, TextEditingController> textControllers = {
    'name': TextEditingController(),
    'email': TextEditingController(),
    'cellphone': TextEditingController(),
    'birthdate': TextEditingController(),
  };

  void updateLabel(String name) {
    selectedLabel = name;
    notifyListeners();
  }

  Map<String, dynamic> generateUserData(User user) {
    return {
      'user': {
        'phone_number': textControllers['cellphone']!
            .text
            .replaceAll(new RegExp(r'[^0-9]'), ''),
        'email': textControllers['email']!.text,
        'name': textControllers['name']!.text,
        'is_admin': user.isAdmin,
        'is_clube': user.isClube,
        'is_barber': user.isBarber
      }
    };
  }
}
