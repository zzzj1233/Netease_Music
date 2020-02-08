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
  final Widget titleWidget;
  final bool ignoreStatusBar;

  CustomAppBar(
      {Key key,
      this.height = 40,
      this.leading,
      this.title = "App",
      this.centerTitle = false,
      this.actions,
      this.horizontalPadding = 5,
      this.backgroundColor = Colors.transparent,
      this.titleWidget,
      this.ignoreStatusBar = false})
      : super(key: key);

  Widget buildTitle() {
    if (this.titleWidget != null) {
      return Expanded(
        child: this.titleWidget,
      );
    }
    Widget title = this.centerTitle
        ? Text(this.title, textAlign: TextAlign.center)
        : Text(this.title, textAlign: TextAlign.start);
    return Expanded(
      child:Container(
        width: double.infinity,
        child:  title,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget leading = this.leading == null
        ? Navigator.canPop(context) ? BackButton() : Container()
        : this.leading;

    List<Widget> children = [];
    children.add(leading);
    children.add(buildTitle());
    if (this.actions != null) {
      children.addAll(actions);
    }

    return this.ignoreStatusBar ? Container(
        width: MediaQuery.of(context).size.width,
        color: this.backgroundColor,
        height: this.height,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Center(
          child: Row(
            children: children,
          ),
        )) :SafeArea(
      child: Container(
          width: MediaQuery.of(context).size.width,
          color: this.backgroundColor,
          height: this.height,
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Center(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          )),
    );
  }
}
