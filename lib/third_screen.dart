
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart'; 

class ThirdScreen extends StatefulWidget {
  
  final String name;
  final String title;
  final double  longitude;
  final double  latitude;
  ThirdScreen({Key? key,required this.name,required this.title, required this.longitude,required this.latitude}) : super(key: key);

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
    
  
  
  late final GoogleMapController mapController;  
  static final LatLng _center = LatLng(22.817391183804034, 89.56077152613126);  
  final Set<Marker> _markers = {};  
  LatLng _currentMapPosition = _center;

 
  


  void _onAddMarkerButtonPressed() {  
    setState(() {  
      _markers.add(Marker(  
        markerId: MarkerId(_currentMapPosition.toString()),  
        position: _currentMapPosition,  
        infoWindow: InfoWindow(  
          title: 'Nice Place',  
          snippet: 'Welcome to Poland'  
        ),  
        icon: BitmapDescriptor.defaultMarker,  
      ));  
    });  
  }

  void _onCameraMove(CameraPosition position) {  
    _currentMapPosition = position.target;  
  }  
  
  void _onMapCreated(GoogleMapController controller) {  
    mapController = controller;  
  }  
  
  
  @override
  Widget build(BuildContext context) {
    
  
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
      .collection(widget.title).doc("ltfCwz1BYhzB7PwRKOma").collection('contact')
      .snapshots(),
        
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 56, 96, 142),
            title: Text(widget.name),
          ),
          body: Column(
                children: <Widget>[
                  
                Container(
                        height: 300,
                        child: GoogleMap(
                          onMapCreated: _onMapCreated,  
                          initialCameraPosition: CameraPosition(  
                            target: _center,  
                            zoom: 15.0,  
                          ),  
                          markers: _markers,  
                          onCameraMove: _onCameraMove  
                        ),
                ),
                      Padding(  
                        padding: const EdgeInsets.all(14.0),  
                        child: Align(  
                          alignment: Alignment.topRight,  
                          child: FloatingActionButton(  
                            onPressed: _onAddMarkerButtonPressed,  
                            materialTapTargetSize: MaterialTapTargetSize.padded,  
                            backgroundColor: Color.fromARGB(255, 56, 96, 142),  
                            child: const Icon(Icons.map, size: 30.0),  
                          ),  
                        ),  
                      ),  
                   
                   Expanded(
                     child: ListView.builder(
                       itemCount: snapshot.data!.docs.length,
                       itemBuilder: (BuildContext context, int index) {
                         var servicesInfo =snapshot.data!.docs[index].data() as Map<String, dynamic>;
                         
                         String name = servicesInfo['name'];
                         String phone = servicesInfo['phone'];
                         return Card(
                           child: ListTile(
                             title: Text(name),
                             subtitle: Text(phone),
                           ),
                         );
                       },
                     ),
                 )
               
              
            ]
          )    
        );
      }
    );
  }

}
// 


//  GridView.builder(
//                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                    crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
//                    itemCount: snapshot.data!.docs.length, 
//                    itemBuilder: (BuildContext context, int index) {
//                      var servicesInfo =snapshot.data!.docs[index].data() as Map<String, dynamic>;
//                      String img = servicesInfo['img'];
//                      String name = servicesInfo['name'];
//                      return Container(
//                        child: ClipRRect(
//                     borderRadius: BorderRadius.circular(20),
//                     child: Container(
//                       height: 20,
//                       color: Colors.grey,
//                 )
//               )
//              );
//             },
//           ),




