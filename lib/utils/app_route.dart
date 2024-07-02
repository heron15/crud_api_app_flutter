import 'package:crud_operation_flutter/data/model/product_model.dart';
import 'package:crud_operation_flutter/view/screens/AddProduct/add_product.dart';
import 'package:crud_operation_flutter/view/screens/EditProductScreen/edit_product_screen.dart';
import 'package:crud_operation_flutter/view/screens/HomeScreen/home_screen.dart';
import 'package:flutter/material.dart';

class AppRoute {
  static const String home = "/home";
  static const String addProduct = "/add_product";
  static const String editProductScreen = "/edit_product_screen";

  static MaterialPageRoute? generateRoute(RouteSettings settings) {
    Widget? widget;
    switch (settings.name) {
      case home:
        widget = const HomeScreen();
        break;
      case addProduct:
        widget = const AddProduct();
        break;
      case editProductScreen:
        ProductModel productModel = settings.arguments as ProductModel;
        widget = EditProductScreen(
          productModel: productModel,
        );
        break;
    }

    if (widget != null) {
      return MaterialPageRoute(builder: (context) => widget!);
    }

    return null;
  }
}
