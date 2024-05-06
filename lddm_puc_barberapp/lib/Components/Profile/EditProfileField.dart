import 'package:flutter/cupertino.dart';
import 'package:lddm_puc_barberapp/Common/Util.dart';
import 'package:lddm_puc_barberapp/Components/Common/CustomTextField.dart';
import 'package:lddm_puc_barberapp/Controllers/EditProfileController.dart';
import 'package:provider/provider.dart';
import '../../Models/Profile/Field.dart';

class EditProfileField extends StatefulWidget {
  final TextEditingController textEditingController;
  final Field field;
  final String name;
  final Function? callBack;

  const EditProfileField({
    super.key,
    required this.textEditingController,
    required this.field,
    required this.name,
    this.callBack,
  });

  @override
  State<EditProfileField> createState() => _EditProfileFieldState();
}

class _EditProfileFieldState extends State<EditProfileField> {
  late EditProfileController editProfileController;

  @override
  void initState() {
    super.initState();

    editProfileController = context.read<EditProfileController>();
  }

  void customFocus() {
    widget.field.readOnly
        ? editProfileController.updateLabel("")
        : editProfileController.updateLabel(widget.name);
  }

  void customUnfocus() {
    if (editProfileController.selectedLabel == widget.name) {
      editProfileController.updateLabel("");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.field.label ?? "",
                style: Util.fontStyle(),
              ),
            ],
          ),
        ),
        CustomTextField(
            controller: widget.textEditingController,
            field: widget.field,
            callBack: widget.callBack,
            customFocusCallback: customFocus,
            customUnfocusCallback: customUnfocus),
      ],
    );
  }
}
