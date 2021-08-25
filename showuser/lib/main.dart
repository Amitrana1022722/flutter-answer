import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var user;
  String? selectedPage = '1';
  Future fetchUser() async {
    var url = 'https://reqres.in/api/users?page=$selectedPage';
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        setState(() {
          user = json.decode(response.body); // notifying change in user
        });
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  DropdownButton<String> getAndroidDropButton() {
    // creating dropdown button using the total pages number of json
    List<DropdownMenuItem<String>> dropList = [];
    if (user != null) {
      for (int i = 1; i <= user['total_pages']; i++) {
        dropList.add(
          // creating droplist
          DropdownMenuItem(
            child: Text('${i}'),
            value: '${i}',
          ),
        );
      }
    }
    return DropdownButton<String>(
      value: selectedPage,
      items: dropList,
      onChanged: (value) {
        print(value);
        setState(() {
          selectedPage = value; // notifying on change of value of selected
          getdata(); // getting the selected page data
        });
      },
    );
  }

  Future getdata() async {
    // to wait for the fetchUser function  to fetch user's data
    await fetchUser();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('User List')),
          actions: [
            Container(
              height: 100.0,
              width: 60.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.white,
              child:
                  getAndroidDropButton(), // using dropdown menu to display list of pages
            ),
          ],
        ),
        body: (user == null)
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                // using ListView builder to show and create list
                itemBuilder: (context, index) {
                  var userdata =
                      user['data'][index]; // fetching user detail by index
                  return Card(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                  radius: 20.0,
                                  backgroundImage: NetworkImage(userdata[
                                      'avatar']), // using network image to fetch image
                                  backgroundColor: Colors.transparent),
                              SizedBox(width: 16.0),
                              Text(
                                '${userdata['first_name']} ${userdata['last_name']}', // getting user first and last name and concatenating them
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.0,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Email : ${userdata['email']}', // getting email address
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18.0,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: (user == null)
                    ? 0
                    : user['per_page'], // setting up the listview size
              ),
      ),
    );
  }
}
