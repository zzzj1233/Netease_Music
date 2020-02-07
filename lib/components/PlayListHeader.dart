import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MusicListHeader extends StatelessWidget implements PreferredSizeWidget {



  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25), topRight: Radius.circular(25)),
      child: Container(
        height: 20,
        width: double.infinity,
        color: Colors.white,
        child: Text(
          "12312312",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(20);
}
