import 'package:flutter/material.dart';
import 'package:forpost/src/Repos/get_cameras_list.dart';
import 'package:forpost/src/View/camera_screen.dart';

class CameraListScreen extends StatelessWidget {
  const CameraListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('Камеры'),
      ),
      body: FutureBuilder(
        future: GetCamerasListRepo.GetCamerasList(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: snapshot.data!
                    .map<Widget>(
                        (e) => CameraCard(id: e.cameraID, name: e.name))
                    .toList(),
              ),
            );
          }
        },
      ),
    );
  }
}

class CameraCard extends StatelessWidget {
  final String id;
  final String name;
  const CameraCard({super.key, required this.id, required this.name});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name.toString(),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'ID: $id',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              )
            ],
          ),
          InkWell(
            onTap: () {
              // Route route = MaterialPageRoute(
              //     builder: (context) =>
              //          VideoPlayerPage(id: int.parse(id), name: name));
              // Navigator.push(context, route);
            },
            child: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(100)),
              child: const Center(
                  child: Icon(Icons.arrow_forward_ios,
                      color: Colors.white, size: 25)),
            ),
          )
        ],
      ),
    );
  }
}
