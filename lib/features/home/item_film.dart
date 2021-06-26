import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ItemFilm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child:
      Column(
        children: [
          Row(
            children: [
              SizedBox(
                width: 120,
                child: Image.asset("assets/images/btnClose.png"),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Title 1"),
                  Text("Title 2"),
                ],
              ),

            ],
          ),
          Divider(
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
