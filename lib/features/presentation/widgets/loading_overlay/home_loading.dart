import 'package:counter_task/features/presentation/view_model/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<HomeViewModel, bool>(
      selector: (context, homeProvider) => homeProvider.isLoading,
      builder: (context, isLoading, child) {
        if (!isLoading) return const SizedBox.shrink();
        return Container(
          color: Colors.black54,
          child: const Center(
            child: CircularProgressIndicator(color: Colors.green),
          ),
        );
      },
    );
  }
}
