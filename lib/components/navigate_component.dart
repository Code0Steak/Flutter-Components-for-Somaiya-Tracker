import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:somaiyatrackercomponents/models/building_data.dart';

class NavigateComponent extends StatefulWidget {
  @override
  _NavigateComponentState createState() => _NavigateComponentState();
}

class _NavigateComponentState extends State<NavigateComponent> {
// Autocomplete
  AutoCompleteTextField searchTextField;
  AutoCompleteTextField searchTextField1;
  GlobalKey<AutoCompleteTextFieldState<Building>> key = new GlobalKey();
  GlobalKey<AutoCompleteTextFieldState<Building>> key1 = new GlobalKey();

  //Dijkstra's Algorithm

  bool navigate = false;

  bool displayETA = false;
  double ETA = 0.0;

  List<int> printPath;

  void dijkstras(List<List<double>> g, int n, int s, int to) {
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
        double edgeDistance = g[nearestVertex][vertexIndex];

        if (edgeDistance > 0 &&
            ((shortestDistance + edgeDistance) < dist[vertexIndex])) {
          prev[vertexIndex] = nearestVertex;
          dist[vertexIndex] = shortestDistance + edgeDistance;
        }
      }
    }
    //DESTINATION INDEX
    int d = to; //one minus of the destination vertex number

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

    setState(() {
      printPath = path.reversed.toList();
    });
    print(printPath);
  }

  void algo() {
    print('path found');
    List<List<double>> g = new List<List<double>>();

    int from, to = 0;

    for (int i = 0; i < buildings.length; i++) {
      if (buildings[i].name == searchTextField.textField.controller.text) {
        from = buildings[i].index;
      } else if (buildings[i].name ==
          searchTextField1.textField.controller.text) {
        to = buildings[i].index;
      } else
        continue;
    }

    print('From: ');
    print(from);
    print('To: ');
    print(to);

    //GRAPH
    g = [
      [0.0, 0.5, 2.0, 1.5, 0.5, 0.0, 2.0, 0.0],
      [0.5, 0.0, 0.0, 0.0, 0.5, 0.0, 0.0, 0.0],
      [2.0, 0.0, 0.0, 0.5, 0.0, 0.0, 1.5, 0.0],
      [1.5, 0.0, 0.5, 0.0, 0.0, 0.0, 0.0, 0.0],
      [0.5, 0.5, 0.0, 0.0, 0.0, 3.0, 0.0, 3.5],
      [0.0, 0.0, 0.0, 0.0, 3.0, 0.0, 0.0, 0.5],
      [2.0, 0.0, 1.5, 0.0, 0.0, 0.0, 0.0, 0.0],
      [0.0, 0.0, 0.0, 0.0, 3.5, 0.5, 0.0, 0.0]
    ];

    dijkstras(g, 8, from, to);
  }

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
                  padding: EdgeInsets.only(top: 20.0),
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
                  padding: EdgeInsets.only(top: 3.0, bottom: 10.0),
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
                    ? Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text('Estimated Time',
                                style: TextStyle(
                                  color: Colors.teal[500],
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500,
                                )),
                            Text('${ETA}',
                                style: TextStyle(
                                    fontSize: 35.0,
                                    fontWeight: FontWeight.w500)),
                            Text('min'),
                          ],
                        ),
                      )
                    : SizedBox(),
                navigate
                    ? Padding(
                        padding:
                            EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
                        child: Container(
                          height: 300.0,
                          width: 300.0,
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: buildings.length,
                              itemBuilder: (BuildContext context, int i) {
                                if (printPath[i] < 0)
                                  return SizedBox();
                                else {
                                  String buildingName = '';
                                  for (int j = 0; j < buildings.length; j++) {
                                    if (buildings[j].index == printPath[i]) {
                                      buildingName = buildings[j].name;
                                      break;
                                    }
                                  }
                                  return Padding(
                                    padding: EdgeInsets.only(top: 10.0),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.keyboard_arrow_down,
                                              color: Colors.grey[i * 100 + 100],
                                              size: 40.0),
                                          Expanded(
                                            child: Text('${buildingName}',
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight:
                                                        FontWeight.w300)),
                                          ),
                                        ]),
                                  );
                                }
                              }),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ],
        )),
      ],
    );
  }
}
