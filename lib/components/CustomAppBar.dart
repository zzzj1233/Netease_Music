import 'package:flutter/material.dart';

/// 自定义的AppBar
class CustomAppBar extends StatelessWidget {
  final double height;
  final Widget leading;
  final String title;
  final bool centerTitle;
  final List<Widget> actions;
  final double horizontalPadding;
  final Color backgroundColor;

  CustomAppBar(
      {Key key,
      this.height = 40,
      this.leading,
      this.title = "App",
      this.centerTitle = false,
      this.actions,
      this.horizontalPadding = 3,
      this.backgroundColor = Colors.transparent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget leading =
        this.leading ?? Navigator.canPop(context) ? BackButton() : Container();

    Widget title = this.centerTitle
        ? Text(this.title)
        : Text(this.title, textAlign: TextAlign.center);
    return Container(
        width: MediaQuery.of(context).size.width,
        color: this.backgroundColor,
        height: this.height,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Center(
          child: Row(
            children: <Widget>[leading, title],
          ),
        ));
  }
}
