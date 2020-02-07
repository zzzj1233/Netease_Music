import 'package:flutter/material.dart';

class IconTextButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onPress;

  IconTextButton(
      {Key key, @required this.icon, @required this.title, this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

        /// 左右8个margin
        margin: EdgeInsets.symmetric(horizontal: 8),
        width: MediaQuery.of(context).size.width / 7 - 10,
        height: 70,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
        child: InkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: 40,
                width: MediaQuery.of(context).size.width / 7 - 15,
                child: Icon(
                  this.icon,
                  color: Colors.white,
                  size: 17,
                ),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.red),
              ),
              Text(
                this.title,
                style: TextStyle(
                  fontSize: 10,
                ),
              )
            ],
          ),
          onTap: () {
            if (this.onPress != null) {
              this.onPress();
            }
          },
        ));
  }
}
