import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:somaiyatrackercomponents/models/building_data.dart';

class NavigateComponent extends StatefulWidget {
  @override
  _NavigateComponentState createState() => _NavigateComponentState();
}

class _NavigateComponentState extends State<NavigateComponent> {
  //Dijkstra's Algorithm

  bool navigate = false;

  bool displayETA = false;
  double ETA = 0.0;

  void dijkstras(List<List<int>> g, int n, int s) {
    List<bool> visited = new List<bool>.filled(n, false);

    List<int> prev = new List<int>.filled(n, -1);

    List<double> dist = new List<double>.filled(n, 1000);
    dist[s] = 0;

    for (int i = 1; i < n; i++) {
      // Pick the minimum distance vertex
      // from the set of vertices not yet
      // processed. nearestVertex is
      // always equal to startNode in
      // first iteration.
      int nearestVertex = -1;
      double shortestDistance = 1000;
      for (int vertexIndex = 0; vertexIndex < n; vertexIndex++) {
        if (!visited[vertexIndex] && dist[vertexIndex] < shortestDistance) {
          nearestVertex = vertexIndex;
          shortestDistance = dist[vertexIndex];
        }
      }

      // Mark the picked vertex as
      // processed
      visited[nearestVertex] = true;

      // Update dist value of the
      // adjacent vertices of the
      // picked vertex.
      for (int vertexIndex = 0; vertexIndex < n; vertexIndex++) {
        int edgeDistance = g[nearestVertex][vertexIndex];

        if (edgeDistance > 0 &&
            ((shortestDistance + edgeDistance) < dist[vertexIndex])) {
          prev[vertexIndex] = nearestVertex;
          dist[vertexIndex] = shortestDistance + edgeDistance;
        }
      }
    }
    //DESTINATION INDEX
    int d = 8; //one minus of the destination vertex number

    print(dist[d]);
    setState(() {
      ETA = dist[d];
    });
    List<int> path = new List<int>.filled(n, -1);

    for (int at = d, i = 0; at != -1; at = prev[at]) {
      path[i] = at;
      i = i + 1;
    }

    for (int i = n - 1; i >= 0; i--) {
      if (path[i] != -1) print(path[i]);
    }
  }

  void algo() {
    print('path found');
    List<List<int>> g = new List<List<int>>();

    //GRAPH
    g = [
      [0, 4, 0, 0, 0, 0, 0, 8, 0],
      [4, 0, 8, 0, 0, 0, 0, 11, 0],
      [0, 8, 0, 7, 0, 4, 0, 0, 2],
      [0, 0, 7, 0, 9, 14, 0, 0, 0],
      [0, 0, 0, 9, 0, 10, 0, 0, 0],
      [0, 0, 4, 0, 10, 0, 2, 0, 0],
      [0, 0, 0, 14, 0, 2, 0, 1, 6],
      [8, 11, 0, 0, 0, 0, 1, 0, 7],
      [0, 0, 2, 0, 0, 0, 6, 7, 0]
    ];

    dijkstras(g, 9, 3);
  }

  // Autocomplete
  AutoCompleteTextField searchTextField;
  AutoCompleteTextField searchTextField1;
  GlobalKey<AutoCompleteTextFieldState<Building>> key = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<Building>> key1 = new GlobalKey();

  Widget row(Building building) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(building.name,
            style: TextStyle(
              fontSize: 16.0,
            )),
        SizedBox(
          height: 2.0,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      children: [
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Somaiya',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.2,
                      color: Colors.teal[800],
                    )),
                Text('Tracker',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.2,
                      color: Colors.teal[900],
                    ))
              ]),
        ),
        Container(
            child: Column(
          children: [
            displayETA
                ? SizedBox()
                : Image(
                    image: AssetImage(
                        'assets/images/component_images/map_3d_icon.png'),
                  ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.fiber_manual_record, color: Colors.grey),
                        SizedBox(
                            width: 336.0,
                            child: searchTextField =
                                AutoCompleteTextField<Building>(
                              itemSubmitted: (item) => setState(() =>
                                  searchTextField.textField.controller.text =
                                      item.name),
                              key: key,
                              suggestions: buildings,
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                    left: 10.0,
                                    top: 30.0,
                                    right: 10.0,
                                    bottom: 20.0,
                                  ),
                                  hintText: 'From Location',
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                  )),
                              itemBuilder: (context, item) {
                                return row(item);
                              },
                              itemSorter: (x, y) {
                                return x.name.compareTo(y.name);
                              },
                              itemFilter: (item, query) {
                                return item.name
                                    .toLowerCase()
                                    .contains(query.toLowerCase());
                              },
                              clearOnSubmit: false,
                            )),
                      ]),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.fiber_manual_record,
                            color: Colors.grey[900]),
                        SizedBox(
                            width: 336.0,
                            child: searchTextField1 =
                                AutoCompleteTextField<Building>(
                              itemSubmitted: (item) => setState(() =>
                                  searchTextField1.textField.controller.text =
                                      item.name),
                              key: key1,
                              suggestions: buildings,
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                    left: 10.0,
                                    top: 30.0,
                                    right: 10.0,
                                    bottom: 20.0,
                                  ),
                                  hintText: 'To Destination',
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                  )),
                              itemBuilder: (context, item) {
                                return row(item);
                              },
                              itemSorter: (x, y) {
                                return x.name.compareTo(y.name);
                              },
                              itemFilter: (item, query) {
                                return item.name
                                    .toLowerCase()
                                    .contains(query.toLowerCase());
                              },
                              clearOnSubmit: false,
                            )),
                      ]),
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  FlatButton(
                    onPressed: () {
                      //ETA Logic

                      //both/any of the fields are blank
                      if (searchTextField.textField.controller.text == '' ||
                          searchTextField.textField.controller.text == '') {
                        setState(() {
                          displayETA = false;
                          navigate = false;
                          ETA = 0.0;
                        });
                        final snackBar = SnackBar(
                          content: Text('Please fill in all the fields.'),
                          action: SnackBarAction(
                            label: '',
                            onPressed: () {},
                          ),
                        );

                        // Find the Scaffold in the widget tree and use
                        // it to show a SnackBar.
                        Scaffold.of(context).showSnackBar(snackBar);
                      } else {
                        bool chk, chk1 = false;

                        for (int i = 0; i < buildings.length; i++) {
                          if (buildings[i].name ==
                              searchTextField.textField.controller.text)
                            chk = true;

                          if (buildings[i].name ==
                              searchTextField1.textField.controller.text)
                            chk1 = true;
                        }

                        if (chk && chk1) {
                          algo();
                          setState(() {
                            displayETA = true;
                            navigate = false;
                          });
                        } else {
                          setState(() {
                            displayETA = false;
                            navigate = false;
                            ETA = 0.0;
                          });

                          final snackBar = SnackBar(
                            content: Text('Incorrect name of location! '),
                            action: SnackBarAction(
                              label: 'Try Filling Again',
                              onPressed: () {
                                setState(() {
                                  searchTextField1.textField.controller.text =
                                      '';
                                  searchTextField.textField.controller.text =
                                      '';
                                });
                              },
                            ),
                          );

                          // Find the Scaffold in the widget tree and use
                          // it to show a SnackBar.
                          Scaffold.of(context).showSnackBar(snackBar);
                        }
                      }
                    },
                    child: Text('Calculate Time'),
                    textColor: Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.grey)),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  RaisedButton(
                    onPressed: () {
                      //Navigation logic
                      //both/any of the fields are blank
                      if (searchTextField.textField.controller.text == '' ||
                          searchTextField.textField.controller.text == '') {
                        setState(() {
                          displayETA = false;
                          navigate = false;
                          ETA = 0.0;
                        });
                        final snackBar = SnackBar(
                          content: Text('Please fill in all the fields.'),
                          action: SnackBarAction(
                            label: '',
                            onPressed: () {},
                          ),
                        );

                        // Find the Scaffold in the widget tree and use
                        // it to show a SnackBar.
                        Scaffold.of(context).showSnackBar(snackBar);
                      } else {
                        bool chk, chk1 = false;

                        buildings.forEach((element) {
                          if (element.name ==
                              searchTextField.textField.controller.text) {
                            chk = true;
                          }
                          if (element.name ==
                              searchTextField1.textField.controller.text) {
                            chk1 = true;
                          }
                        });

                        if (chk && chk1) {
                          algo();
                          setState(() {
                            displayETA = true;
                            navigate = true;
                          });
                        } else {
                          setState(() {
                            displayETA = false;
                            navigate = false;
                            ETA = 0.0;
                          });

                          final snackBar = SnackBar(
                            content: Text('Incorrect name of location! '),
                            action: SnackBarAction(
                              label: 'Try Filling Again',
                              onPressed: () {
                                setState(() {
                                  searchTextField1.textField.controller.text =
                                      '';
                                  searchTextField.textField.controller.text =
                                      '';
                                });
                              },
                            ),
                          );

                          // Find the Scaffold in the widget tree and use
                          // it to show a SnackBar.
                          Scaffold.of(context).showSnackBar(snackBar);
                        }
                      }
                    },
                    child:
                        Text('Navigate', style: TextStyle(color: Colors.white)),
                    color: Colors.grey,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        side: BorderSide(color: Colors.grey)),
                  ),
                ]),
                displayETA
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('ETA',
                              style: TextStyle(
                                color: Colors.teal[500],
                                fontSize: 20.0,
                                fontWeight: FontWeight.w500,
                              )),
                          Column(
                            children: [
                              Text(searchTextField.textField.controller.text),
                              Text('-'),
                              Text(searchTextField1.textField.controller.text),
                              Text('${ETA}'),
                            ],
                          )
                        ],
                      )
                    : SizedBox(),
                navigate ? Text('Navigate') : SizedBox(),
              ],
            ),
          ],
        )),
      ],
    );
  }
}
