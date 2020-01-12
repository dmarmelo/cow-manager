import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum moreOptions { weighting, milking }

class MoreOptionsSheet extends StatefulWidget {
  final void Function(Color) callBackColorTapped;

  final void Function(moreOptions) callBackOptionTapped;

  const MoreOptionsSheet(
      {Key key,
        this.callBackColorTapped,
        this.callBackOptionTapped})
      : super(key: key);

  @override
  _MoreOptionsSheetState createState() => _MoreOptionsSheetState();
}

class _MoreOptionsSheetState extends State<MoreOptionsSheet> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Wrap(
        children: <Widget>[
          new ListTile(
              leading: new Icon(FontAwesomeIcons.weight),
              title: new Text('Weithing'),
              onTap: () {
                Navigator.of(context).pop();
                widget.callBackOptionTapped(moreOptions.weighting);
              }),
          new ListTile(
              leading: new Icon(FontAwesomeIcons.fillDrip),
              title: new Text('Milking'),
              onTap: () {
                Navigator.of(context).pop();
                widget.callBackOptionTapped(moreOptions.milking);
              }),
        ],
      ),
    );
  }

}
