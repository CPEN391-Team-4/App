import 'package:flutter/material.dart';
import 'live.dart';
import 'history.dart';
import 'users.dart';
import 'profile.dart';

class Home extends StatefulWidget {
    bool notif;
    Home(this.notif);
    @override 
    State<StatefulWidget> createState() {
        return _HomeState(notif);
    }
}

class _HomeState extends State<Home> {
    int _selected = 0;
    bool notif;
    _HomeState(this.notif);
    @override
    void initState() {
        if (notif == true) {
            getNotificationImage();
        }
    }

    void getNotificationImage() {

    }

    final List<Widget> _render = [
        Live(),
        Users(),
        History(),
        Profile(),
    ];

    void onTabTapped(int index) {
        setState(() {
            _selected = index;
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold( 
                body: _render[_selected],
                bottomNavigationBar: BottomNavigationBar(
                        currentIndex: _selected,
                        onTap: onTabTapped,
                        type: BottomNavigationBarType.fixed,
                        items: [
                            BottomNavigationBarItem(
                                    icon: new Icon(Icons.enhance_photo_translate_rounded),
                                    title: new Text('Live'),
                            ),
                            BottomNavigationBarItem(
                                    icon: new Icon(Icons.supervised_user_circle),
                                    title: new Text('Users'),
                            ),
                            BottomNavigationBarItem(
                                    icon: new Icon(Icons.history ),
                                    title: new Text('History')
                            ),
                            BottomNavigationBarItem(
                                    icon: new Icon(Icons.person),
                                    title: new Text('Profile')
                            )
                        ],
                ),
                );
    }
}
