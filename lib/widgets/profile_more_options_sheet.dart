import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum ProfileMoreOptions { WEIGHTING, MILKING }

class ProfileMoreOptionsSheet extends StatefulWidget {
  final void Function(ProfileMoreOptions) callBackOptionTapped;

  const ProfileMoreOptionsSheet(
      {Key key,
      this.callBackOptionTapped})
      : super(key: key);

  @override
  _ProfileMoreOptionsSheetState createState() => _ProfileMoreOptionsSheetState();
}

class _ProfileMoreOptionsSheetState extends State<ProfileMoreOptionsSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Wrap(
        children: <Widget>[
          new ListTile(
              leading: new Icon(FontAwesomeIcons.weight),
              title: new Text('Weighting'),
              onTap: () {
                Navigator.of(context).pop();
                widget.callBackOptionTapped(ProfileMoreOptions.WEIGHTING);
              }),
          new ListTile(
              leading: new Icon(FontAwesomeIcons.fillDrip),
              title: new Text('Milking'),
              onTap: () {
                Navigator.of(context).pop();
                widget.callBackOptionTapped(ProfileMoreOptions.MILKING);
              }),
          new Divider(),
          new ListTile(
            title: Center(
              child: Text("Cancel"),
            ),
          )
        ],
      ),
    );
  }
}
