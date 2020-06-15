import 'package:flutter/material.dart';

class Screen2 extends StatelessWidget {
  final String IDCT;
  final String NameCT;

  const Screen2({Key key, this.IDCT, this.NameCT}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Name - Country'),
      ),
      body: Center(
        child: Row(
          children: <Widget>[
            Text(
              NameCT,style: TextStyle(
              fontSize: 43,color: Colors.red
            ),
            ),
            Container(
              width: 10.0,
            ),
            Text(
              IDCT,style:TextStyle(
              fontSize: 23,color: Colors.amber
            ),
            )
          ],
        ),
      ),
    );
  }
}
