import 'package:cargo/Home/filter.dart';
import 'package:cargo/Home/search.dart';
import 'package:flutter/material.dart';
import '../reusable/drawer.dart';

class home extends StatefulWidget {
  home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 5, 171, 236),
        title: Text("Home"),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => search())),
              icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () async {
                var result = await Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) {
                  return FilterScreen();
                }));
                print(result);
              },
              icon: const Icon(Icons.sort))
        ],
      ),
      drawer: MyDrawer(currPage: "Home"),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Row(
            children: <Widget>[],
          ),
        ],
      ),
    ));
  }
}
