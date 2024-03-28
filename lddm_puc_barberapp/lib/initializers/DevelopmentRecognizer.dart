import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DevelopmentRecognizer extends StatelessWidget {
  const DevelopmentRecognizer({Key? key}) : super(key: key);

  Widget renderMode(context) {
    if (kDebugMode) {
      return Container(
          decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          height: MediaQuery.of(context).size.width * 0.1,
          width: MediaQuery.of(context).size.width * 0.4,
          child: Center(
              child: Text('Development Mode',
                  style: TextStyle(color: Colors.white, fontSize: 10))));
    }

    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [renderMode(context)],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}
