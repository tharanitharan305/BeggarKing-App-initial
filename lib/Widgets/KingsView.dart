import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KingsView extends StatelessWidget {
  Widget build(context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('King details')
            .orderBy('Launched_at', descending: true)
            .snapshots(),
        builder: (((context, snapshot) {
          if (!snapshot.hasData) return Text('No Kings Found....');
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          if (snapshot.hasError) return Text(snapshot.error.toString());
          final King_List = snapshot.data!.docs;
          return ListView.builder(
              itemCount: King_List.length,
              itemBuilder: (ctx, i) {
                return Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          Image(
                            image: NetworkImage(
                                '${King_List[i].data()['King_url']}'),
                          ),
                          Text('Address : ${King_List[i].data()['Address']}'),
                          Text(
                              'Found by : ${King_List[i].data()['Launched_at']}'),
                        ],
                      ),
                    ),
                  ],
                );
              });
        })));
  }
}
