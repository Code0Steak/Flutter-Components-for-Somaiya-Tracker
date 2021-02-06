import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:somaiyatrackercomponents/models/building_data.dart';

class NavigateComponent extends StatefulWidget {
  @override
  _NavigateComponentState createState() => _NavigateComponentState();
}

class _NavigateComponentState extends State<NavigateComponent> {
  AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<Building>> key = new GlobalKey();

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
            Image(
              image:
                  AssetImage('assets/images/component_images/map_3d_icon.png'),
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
                            width: 300.0,
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
                                  hintText: 'Search Location...',
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
                )
              ],
            )
          ],
        )),
      ],
    );
  }
}
