import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoMore extends StatelessWidget {
  NoMore({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(200),
      width: double.infinity,
      decoration: BoxDecoration(

      ),
      child: Center(
        child: Text("到底啦~",style: TextStyle(color: Colors.grey,fontSize: ScreenUtil().setSp(30)),),
      ),
    );
  }
}
