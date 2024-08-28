import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uep/bloc/working_day/working_day_bloc.dart';
import 'package:uep/bloc/working_day/working_day_event.dart';
import 'package:uep/bloc/working_day/working_day_state.dart';
import 'package:uep/models/working_day_model.dart';
import 'package:uep/ui/admin/widget/shimmer_users_loading.dart';

class WorkingDaysPage extends StatelessWidget {
  const WorkingDaysPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Working Days"),
        centerTitle: true,
      ),
      body: BlocBuilder<WorkingDayBloc, WorkingDayState>(
        bloc: context.read<WorkingDayBloc>()..add(GetWorkingDays()),
        builder: (context, state) {
          if (state is WorkingDayLoading) {
            return const ShimmerUsersLoading();
          } else if (state is WorkingDayError) {
            return Center(
              child: Scaffold(
                body: Center(
                  child: Text("Xatolik yuz berdi: ${state.message}"),
                ),
              ),
            );
          } else if (state is WorkingDayLoaded) {
            List<WorkingDay> days = state.days;
            return ListView.builder(
              itemCount: days.length,
              itemBuilder: (context, index) {
                WorkingDay day = days[index];
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey[400],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(day.day.name),
                      Row(
                        children: [
                          FilledButton(
                            onPressed: () {},
                            child: Text(
                              day.openingTime ?? "—",
                            ),
                          ),
                          const SizedBox(width: 15),
                          FilledButton(
                            onPressed: () {},
                            child: Text(
                              day.closingTime ?? "—",
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
