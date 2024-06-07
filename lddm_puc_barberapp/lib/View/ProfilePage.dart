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
import 'package:lddm_puc_barberapp/Controllers/ButtonReturnController.dart';
import 'package:lddm_puc_barberapp/Controllers/EditProfileController.dart';
import 'package:lddm_puc_barberapp/Controllers/RouteController.dart';
import 'package:lddm_puc_barberapp/Controllers/UserController.dart';
import 'package:lddm_puc_barberapp/Models/Profile/Field.dart';
import 'package:lddm_puc_barberapp/Routes/AppRoutes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late EditProfileController controller;
  late RouteController routeController;
  late UserController userController;
  late ButtonReturnController buttonReturnController;

  @override
  void initState() {
    super.initState();

    controller = context.read<EditProfileController>();
    routeController = context.read<RouteController>();
    userController = context.read<UserController>();
    buttonReturnController = context.read<ButtonReturnController>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      initializeFields();
    });
  }

  void initializeFields() {
    final controllers = controller.textControllers;
    final fields = controller.mockProfile;

    controllers[fields[0].controllerName]!.text =
        userController.userProfile!.name;
    controllers[fields[1].controllerName]!.text =
        userController.userProfile!.email;
    controllers[fields[2].controllerName]!.text =
        formatCellphone(userController.userProfile!.cellphone);

    setState(() {});
  }

  Widget renderField(
      TextEditingController controller, Field field, String name) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: EditProfileField(
        textEditingController: controller,
        field: field,
        name: field.label ?? "",
        callBack: buttonReturnController.updateButton,
      ),
    );
  }

  String formatCellphone(String cellphone) {
    if (cellphone.isEmpty) {
      return '';
    }

    String newCell =
        cellphone.replaceAll(')', '').replaceAll('-', '').replaceAll('(', '');

    List<String> broken = newCell.split('');
    broken.insert(7, '-');
    broken.insert(2, ') ');
    broken.insert(0, '(');

    return broken.join('');
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

  String add0(int i) {
    return i < 10 ? '0$i' : i.toString();
  }

  bool isDisable() {
    final controllers = controller.textControllers;

    bool condition = (userController.userProfile!.name ?? '') ==
            controllers['name']?.value.text &&
        (userController.userProfile!.email ?? '') ==
            controllers['email']?.value.text &&
        formatCellphone(userController.userProfile!.cellphone ?? '') ==
            controllers['cellphone']?.value.text;

    return condition;
  }

  @override
  Widget build(BuildContext context) {
    context.watch<UserController>();
    context.watch<EditProfileController>();

    return Scaffold(
      appBar: PageHeader("Seu perfil", routeController),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer<ButtonReturnController>(
                        builder: (context, butonController, child) {
                      return Container(
                          width: Util.getWidth(0.4),
                          child: RoundedButton(
                              text: "Salvar",
                              color: Util.SecondaryColor,
                              isDisabledText: 'Salvar',
                              isDisabled: isDisable(),
                              callBackOnPressed: () async {
                                await userController.updateUser(
                                    controller.generateUserData(
                                        userController.userProfile!));

                                await userController.reloadUser();
                              }));
                    }),
                  ],
                ),
                Padding(padding: EdgeInsets.only(bottom: 120)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: Util.getWidth(0.4),
                        child: RoundedButton(
                            text: "Sair",
                            color: Util.TextColor,
                            textColor: Util.PrimaryColor,
                            callBackOnPressed: () async {
                              SharedPreferences sharedMemory =
                                  await SharedPreferences.getInstance();
                              await sharedMemory.clear();
                              routeController.softPush(AppRoutes.LOGIN);
                            })),
                  ],
                ),
                Padding(padding: EdgeInsets.only(bottom: 12)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: Util.getWidth(0.4),
                        child: RoundedButton(
                            text: "Excluir Conta",
                            color: Util.DangerColor,
                            callBackOnPressed: () async {
                              userController.deleteUser();
                              SharedPreferences sharedMemory =
                                  await SharedPreferences.getInstance();
                              await sharedMemory.clear();
                              routeController.softPush(AppRoutes.LOGIN);
                            })),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}
