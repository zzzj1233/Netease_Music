import 'package:flutter/material.dart';

class CountDownCode extends StatefulWidget {
  final int defaultTime;
  final String defaultText;
  final TextStyle textStyle;
  final VoidCallback onPress;

  CountDownCode(
      {Key key,
      this.defaultTime = 60,
      this.defaultText = "重新获取",
      this.textStyle = const TextStyle(fontSize: 11, color: Colors.grey),
      this.onPress})
      : super(key: key);

  @override
  CountDownCodeState createState() {
    return CountDownCodeState();
  }
}

class CountDownCodeState extends State<CountDownCode> {
  String _time;

  @override
  void initState() {
    super.initState();
    _time = widget.defaultTime.toString();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setTime(int time) {
    this.setState(() {
      this._time = time?.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return this._time != null
        ? Text(
            _time + "s",
            textAlign: TextAlign.start,
            style: TextStyle(fontSize: 11, color: Colors.grey),
          )
        : InkWell(
            child: Text(
              widget.defaultText,
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 11, color: Colors.blueAccent),
            ),
            onTap: () {
              widget.onPress();
            },
          );
  }
}
