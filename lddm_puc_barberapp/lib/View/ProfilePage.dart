import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:lddm_puc_barberapp/Common/NavBar.dart';
import 'package:lddm_puc_barberapp/Common/PageHeader.dart';
import 'package:lddm_puc_barberapp/Common/Util.dart';
import 'package:lddm_puc_barberapp/Components/Common/CustomTextField.dart';
import 'package:lddm_puc_barberapp/Components/Common/RoundedButton.dart';
import 'package:lddm_puc_barberapp/Components/Profile/EditProfileField.dart';
import 'package:lddm_puc_barberapp/Controllers/EditProfileController.dart';
import 'package:lddm_puc_barberapp/Controllers/RouteController.dart';
import 'package:lddm_puc_barberapp/Models/Profile/Field.dart';
import 'package:lddm_puc_barberapp/Routes/AppRoutes.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late EditProfileController controller;
  late RouteController routeController;

  @override
  void initState() {
    super.initState();

    controller = context.read<EditProfileController>();
    routeController = context.read<RouteController>();
  }

  Widget renderField(
      TextEditingController controller, Field field, String name) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: EditProfileField(
        textEditingController: controller,
        field: field,
        name: field.label ?? "",
      ),
    );
  }

  Widget renderFieldList() {
    final controllers = controller.textControllers;
    final fields = controller.mockProfile;

    return Column(
      children: [
        renderField(controllers[fields[0].controllerName]!, fields[0],
            fields[0].controllerName),
        renderField(controllers[fields[1].controllerName]!, fields[1],
            fields[1].controllerName),
        renderField(controllers[fields[2].controllerName]!, fields[2],
            fields[2].controllerName),
        renderField(controllers[fields[3].controllerName]!, fields[3],
            fields[3].controllerName),
      ],
    );
  }

  Widget renderSchedules() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 42, bottom: 25),
          child: Text(
            "Nenhum Agendamento marcado",
            style: Util.fontStyle(15, Util.HeaderArrow),
          ),
        ),
        Container(
            width: Util.getWidth(0.36),
            child: RoundedButton(
                text: "Agendar",
                callBackOnPressed: () {
                  routeController.softPush(AppRoutes.PROCEDURELIST);
                })),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageHeader("Seu perfil", routeController, true),
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
