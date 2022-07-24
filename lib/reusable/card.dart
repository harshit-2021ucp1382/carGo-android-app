import 'package:cargo/Home/car_details.dart';
import 'package:cargo/Home/home_screen.dart';
import 'package:cargo/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class MyCard extends StatefulWidget {
  const MyCard({Key? key, required this.data}) : super(key: key);

  final cardData data;

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  late cardData data;
  @override
  void initState() {
    super.initState();
    data = widget.data;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.network(
              widget.data.image.toString(),
              width: double.infinity,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: [
                      Text(
                        "${widget.data.carModel.toString()}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      //Text(data["Details"]),
                    ],
                  ),
                  Text("${widget.data.Rating.toString()}/5 stars"),
                  ElevatedButton(
                      onPressed: () {},
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Text(widget.data.Price.toString()),
                            SizedBox(
                              width: 3,
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => carDetails(
                                            data: data as cardData)));
                              },
                              icon: const Icon(Icons.arrow_forward_sharp),
                            )
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
