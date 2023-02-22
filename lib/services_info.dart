import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_place/third_screen.dart';
import 'package:flutter/material.dart';

class ServicesInfo extends StatelessWidget {
  

  
  final String title;
  const ServicesInfo(this.title, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection(title).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (BuildContext context, int index) {
            var servicesInfo =
                snapshot.data!.docs[index].data() as Map<String, dynamic>;
            String img = servicesInfo['img'];
            String name = servicesInfo['name'];
            double latitude = servicesInfo['latitude'];
            double longitude = servicesInfo['longitude'];
            String title = this.title;
            return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    
                    builder: (context) => ThirdScreen(title:title, name: name, latitude: latitude, longitude: longitude),
                  ));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    color: Colors.grey[300],
                    child: Image.network(
                      img,
                      fit: BoxFit.cover,
                    ),
                  ),
                ));
          },
        );
      },
    );
  }
}