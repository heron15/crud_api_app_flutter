import 'package:crud_operation_flutter/data/model/product_model.dart';
import 'package:crud_operation_flutter/utils/app_color.dart';
import 'package:crud_operation_flutter/view/screens/HomeScreen/inner/custom_product_list.dart';
import 'package:crud_operation_flutter/view/widgets/custom_alert_dialog.dart';
import 'package:flutter/material.dart';

class CustomSearch extends SearchDelegate {
  CustomSearch({
    required this.productList,
    required this.onTapGoEditProductScreen,
    required this.deleteProduct,
    required this.onDeleteProduct,
  });

  final List<ProductModel> productList;
  final Function onTapGoEditProductScreen;
  final Function deleteProduct;
  final Function onDeleteProduct;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<ProductModel> matchQuery = [];
    for (var item in productList) {
      if (item.productName != null &&
          item.productName!.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return CustomProductList(
            productModel: result,
            onPressedEdit: () {
              onTapGoEditProductScreen(result);
            },
            onPressedDelete: () {
              customAlertDialog(
                context,
                'Are you sure you want to delete it!',
                () {
                  Navigator.pop(context);
                },
                () {
                  deleteProduct(result.sId);
                  onDeleteProduct();
                  Navigator.pop(context);
                },
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<ProductModel> matchQuery = [];
    for (var item in productList) {
      if (item.productName != null &&
          item.productName!.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return CustomProductList(
            productModel: result,
            onPressedEdit: () {
              onTapGoEditProductScreen(result);
            },
            onPressedDelete: () {
              customAlertDialog(
                context,
                'Are you sure you want to delete it!',
                () {
                  Navigator.pop(context);
                },
                () {
                  deleteProduct(result.sId);
                  onDeleteProduct();
                  Navigator.pop(context);
                },
              );
            },
          );
        },
      ),
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      scaffoldBackgroundColor: AppColor.white,
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: AppColor.white),
        labelStyle: TextStyle(color: AppColor.white),
        border: InputBorder.none,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          color: AppColor.white,
        ),
      ),
    );
  }
}
