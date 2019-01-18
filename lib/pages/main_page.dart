import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'card/index.dart';

class MainPage extends StatefulWidget
{
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
{
  final List<List<double>> charts =
  [
    [2, 0, 0, 3, 0, 1],
    [3, 1, 2, 0, 0, 0, 2, 0, 0, 3, 4, 1],
  ];

  static final List<String> chartDropdownItems = ['Last 6 Months', 'Last Year' ];
  String actualDropdown = chartDropdownItems[0];
  int actualChart = 0;

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: AppBar
      (
        elevation: 2.0,
        backgroundColor: Color.fromRGBO(28,36,75,1.0),
        title: Text('V APP', style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1), fontWeight: FontWeight.w500, fontSize: 24.0)),
        leading: Builder(
          builder: (BuildContext context) {
            return Icon(Icons.person, color: Colors.white);
          }
        ),
        actions: <Widget>
        [
          Container
          (
            margin: EdgeInsets.only(right: 8.0),
            child: Row
            (
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>
              [
                Icon(Icons.settings, color: Colors.white),
              ],
            ),
          )
        ],
      ),
      body: StaggeredGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: <Widget>[
          _buildTile(
            Padding
            (
              padding: const EdgeInsets.fromLTRB(24.0, 30.0, 24.0, 30.0),
              child: Row
              (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>
                [
                  Column
                  (
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>
                    [
                      Text('Profile'.toUpperCase(), style: TextStyle(color: Colors.black38)),
                      Text('Ke', style: TextStyle(color: Color.fromRGBO(28,36,75,1.0), fontWeight: FontWeight.w700, fontSize: 20.0))
                    ],
                  ),
                  Material
                  (
                    color: Color.fromRGBO(28,181,209,1.0),
                    borderRadius: BorderRadius.circular(14.0),
                    child: Center
                    (
                      child: Padding
                      (
                        padding: const EdgeInsets.all(16.0),
                        child: Icon(Icons.portrait, color: Colors.white, size: 20.0),
                      )
                    )
                  )
                ]
              ),
            ),
          ),
          _buildTile(
            Padding
            (
              padding: const EdgeInsets.fromLTRB(24.0, 30.0, 24.0, 30.0),
              child: Row
              (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>
                [
                  Column
                  (
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>
                    [
                      Text('Foot'.toUpperCase(), style: TextStyle(color: Colors.black38)),
                      Text('Model'.toUpperCase(), style: TextStyle(color: Colors.black38)),
                    ],
                  ),
                  Material
                  (
                    color: Color.fromRGBO(28,181,209,1.0),
                    borderRadius: BorderRadius.circular(14.0),
                    child: Center
                    (
                      child: Padding
                      (
                        padding: const EdgeInsets.all(16.0),
                        child: Icon(Icons.arrow_right, color: Colors.white, size: 20.0),
                      )
                    )
                  )
                ]
              ),
            ),
          ),
         
          _buildTile(
            Padding (
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: _footDataWidget('Foot Length', '9.2E', '9.4 2E'),
            )
          ),
          _buildTile(
            Padding (
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: _footDataWidget('Ball Width', 'E', 'E'),
            )
          ),
           _buildTile(
            Padding (
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: _footDataWidget('Arch Height', 'High', 'Medium'),
            )
          ),
           _buildTile(
            Padding (
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: _footDataWidget('Instep Height', 'High', 'High'),
            )
          ),
           _buildTile(
            Padding (
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: _footDataWidget('Heel Width', 'Medium', 'Wide'),
            )
          ),
          _buildTile(
            Padding
                (
                  padding: const EdgeInsets.all(24.0),
                  child: Column
                  (
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>
                    [
                      Row
                      (
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>
                        [
                          Column
                          (
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>
                            [
                              Text('Purchased shoes', style: TextStyle(color: Colors.black38)),
                              Text('6', style: TextStyle(color: Color.fromRGBO(28,36,75,1), fontWeight: FontWeight.w700, fontSize: 34.0)),
                            ],
                          ),
                          DropdownButton
                          (
                            isDense: true,
                            value: actualDropdown,
                            onChanged: (String value) => setState(()
                            {
                              actualDropdown = value;
                              actualChart = chartDropdownItems.indexOf(value); // Refresh the chart
                            }),
                            items: chartDropdownItems.map((String title)
                            {
                              return DropdownMenuItem
                              (
                                value: title,
                                child: Text(title, style: TextStyle(color: Color.fromRGBO(28,36,75,1), fontWeight: FontWeight.w400, fontSize: 14.0)),
                              );
                            }).toList()
                          )
                        ],
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 4.0)),
                      Sparkline
                      (
                        data: charts[actualChart],
                        lineWidth: 2.0,
                        lineColor: Color.fromRGBO(28,36,75,0.7),
                      )
                    ],
                  )
                ),
          ),
          _buildTile(
            Padding
            (
              padding: const EdgeInsets.all(24.0),
              child: Row
              (
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>
                [
                  Column
                  (
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>
                    [
                      Text('Shop Your Best Fit', style: TextStyle(color: Colors.black38)),
                      Text('173', style: TextStyle(color: Color.fromRGBO(28,36,75,1.0), fontWeight: FontWeight.w700, fontSize: 34.0))
                    ],
                  ),
                  Material
                  (
                    color: Color.fromRGBO(28,181,209,1.0),
                    borderRadius: BorderRadius.circular(24.0),
                    child: Center
                    (
                      child: Padding
                      (
                        padding: EdgeInsets.all(16.0),
                        child: Icon(Icons.store, color: Colors.white, size: 30.0),
                      )
                    )
                  )
                ]
              ),
            ),
            onTap: () => Navigator.push(
              context, 
              // MaterialPageRoute(builder: (context) => MyHomePage())
               MaterialPageRoute(builder: (context) => CardDemo())
              // MaterialPageRoute(builder: (context) => ShoesView())
            )
          )
        ],
        staggeredTiles: [
          StaggeredTile.extent(1, 110.0),
          StaggeredTile.extent(1, 110.0),
          StaggeredTile.extent(2, 140.0),
          StaggeredTile.extent(2, 140.0),
          StaggeredTile.extent(2, 140.0),
          StaggeredTile.extent(2, 140.0),
          StaggeredTile.extent(2, 140.0),
          StaggeredTile.extent(2, 220.0),
          StaggeredTile.extent(2, 110.0),
        ],
      )
    );
  }

  Widget _buildTile(Widget child, {Function() onTap}) {
    return Material(
      elevation: 14.0,
      borderRadius: BorderRadius.circular(12.0),
      shadowColor: Color(0x802196F3),
      child: InkWell
      (
        // Do onTap() if it isn't null, otherwise do print()
        onTap: onTap != null ? () => onTap() : () { print('Not set yet'); },
        child: child
      )
    );
  }
}

Widget _footDataWidget(String widgetTitle, String leftFeetData, String rightFeetData) {
  return new Container(
    color: Color.fromRGBO(255, 255, 255, 1),
    margin: const EdgeInsets.only(top: 16.0),
    child: new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(widgetTitle.toUpperCase(), style: TextStyle(fontSize: 16.0, color: Colors.black38)),
          ]
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20.0),
              child:  Column(
                children: <Widget>[
                  Text(leftFeetData, style: TextStyle(fontSize: 24.0, color: Color.fromRGBO(28,36,75,1.0))),
                  Text('Left', style: TextStyle(fontSize: 14.0, color: Colors.black38)),
                ]
              ),
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              child:  Column(
                children: <Widget>[
                  Text(rightFeetData, style: TextStyle(fontSize: 24.0, color: Color.fromRGBO(28,36,75,1.0))),
                  Text('Right', style: TextStyle(fontSize: 14.0, color: Colors.black38)),
                ]
              ),
            )
          ],
        )
      ],
    ),
  );
}