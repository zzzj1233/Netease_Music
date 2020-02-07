import 'package:flutter/material.dart';

class NoMore extends StatelessWidget {
  NoMore({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(

      ),
      child: Center(
        child: Text("到底啦~",style: TextStyle(color: Colors.grey,fontSize: 10),),
      ),
    );
  }
}
