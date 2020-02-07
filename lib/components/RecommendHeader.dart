import 'package:flutter/material.dart';
import 'package:netease_music/util/ColorsUtils.dart';

class RecommendHeader extends StatelessWidget {
  final smallTitle;
  final mainTitle;
  final buttonTitle;
  final buttonTargetUrl;
  final buttonTextStyle;
  final Widget mainWidget;

  RecommendHeader(
      {Key key,
      @required this.smallTitle,
      this.mainTitle,
      @required this.buttonTitle,
      this.buttonTargetUrl,
      this.buttonTextStyle,
      this.mainWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Text(
              smallTitle,
              style: TextStyle(fontSize: 9, color: Colors.grey),
              textAlign: TextAlign.start,
            ),
          ),
          Container(
              width: double.infinity,
              height: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  mainWidget ??
                      Text(
                        mainTitle,
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w700),
                        textAlign: TextAlign.start,
                      ),
                  Container(
                    width: 65,
                    child: OutlineButton(
                      child: Text(
                        buttonTitle,
                        style: buttonTextStyle == null
                            ? TextStyle(fontSize: 8)
                            : buttonTextStyle,
                      ),
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: ColorUtils.lightGrey()
                        ),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  )
                ],
              ),)
        ],
      ),
    );
  }
}
