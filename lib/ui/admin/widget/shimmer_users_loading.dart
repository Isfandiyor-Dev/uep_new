import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerUsersLoading extends StatelessWidget {
  const ShimmerUsersLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300, // Baza rangi biroz engilroq
      highlightColor: Colors.grey.shade100, // Yoritilgan rang yanada yorqin
      child: ListView.builder(
        itemCount: 15,
        padding: const EdgeInsets.all(10),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(15),
                leading: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400, // Avatar joyi uchun rang
                    shape: BoxShape.circle,
                  ),
                ),
                title: Container(
                  height: 25,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400, // Title joyi uchun rang
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Container(
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400, // Subtitle joyi uchun rang
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
