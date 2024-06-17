import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lddm_puc_barberapp/Common/Util.dart';

class ImageBottomModal extends StatefulWidget {
  final String imageUrl;

  const ImageBottomModal({super.key, required this.imageUrl});

  @override
  State<ImageBottomModal> createState() => _ImageBottomModalState();
}

class _ImageBottomModalState extends State<ImageBottomModal> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Util.getHeight(0.5),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(widget.imageUrl)),
      ),
    );
  }
}
