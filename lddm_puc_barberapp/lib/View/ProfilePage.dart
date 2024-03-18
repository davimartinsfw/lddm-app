import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lddm_puc_barberapp/Common/NavBar.dart';
import 'package:lddm_puc_barberapp/Common/PageHeader.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageHeader(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Text("TESTE"),
          ),
        ),
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}
