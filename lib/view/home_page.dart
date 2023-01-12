import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:employees/provider/employee_provider.dart';
import 'package:employees/widgets/custom_avatar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final employeeProvider =
        Provider.of<EmployeeProvider>(context, listen: false);
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            color: Colors.deepPurple,
          ),
          height: MediaQuery.of(context).size.height * 0.2,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Employee",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: TextFormField(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 20),
                      hintText: "Search with employee name",
                      fillColor: Colors.white,
                      suffixIcon: const Icon(Icons.search),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      )),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
            ],
          ),
        ),
        Expanded(
            child: StreamBuilder<QuerySnapshot>(
          stream: employeeProvider.getEmployeeData(),
          builder: (context, snapshot) {
            if (!snapshot.hasData ||
                snapshot.connectionState == ConnectionState.waiting) {
              return Shimmer.fromColors(
                  baseColor: Colors.grey.shade700,
                  highlightColor: Colors.grey.shade100,
                  child: ListView.builder(
                      itemCount: 4,
                      itemBuilder: ((context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Container(
                              height: 50,
                              width: 50,
                              color: Colors.white,
                            ),
                            title: Container(
                              height: 10,
                              width: 89,
                              color: Colors.white,
                            ),
                            subtitle: Container(
                              height: 10,
                              width: 89,
                              color: Colors.white,
                            ),
                          ),
                        );
                      })));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> map =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  String employeeName = map["name"].toString();
                  Timestamp date = map['joiningDate'];
                  DateTime date2 = date.toDate();
                  DateTime hiredate = DateTime.parse(date2.toString());
                  DateTime today = DateTime.now();
                  Duration diffrence = today.difference(hiredate);
                  final diff2 = diffrence.inDays / 365;

                  if (_searchController.text.isEmpty) {
                    return Column(
                      children: [
                        ListTile(
                          leading: CustomAvatar(
                              color: diff2 >= 5
                                  ? map['active'] == true
                                      ? Colors.green
                                      : Colors.red
                                  : map['active'] == false
                                      ? Colors.red
                                      : Colors.deepPurple,
                              url: map["imageUrl"]),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(map["name"].toString()),
                              Text(
                                map["jobTitle"].toString(),
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.grey),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                            ],
                          ),
                          subtitle: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.mail,
                                size: 20,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(map["email"].toString()),
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 0.9,
                          color: Colors.black,
                        )
                      ],
                    );
                  } else if (employeeName
                      .toLowerCase()
                      .contains(_searchController.text.toLowerCase())) {
                    return Column(
                      children: [
                        ListTile(
                          leading: CustomAvatar(
                              color: diff2 >= 5
                                  ? map['active'] == true
                                      ? Colors.green
                                      : Colors.red
                                  : map['active'] == false
                                      ? Colors.red
                                      : Colors.deepPurple,
                              url: map["imageUrl"]),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(map["name"].toString()),
                              Text(
                                map["jobTitle"].toString(),
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.grey),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                            ],
                          ),
                          subtitle: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.mail,
                                size: 20,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(map["email"].toString()),
                            ],
                          ),
                        ),
                        const Divider(
                          thickness: 0.9,
                          color: Colors.black,
                        )
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              );
            }
          },
        ))
      ],
    ));
  }
}
