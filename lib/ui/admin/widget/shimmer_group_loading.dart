import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerGroupLoading extends StatelessWidget {
  const ShimmerGroupLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Teacher"),
        centerTitle: true,
      ),
      body: Shimmer.fromColors(
        baseColor: Colors.grey[400]!,
        highlightColor: Colors.grey[200]!,
        child: ListView.builder(
          itemCount: 15,
          padding: const EdgeInsets.all(15),
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: ListTile(
                contentPadding: const EdgeInsets.all(15),
                leading: const CircleAvatar(
                  backgroundColor: Colors.blue,
                  radius: 35,
                ),
                title: Container(
                  width: 200,
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                subtitle: Container(
                  width: 100,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
