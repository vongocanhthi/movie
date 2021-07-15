import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movie/util/constant.dart';

class BottomBarPage extends StatefulWidget {
  @override
  State<BottomBarPage> createState() => _BottomBarPageState();
}

class _BottomBarPageState extends State<BottomBarPage> {
  int _currentIndexItem = 0;
  String _text = "Home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: orange_color,
        title: Text("Bottombar + Bottom Sheet"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("Open Bottom Sheet"),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext bc){
                      return Container(
                        child: new Wrap(
                          children: <Widget>[
                            new ListTile(
                                leading: new Icon(Icons.music_note),
                                title: new Text('Music'),
                                onTap: () => {}
                            ),
                            new ListTile(
                              leading: new Icon(Icons.videocam),
                              title: new Text('Video'),
                              onTap: () => {},
                            ),
                          ],
                        ),
                      );
                    });
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text("$_text"),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: "Schedule",
          ),
        ],
        currentIndex: _currentIndexItem,
        selectedItemColor: orange_color,
        onTap: (value) {
          setState(() {
            _currentIndexItem = value;
            if (value == 0) {
              _text = "Home";
            } else if (value == 1) {
              _text = "Schedule";
            }
          });
        },
      ),
    );
  }
}
