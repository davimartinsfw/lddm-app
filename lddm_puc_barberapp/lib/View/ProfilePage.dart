import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:lddm_puc_barberapp/Common/NavBar.dart';
import 'package:lddm_puc_barberapp/Common/PageHeader.dart';
import 'package:lddm_puc_barberapp/Common/Util.dart';
import 'package:lddm_puc_barberapp/Components/Common/CustomTextField.dart';
import 'package:lddm_puc_barberapp/Components/Common/RoundedButton.dart';
import 'package:lddm_puc_barberapp/Models/Profile/Field.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Field mockField = Field(
    controller: TextEditingController(),
    label: "Nome Completo",
    hintText: "Digite seu nome",
  );
  TextEditingController mockController = TextEditingController();

  Widget renderField(TextEditingController controller, Field field) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: CustomTextField(
        textEditingController: controller,
        field: field,
      ),
    );
  }

  Widget renderFieldList() {
    return Column(
      children: [
        renderField(mockController, mockField),
        renderField(mockController, mockField),
        renderField(mockController, mockField),
        renderField(mockController, mockField)
      ],
    );
  }

  Widget renderSchedules() {
    return Column(
      children: [
        Padding(padding: EdgeInsets.only(top: 32, bottom: 16), child: 
        Text("Nenhum Agendamento marcado", style: Util.fontStyle(15, Util.HeaderArrow), ),
        ),
        Container(
            width: Util.getWidth(0.36),
            child: RoundedButton(txt: "Agendar", callBack: () {})),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageHeader(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Editar Perfil", style: Util.fontStyleSB(20)),
                Padding(padding: EdgeInsets.only(bottom: 20)),
                renderFieldList(),
                Padding(padding: EdgeInsets.only(bottom: 12)),
                Text(
                  "Meus Agendamentos",
                  style: Util.fontStyleSB(20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [renderSchedules()],
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}
