import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../Utils/Helpers/Cloud_FireStore_Helper/cloud_firestore_helper.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  TextEditingController nameController = TextEditingController();
  TextEditingController postcon = TextEditingController();
  TextEditingController salarycon = TextEditingController();
  String? name;
  String? post;
  String? salary;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text("Add Details Here"),
              content: SizedBox(
                height: 300,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      onChanged: (val) {
                        name = val;
                      },
                      decoration: InputDecoration(
                        hintText: "enter name",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: postcon,
                      onChanged: (val) {
                        post = val;
                      },
                      decoration: InputDecoration(
                        hintText: "enter Your Designation",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: salarycon,
                      onChanged: (val) {
                        salary = val;
                      },
                      decoration: InputDecoration(
                        hintText: "enter salary",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        CloudFireStoreHelper.cloudFireStoreHelper
                            .addEmployee(emp_details: {
                          "name": name,
                          "post": post,
                          "salary": salary,
                        });

                        log("${post}");
                        log("${name}");
                        log("${salary}");
                        nameController.clear();
                        postcon.clear();
                        salarycon.clear();
                        Navigator.pop(context);
                      },
                      child: Text("Add Details"),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        label: Text("Add Employee Details"),
        icon: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text("Employee Details"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: CloudFireStoreHelper.cloudFireStoreHelper.fetchEmployee(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else if (snapshot.hasData) {
            List<QueryDocumentSnapshot<Map<String, dynamic>>>? data =
                snapshot.data?.docs;
            return ListView.builder(
                itemCount: data?.length,
                itemBuilder: (ctx, i) {
                  return Card(
                    child: ListTile(
                      title: Text("${data?[i]['name']}"),
                      subtitle: Text("${data?[i]['post']}"),
                      trailing: Text("${data?[i]['salary']}"),
                    ),
                  );
                });
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
