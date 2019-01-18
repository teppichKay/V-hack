import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ShoesView extends StatefulWidget {
  @override
  _ShoesViewState createState() => _ShoesViewState();
}

class _ShoesViewState extends State<ShoesView> {
  List<List> shoeData = [
    ['New Balance W 860 V9', 'res/shoe1.png'],
    ['Brooks Adrenline 19',  'res/shoe2.png'],
    ['Asics GT 3000 5',      'res/shoe3.png'],
    ['Nike Structure 22',    'res/shoe4.png'],
    ['Nike React Flyknit',   'res/shoe5.png'],
    ['Adidas Boston 7',      'res/shoe6.png'],
    ['Asics Cumulus 20',     'res/shoe7.png'],
    ['Mizuna Wave Sky 2',    'res/shoe8.png'],
    ['Adidas Ultraboost',    'res/shoe9.png'],
    ['Nike Zoom Fly',        'res/shoe10.png'],
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(28,36,75,1.0),
        title: Text(
          'Shop Your Best Fit', 
          style: TextStyle(
            color: Colors.white, 
            fontSize: 24.0,
            fontFamily: 'Lato',
          )
        ),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const BackButtonIcon(),
              onPressed: () {
                Navigator.pop(context);
              }
            );
          }
        )
       
      ),
      body: new Column(
        children: <Widget>[
          promotionSection,
          new Expanded(
            child:  GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20.0),
              crossAxisSpacing: 10.0,
              crossAxisCount: 2,
              children: <Widget>[
                // promotionSection,
                shoeCard(shoeData[0][0], shoeData[0][1]),
                shoeCard(shoeData[1][0], shoeData[1][1]),
                shoeCard(shoeData[2][0], shoeData[2][1]),
                shoeCard(shoeData[3][0], shoeData[3][1]),
                shoeCard(shoeData[4][0], shoeData[4][1]),
                shoeCard(shoeData[5][0], shoeData[5][1]),
                shoeCard(shoeData[6][0], shoeData[6][1]),
                shoeCard(shoeData[7][0], shoeData[7][1]),
                shoeCard(shoeData[8][0], shoeData[8][1]),
                shoeCard(shoeData[9][0], shoeData[9][1]),
              ]
            )
          )
        ]
      )
     
    );
  }
}


Container shoeCard(
  String title,
  String imgSrc,
) {
  const shoeCardShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(8.0),
      topRight: Radius.circular(8.0),
      bottomLeft: Radius.circular(8.0),
      bottomRight: Radius.circular(8.0),
    )
  );

    Widget shoeImageSection = Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 9.0),
      child: Image.asset(
        imgSrc,
        height: 100.0,
        alignment: Alignment.center,
      )
    );

    Widget shoeTitleSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title)
        ]
      )
    );

    Widget buttonSection = Container(
      padding: EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ButtonTheme(
            height: 8.0,
            child: FlatButton(
              padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0),
              child: Text('BUY', semanticsLabel: 'Buy this shoe.'),
              textColor: Colors.amber.shade500,
              onPressed: () {
                if (title == 'New Balance W 860 V9') {
                  _launchURL();
                }
              },
            )
          )
        ],
      )
    );

    return Container(
        padding: EdgeInsets.all(0),
        height: 320.0,
        child: Card(
          elevation: 6.0,
          clipBehavior: Clip.antiAlias,
          shape: shoeCardShape,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Shoe Image and title
              shoeImageSection,
              shoeTitleSection,
              buttonSection,
            ]
          )
        )
      );
}

_launchURL() async {
  const url = 'https://www.newbalance.se/en/pd/860v9/W860-V9.html#color=Black_with_Magnet';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Widget promotionSection = Container(
    padding: EdgeInsets.all(15.0),
    alignment: Alignment.center,
    color: Colors.blueAccent,
    child: Text(
      'Buy your best fit in the app to win 20% discount!', 
      style: TextStyle(color: Colors.white, fontSize: 14.0), softWrap: true),
  );
