import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:servisfy_mobile/Pages/Parent/messages/message_screen.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var isLoading = false;
  final TextEditingController _search = TextEditingController();
  final TextEditingController _message = TextEditingController();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  var name = "";
  Map<String, dynamic>? userMap;

  String chatRoomId(String user1, String user2) {
    if (user1[0].toLowerCase().codeUnits[0] >
        user2.toLowerCase().codeUnits[0]) {
      return "$user1$user2";
    } else {
      return "$user2$user1";
    }
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  String? roomId;
  void onMapping(String email) async {
    setState(() {
      isLoading = true;
    });

    await _firestore
        .collection("users")
        .where("email", isEqualTo: email)
        .get()
        .then((data) {
      userMap = data.docs[0].data();
      setState(() {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MessagesScreen(
                  chatRoomId: roomId!,
                  userMap: userMap!,
                )));
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              SizedBox(
                height: size.height / 20,
              ),
              Container(
                height: size.height / 14,
                width: size.width / 1.15,
                child: TextField(
                  controller: _search,
                  onChanged: (val) {
                    setState(() {
                      name = val;
                    });
                  },
                  decoration: InputDecoration(
                      hintText: "Arama",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              ),
              SizedBox(
                height: size.height / 30,
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .snapshots(),
                    builder: (context, snapshot) {
                      return (snapshot.connectionState ==
                              ConnectionState.waiting)
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Padding(
                              padding:
                                  const EdgeInsets.only(left: 22.0, right: 20),
                              child: ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    var data = snapshot.data!.docs[index].data()
                                        as Map<String, dynamic>;

                                    if (name.isEmpty) {
                                      return Card(
                                        shape: BeveledRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0)),
                                        child: ListTile(
                                          onTap: () {
                                            roomId = chatRoomId(
                                                _auth.currentUser!.email!,
                                                data["email"]);
                                            onMapping(data["email"].toString());
                                          },
                                          title: Text(
                                            data["name"],
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          subtitle: Text(
                                            data["email"],
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    if (data["name"]
                                        .toString()
                                        .toLowerCase()
                                        .startsWith(name.toLowerCase())) {
                                      return Card(
                                        child: ListTile(
                                          onTap: () {
                                            roomId = chatRoomId(
                                                _auth.currentUser!.email!,
                                                data["email"]);
                                            onMapping(data["email"].toString());
                                          },
                                          title: Text(
                                            data["name"],
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                          subtitle: Text(
                                            data["email"],
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    return Container();
                                  }),
                            );
                    }),
              ),
            ],
          );
  }
}
