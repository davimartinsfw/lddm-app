import 'package:flutter/cupertino.dart';
import 'package:lddm_puc_barberapp/data/profileMock.dart';
import '../Models/Profile/ProfileField.dart';

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
}