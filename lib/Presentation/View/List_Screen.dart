import 'package:counter_task/Presentation/View/Home_Page.dart';
import 'package:counter_task/Presentation/ViewModel/list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ListProvider>().fetchList();
    });


    scrollController.addListener(() {
      if(scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
        print("Calling #####");
        context.read<ListProvider>().fetchList();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final listProvider = context.watch<ListProvider>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage())), icon: Icon(Icons.arrow_back,color: Colors.white,)),
        title: Text("List Screen", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: ListView.builder(
        controller: scrollController,
          itemCount: listProvider.list.length + (listProvider.isLoading ? 1 : 0),
          itemBuilder: (context, index) {
          if (index < listProvider.list.length) {
            final listData = listProvider.list[index];
            return ListTile(
              leading: CircleAvatar(child: Text(listData.id.toString())),
              title: Text(listData.title),
              subtitle: Text(listData.body),
            );
          } else {
            return const Padding(
                padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            );
          }
        }
      ),
    );
  }
}
