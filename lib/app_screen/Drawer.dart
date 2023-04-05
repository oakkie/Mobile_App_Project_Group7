import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  late String name;

  @override
  void initState() {
    super.initState();
    getName(); // call getName in initState to initialize name variable
  }

  void getName() async {
    final _myBox = await Hive.openBox('mybox');
    final storedName = _myBox.get('name');
    if (storedName != null) {
      setState(() {
        name = storedName;
      });
    } else {
      setState(() {
        name = "User"; // set default value for name
      });
    }
  }

  void changeName(String newName) {
    setState(() {
      name = newName;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color.fromRGBO(243, 222, 186, 1),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.only(top: 30),
              child: Stack(alignment: const Alignment(0.6, 0.6), children: [
                const CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://media.discordapp.net/attachments/780253153173700648/1092751705524940850/logo.png'),
                  radius: 50,
                ),
              ]),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: Row(
                children: [
                  Text(
                    'Hello $name',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => ChangeName(
                          name: name,
                          onNameChanged: changeName,
                        ),
                      );
                    },
                    icon: Icon(Icons.edit),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text('Help'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Help'),
                      content: Text('This is the help message.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_mail),
              title: Text('Contract Us'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Contract Us'),
                      content: Text('Diaryme@kkumail.com'
                          '   nuppanan.t@kkumail.com'
                          '   yuttana.udo@kkumail.com'
                          '   +66994652235'
                          '               +66818273199'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_mail),
              title: Text('About Us'),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('About Us'),
                      content: Text(
                          'We have the intention of allowing people to study and learn ourselves,'
                          ' study their emotions each month, because writing a diary will enable the author is '
                          'body to develop themselves in a better way, such as Personal Organization and self-reflection, Health and wellness,'
                          ' Productivity and goal-setting, Creativity and self-expression Therefore, creating an diary app will benefit a lot of users.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ChangeName extends StatefulWidget {
  final String name;
  final Function(String) onNameChanged;

  const ChangeName({required this.name, required this.onNameChanged});

  @override
  _ChangeNameState createState() => _ChangeNameState();
}

class _ChangeNameState extends State<ChangeName> {
  late String newName;

  @override
  Widget build(BuildContext context) {
    final _myBox = Hive.box('mybox');
    final storedName = _myBox.get('name');
    if (storedName != null) {
      newName = storedName;
    }
    return AlertDialog(
      title: Text('Change Name'),
      content: TextField(
        onChanged: (value) {
          newName = value;
        },
        decoration: InputDecoration(
          labelText: 'New Name',
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            widget.onNameChanged(newName);
            _myBox.put('name', newName);
            Navigator.of(context).pop();
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
