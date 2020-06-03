import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ui/constants.dart';
import 'package:ui/models/classes.dart';

class BuildClasses extends StatefulWidget {
  @override
  _BuildClassesState createState() => _BuildClassesState();
}

class _BuildClassesState extends State<BuildClasses> {

  DateFormat dateFormat = DateFormat("hh:mm a");

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      itemCount: classes.length,
      itemBuilder: (BuildContext context, int index) {
        Classes c = classes[index];
        _getTime(c);
        return Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  "${dateFormat.format(c.time)}",
                  style: TextStyle(
                    color: c.isPassed
                        ? Colors.white.withOpacity(0.2)
                        : Colors.white,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(width: 20.0),
                _getTime(c),
                SizedBox(width: 20.0),
                Text(
                  c.subject,
                  style: TextStyle(
                    color: c.isPassed
                        ? Colors.white.withOpacity(0.2)
                        : Colors.white,
                    fontSize: 18.0,
                  ),
                ),
                SizedBox(width: 20.0),
                c.isHappening
                    ? Container(
                        height: 25.0,
                        width: 40.0,
                        decoration: BoxDecoration(
                          color: kAccentColor,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Center(
                            child: Text(
                          "Now",
                          style: TextStyle(color: Colors.white),
                        )),
                      )
                    : Container(),
              ],
            ),
            SizedBox(height: 20.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 117.0, bottom: 20.0),
                  width: 2,
                  height: 100.0,
                  color: c.isPassed ? kTextColor.withOpacity(0.3) : kTextColor,
                ),
                SizedBox(width: 28.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          color: c.isPassed
                              ? kAccentColor.withOpacity(0.3)
                              : kAccentColor,
                          size: 20.0,
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          c.type,
                          style: TextStyle(
                            color: c.isPassed
                                ? kTextColor.withOpacity(0.3)
                                : kTextColor,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.0),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          color: c.isPassed
                              ? kAccentColor.withOpacity(0.3)
                              : kAccentColor,
                          size: 20.0,
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          c.teacherName,
                          style: TextStyle(
                            color: c.isPassed
                                ? kTextColor.withOpacity(0.3)
                                : kTextColor,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(width: 20.0),
          ],
        );
      },
    );
  }

  _getTime(Classes c) {
    DateTime now = DateTime.now();

    // FIXME: not working correctly

    if (now.difference(c.time).inMinutes >= 59) {
      c.isPassed = true;
    } else if (c.time.difference(now).inMinutes <= 59 &&
        (c.time.hour == now.hour || c.time.difference(now).inHours == 2)) {
      c.isHappening = true;
    } else {
      c.isHappening = false;
    }

    return Container(
      height: 25.0,
      width: 25.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: c.isPassed ? kAccentColor.withOpacity(0.3) : kAccentColor,
          // width: 2.0,
        ),
      ),
      child: _getChild(c),
    );
  }

  _getChild(Classes c) {
    if (c.isPassed) {
      return Icon(
        Icons.check,
        color: c.isPassed ? kAccentColor.withOpacity(0.3) : kAccentColor,
        size: 15.0,
      );
    } else if (c.isHappening) {
      return Container(
        margin: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color: kAccentColor,
          shape: BoxShape.circle,
        ),
      );
    }
    return null;
  }
}