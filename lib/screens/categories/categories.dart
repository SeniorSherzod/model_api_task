import 'package:flutter/material.dart';
import '../../data/models/categories/categories.dart';
import '../../data/models/network_responce.dart';
import '../../data/repository/categories_repository.dart';
import '../product/product.dart';
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final CategoriesRepository categoriesRepository = CategoriesRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),
      body: FutureBuilder(
        future: categoriesRepository.getCategories(),
        builder: (
            BuildContext context,
            AsyncSnapshot<NetworkResponse> snapshot,
            ) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (snapshot.hasData) {
            List<CategoriesModel> categories =
            (snapshot.data as NetworkResponse).data as List<CategoriesModel>;

            return ListView(
              children: List.generate(
                categories.length,
                    (index) {
                  CategoriesModel categoriesModel = categories[index];
                  return ListTile(
                    onTap:(){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ProductScreen(id: categoriesModel.id);
                          },
                        ),
                      );
                    },
                    leading: Image.network(categoriesModel.imageUrl),
                    title: Text(categoriesModel.name),
                    subtitle: Text(categoriesModel.id.toString()),
                    // trailing: Text(productModel.price.toString()),
                  );
                },
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}