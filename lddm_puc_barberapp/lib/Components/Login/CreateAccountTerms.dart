import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import '../../../../Common/Util.dart';
import '../../../../Routes/AppRoutes.dart';

class CreateAccountTerms extends StatefulWidget {
  const CreateAccountTerms({Key? key}) : super(key: key);

  @override
  State<CreateAccountTerms> createState() => _CreateAccountTermsState();
}

class _CreateAccountTermsState extends State<CreateAccountTerms> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.fromLTRB(24, 32, 24, Util.getHeight(0.06)),
      child: Container()
    );
  }
}
