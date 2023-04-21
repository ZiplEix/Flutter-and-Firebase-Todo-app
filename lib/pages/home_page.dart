import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/Widgets/todo_card_widget.dart';
import 'package:todo_app/pages/add_todo.dart';
import 'package:todo_app/pages/profil_page.dart';
import 'package:todo_app/pages/todo_page.dart';
import 'package:todo_app/services/auth_services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Select> selected = [];

  @override
  Widget build(BuildContext context) {
    AuthClass authClass = AuthClass();

    final Stream<QuerySnapshot> dbDtream =
        FirebaseFirestore.instance.collection("Todo").snapshots();

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text(
          "Today's Schedule",
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage("assets/rocket.png"),
          ),
          SizedBox(width: 25)
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(35),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 22),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Monday 24",
                    style: TextStyle(
                      fontSize: 33,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff8a32f1),
                      letterSpacing: 1,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      var instance =
                          FirebaseFirestore.instance.collection("Todo");
                      for (var i = 0; i < selected.length; i++) {
                        if (selected[i].checkValue) {
                          instance.doc(selected[i].id).delete();
                        }
                      }
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: StreamBuilder(
        stream: dbDtream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              IconData iconData;
              Color iconColor;
              Map<String, dynamic> document =
                  snapshot.data?.docs[index].data() as Map<String, dynamic>;
              switch (document["category"]) {
                case "Work":
                  iconData = Icons.work;
                  iconColor = Colors.yellow;
                  break;
                case "WorkOut":
                  iconData = Icons.alarm;
                  iconColor = Colors.teal;
                  break;
                case "Food":
                  iconData = Icons.local_grocery_store;
                  iconColor = Colors.blue;
                  break;
                case "Design":
                  iconData = Icons.audiotrack;
                  iconColor = Colors.green;
                  break;
                case "Run":
                  iconData = Icons.run_circle_outlined;
                  iconColor = Colors.red;
                  break;
                default:
                  iconData = Icons.do_not_disturb;
                  iconColor = Colors.black;
              }
              selected.add(Select(
                id: snapshot.data?.docs[index].id,
                checkValue: false,
              ));
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (builder) => TodoPage(
                        document: document,
                        id: snapshot.data?.docs[index].id,
                      ),
                    ),
                  );
                },
                child: TodoCardWidget(
                  title: document["title"] ?? "NO TITLE",
                  iconData: iconData,
                  iconColor: iconColor,
                  time: "10 AM",
                  check: selected[index].checkValue,
                  iconBgColor: Colors.white,
                  index: index,
                  onChange: onChange,
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black87,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.white,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => const AddTodoPage()));
              },
              child: Container(
                height: 52,
                width: 52,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: [
                      Colors.indigoAccent,
                      Colors.purple,
                    ])),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => const ProfilPage()));
              },
              child: const Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ),
            label: "",
          ),
        ],
      ),
    );
  }

  void onChange(int index) {
    setState(() {
      selected[index].checkValue = !selected[index].checkValue;
    });
  }
}

class Select {
  Select({
    required this.id,
    required this.checkValue,
  });

  String? id;
  bool checkValue = false;
}

// Future use
// IconButton(
//   onPressed: () async {
//     await authClass.logout();
//     // ignore: use_build_context_synchronously
//     Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(builder: (builder) => const SignInPage()),
//         (route) => false);
//   },
//   icon: const Icon(Icons.logout),
// ),
