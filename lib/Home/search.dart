import 'package:cargo/Home/filter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_place/google_place.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class search extends StatefulWidget {
  search({Key? key}) : super(key: key);

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  late GooglePlace googlePlace;

  List<AutocompletePrediction> predictions = [];
  List<dynamic> _placeList = [];

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.queryAutocomplete.get(value);
    if (result != null) {
      print(result.predictions);
    }

    if (result != null && result.predictions != null && mounted) {
      setState(() {
        predictions = result.predictions!;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    String apiKey = "AIzaSyBm3-zunHx8duapu2eNSWK1zxXAQlhB2Ac";
    googlePlace = GooglePlace(apiKey);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextField(
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    print(value);
                    autoCompleteSearch(value);
                  } else {
                    if (predictions.length > 0 && mounted) {
                      setState(() {
                        predictions = [];
                      });
                    }
                  }
                },
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {},
                    ),
                    hintText: 'Enter Location',
                    border: InputBorder.none),
              ),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => filter())),
                icon: const Icon(Icons.sort))
          ],
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: predictions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Icon(
                        Icons.pin_drop,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(predictions[index].description.toString()),
                    onTap: () {
                      debugPrint(predictions[index].placeId);
                    },
                  );
                },
              ),
            ),
          ],
        ));
    ;
  }
}
