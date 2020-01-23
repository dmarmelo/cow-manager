import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Enumerado com as possíveis ações do menu de mais opções.
enum ProfileMoreOptions { WEIGHTING, MILKING, BIRTH }

/// [Widget] do menu de mais opções do perfil do animal, onde é possível escolher
/// uma da opções definidas no enumerado [ProfileMoreOptions].
class ProfileMoreOptionsSheet extends StatelessWidget {
  final void Function(ProfileMoreOptions) callBackOptionTapped;

  const ProfileMoreOptionsSheet(
      {Key key,
      this.callBackOptionTapped})
      : super(key: key);

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
              callBackOptionTapped(ProfileMoreOptions.WEIGHTING);
            },
          ),
          new ListTile(
            leading: new Icon(FontAwesomeIcons.fillDrip),
            title: new Text('Milking'),
            onTap: () {
              Navigator.of(context).pop();
              callBackOptionTapped(ProfileMoreOptions.MILKING);
            },
          ),
          new ListTile(
            leading: new Icon(FontAwesomeIcons.birthdayCake),
            title: new Text('Birth'),
            onTap: () {
              Navigator.of(context).pop();
              callBackOptionTapped(ProfileMoreOptions.BIRTH);
            },
          ),
          new Divider(),
          new ListTile(
            title: Center(
              child: Text("Cancel"),
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
