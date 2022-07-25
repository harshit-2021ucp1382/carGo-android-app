import 'package:flutter/material.dart';
import 'dart:convert';

class FilterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FilterScreenState();
  }
}

class Seats {
  String filter_id;
  String number;
  bool isSelected;
  Seats(this.filter_id, this.number, this.isSelected);
}

class Ratings {
  String Rating_id;
  String Rating;
  bool isSelected;
  Ratings(this.Rating_id, this.Rating, this.isSelected);
}

class FilterScreenState extends State<FilterScreen> {
  bool isPrice = false;
  bool isRating = false;
  bool isLatest = false;
  bool isLoc = false;
  bool isFilter = false;
  List<String> selected = List.empty(growable: true);
  List<Seats> filter_three = [
    Seats("S1", "2", false),
    Seats("S2", "4", false),
    Seats("S3", "6", false),
    Seats("S4", "8", false),
  ];
  List<Ratings> filter_rating = [
    Ratings("R1", "1", false),
    Ratings("R2", "2", false),
    Ratings("R3", "3", false),
    Ratings("R4", "4", false),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color.fromARGB(255, 234, 229, 235),
              Color.fromARGB(255, 214, 215, 218)
            ])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            leading: MaterialButton(
                onPressed: () {
                  Navigator.pop(context, "");
                },
                child: Icon(Icons.arrow_back_ios, color: Colors.white)),
            actions: [
              MaterialButton(onPressed: () {
                setState(() {
                  filter_three.forEach((element) {
                    element.isSelected = false;
                  });

                  isFilter = false;
                  isPrice = false;
                  isLatest = false;
                  isLoc = false;
                  isRating = false;
                });
              }),
              MaterialButton(
                  onPressed: () {
                    Map<String, dynamic> filters = Map();
                    filters['Price'] = (isPrice) ? 1 : 0;
                    filters['Latest'] = (isLatest) ? 1 : 0;
                    filters['Location'] = (isLoc) ? 1 : 0;
                    filters['Ratings'] = (isRating) ? 1 : 0;
                    filters['cat'] = (selected);
                    Navigator.pop(context, jsonEncode(filters));
                  },
                  child: Text(
                    "Apply",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                        child: Text("Sort By",
                            style:
                                TextStyle(color: Colors.black, fontSize: 15))),
                    SizedBox(
                      height: 10,
                    ),
                    Row(children: <Widget>[
                      Checkbox(
                          value: isPrice,
                          onChanged: (value) {
                            setState(() {
                              isPrice = value!;
                              isFilter = true;
                            });
                          }),
                      Text("Price", style: TextStyle(color: Colors.deepPurple)),
                    ]),
                    Row(children: [
                      Checkbox(
                          value: isLatest,
                          onChanged: (value) {
                            setState(() {
                              isLatest = value!;
                            });
                          }),
                      Text("Latest",
                          style: TextStyle(color: Colors.deepPurple)),
                    ]),
                    Row(children: [
                      Checkbox(
                          value: isLoc,
                          onChanged: (value) {
                            setState(() {
                              isLoc = value!;
                            });
                          }),
                      Text("Location",
                          style: TextStyle(color: Colors.deepPurple)),
                    ]),
                    SizedBox(
                      height: 20,
                    ),
                    Divider(
                      height: 2,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                        child: Text("Filter By",
                            style:
                                TextStyle(color: Colors.black, fontSize: 15))),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Seats", style: TextStyle(color: Colors.blue)),
                    SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      spacing: 8,
                      direction: Axis.horizontal,
                      children: techChips(
                          filter_three, Color.fromARGB(255, 69, 118, 158)),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Ratings", style: TextStyle(color: Colors.blue)),
                    SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      spacing: 8,
                      direction: Axis.horizontal,
                      children: techRatings(
                          filter_rating, Color.fromARGB(255, 69, 118, 158)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  List<Widget> techChips(List<Seats> _chipsList, color) {
    List<Widget> chips = [];
    for (int i = 0; i < _chipsList.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(left: 10, right: 5),
        child: FilterChip(
          selectedColor: color,
          label: Text(_chipsList[i].number),
          labelStyle: TextStyle(color: Colors.white),
          backgroundColor: color,
          selected: _chipsList[i].isSelected,
          checkmarkColor: Colors.white,
          onSelected: (bool value) {
            if (value) {
              selected.add(_chipsList[i].filter_id);
              selected.add(_chipsList[i].number);
            } else {
              selected.remove(_chipsList[i].filter_id);
              selected.remove(_chipsList[i].number);
            }
            setState(() {
              _chipsList[i].isSelected = value;
            });
          },
        ),
      );
      chips.add(item);
    }
    return chips;
  }

  List<Widget> techRatings(List<Ratings> _chipsList, color) {
    List<Widget> chips = [];
    for (int i = 0; i < _chipsList.length; i++) {
      Widget item = Padding(
        padding: const EdgeInsets.only(left: 10, right: 5),
        child: FilterChip(
          selectedColor: color,
          label: Text(_chipsList[i].Rating),
          labelStyle: TextStyle(color: Colors.white),
          backgroundColor: color,
          selected: _chipsList[i].isSelected,
          checkmarkColor: Colors.white,
          onSelected: (bool value) {
            if (value) {
              selected.add(_chipsList[i].Rating_id);
              selected.add(_chipsList[i].Rating);
            } else {
              selected.remove(_chipsList[i].Rating_id);
              selected.remove(_chipsList[i].Rating);
            }
            setState(() {
              _chipsList[i].isSelected = value;
            });
          },
        ),
      );
      chips.add(item);
    }
    return chips;
  }
}
