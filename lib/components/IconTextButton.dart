import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setHeight(24)),
        width: MediaQuery.of(context).size.width / 7 - 10,
        height: ScreenUtil().setHeight(210),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
        child: InkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                height: ScreenUtil().setHeight(120),
                width: MediaQuery.of(context).size.width / 7 - 5,
                child: Icon(
                  this.icon,
                  color: Colors.white,
                  size: ScreenUtil().setSp(61),
                ),
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.red),
              ),
              Text(
                this.title,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(30),
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
