import 'package:cars_api_task/utils/extensions/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../data/models/network_responce.dart';
import '../../data/models/product/product.dart';
import '../../data/repository/product_repository.dart';
import '../../utils/colors/app_colors.dart';
class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.id});
  final int id;
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductRepository countryRepository = ProductRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product" , style : TextStyle(
          color: AppColors.white,
          fontSize: 40,
        )),
      ),
      body: FutureBuilder(
        future: countryRepository.getCountries(widget.id),
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
            List<ProductModel> product =
            (snapshot.data as NetworkResponse).data as List<ProductModel>;

            return GridView.builder(
              padding: EdgeInsets.all(20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.6,
                crossAxisCount: 2, // Number of columns in the grid
                crossAxisSpacing: 50, // Spacing between columns
                mainAxisSpacing: 20, // Spacing between rows
              ),
              itemCount: product.length,
              itemBuilder: (BuildContext context, int index) {
                ProductModel productModel = product[index];
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.c_53b175
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.network(productModel.imageUrl,height: 100,fit: BoxFit.cover,),
                      ListTile(
                        leading:Text(productModel.price.toString()),
                        title: Expanded(child: Text(productModel.name)),
                        subtitle: Text(productModel.id.toString()),
                        // trailing: Text(productModel.price.toString()),
                      ),
                    ],
                  ),
                );
              },
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