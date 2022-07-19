import 'package:flutter/material.dart';
import '../reusable/drawer.dart';

class help extends StatefulWidget {
  help({Key? key}) : super(key: key);

  @override
  State<help> createState() => _helpState();
}

class _helpState extends State<help> {
  bool _expanded = false;
  bool _expanded1 = false;
  var _test = "Full Screen";
  late String query;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color.fromARGB(255, 207, 58, 233),
              Color.fromARGB(255, 0, 94, 255)
            ])),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                "Help",
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Color.fromARGB(255, 90, 67, 218),
              automaticallyImplyLeading: true,
            ),
            drawer: MyDarwer(data: null, curr_page: "Contact Us"),
            body: SingleChildScrollView(
                child: Column(children: <Widget>[
              Stack(alignment: Alignment.center, children: <Widget>[
                Image.asset(
                  "assets/img/help.jpg",
                  fit: BoxFit.fitWidth,
                  width: double.infinity,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: TextFormField(
                      autofocus: false,
                      keyboardType: TextInputType.name,
                      onSaved: (value) {
                        query = value!;
                      },
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromARGB(118, 196, 189, 189),
                        prefixIcon: Icon(Icons.search),
                        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                        hintText: "Search Your query",
                        hintStyle: TextStyle(color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      )),
                ),
              ]),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                color: Colors.green,
                child: ExpansionPanelList(
                  animationDuration: Duration(milliseconds: 200),
                  children: [
                    ExpansionPanel(
                      headerBuilder: (context, isExpanded) {
                        return ListTile(
                            title: Row(children: <Widget>[
                          Text(
                            'Guide',
                            style: TextStyle(color: Colors.black),
                          ),
                        ]));
                      },
                      body: ListTile(
                        title: Text('Description text',
                            style: TextStyle(color: Colors.black)),
                      ),
                      isExpanded: _expanded,
                      canTapOnHeader: true,
                    ),
                  ],
                  dividerColor: Colors.grey,
                  expansionCallback: (panelIndex, isExpanded) {
                    _expanded = !_expanded;
                    setState(() {});
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                color: Colors.transparent,
                child: ExpansionPanelList(
                  animationDuration: Duration(milliseconds: 200),
                  children: [
                    ExpansionPanel(
                      headerBuilder: (context, isExpanded) {
                        return ListTile(
                            title: Row(children: <Widget>[
                          Text(
                            'FAQ',
                            style: TextStyle(color: Colors.black),
                          ),
                        ]));
                      },
                      body: ListTile(
                        title: Text('Description text',
                            style: TextStyle(color: Colors.black)),
                      ),
                      isExpanded: _expanded1,
                      canTapOnHeader: true,
                    ),
                  ],
                  dividerColor: Colors.grey,
                  expansionCallback: (panelIndex, isExpanded) {
                    _expanded1 = !_expanded1;
                    setState(() {});
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 60, vertical: 40),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.redAccent,
                  child: MaterialButton(
                      padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () {},
                      child: Text(
                        "Open A Ticket",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ),
            ]))));
  }
}
