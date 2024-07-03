import 'package:crud_operation_flutter/data/model/network_response_model.dart';
import 'package:crud_operation_flutter/data/model/product_model.dart';
import 'package:crud_operation_flutter/data/model/product_wrapper_model.dart';
import 'package:crud_operation_flutter/data/services/network_caller.dart';
import 'package:crud_operation_flutter/utils/api_url.dart';
import 'package:crud_operation_flutter/utils/app_color.dart';
import 'package:crud_operation_flutter/utils/app_route.dart';
import 'package:crud_operation_flutter/view/screens/CustomSearch/custom_search.dart';
import 'package:crud_operation_flutter/view/screens/HomeScreen/inner/custom_product_list.dart';
import 'package:crud_operation_flutter/view/screens/HomeScreen/inner/view_type.dart';
import 'package:crud_operation_flutter/view/widgets/custom_alert_dialog.dart';
import 'package:crud_operation_flutter/view/widgets/custom_toast.dart';
import 'package:crud_operation_flutter/view/widgets/loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'inner/custom_product_grid.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ViewType _viewType = ViewType.list;

  bool _productInProgress = false;
  bool _deleteInProgress = false;

  List<ProductModel> productList = [];

  @override
  void initState() {
    super.initState();
    _getProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CRUD App'),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearch(
                  productList: productList,
                  onTapGoEditProductScreen: onTapGoEditProductScreen,
                  deleteProduct: deleteProduct,
                  onDeleteProduct: _getProduct,
                ),
              );
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: _toggleViewType,
            icon: Icon(
              _viewType == ViewType.list ? Icons.grid_view : Icons.view_list_rounded,
            ),
          ),
          IconButton(
            onPressed: () {
              _onTapGoAddProductScreen();
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColor.appBar,
          onRefresh: () async {
            _getProduct();
          },
          child: Visibility(
            visible: _productInProgress == false,
            replacement: const Center(
              child: CircularProgressIndicator(
                color: AppColor.appBar,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: _viewType == ViewType.list

                  ///------list view item------///
                  ? ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: productList.length,
                      itemBuilder: (context, index) {
                        return CustomProductList(
                          productModel: productList[index],
                          onPressedEdit: () {
                            onTapGoEditProductScreen(productList[index]);
                          },
                          onPressedDelete: () {
                            customAlertDialog(
                              context,
                              'Are you sure you want to delete it!',
                              () {
                                Navigator.pop(context);
                              },
                              () {
                                deleteProduct(productList[index].sId);
                                Navigator.pop(context);
                              },
                            );
                          },
                        );
                      },
                    )

                  ///------Grid view item------///
                  : OrientationBuilder(
                      builder: (BuildContext context, Orientation orientation) {
                        return StaggeredGridView.countBuilder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: productList.length,
                          crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                          staggeredTileBuilder: (index) => const StaggeredTile.fit(1),
                          itemBuilder: (context, index) {
                            return CustomProductGrid(
                              productModel: productList[index],
                              onPressedEdit: () {
                                onTapGoEditProductScreen(productList[index]);
                              },
                              onPressedDelete: () {
                                customAlertDialog(
                                  context,
                                  'Are you sure you want to delete it!',
                                  () {
                                    Navigator.pop(context);
                                  },
                                  () {
                                    deleteProduct(productList[index].sId);
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
            ),
          ),
        ),
      ),
    );
  }

  ///------go to add product screen function------///
  void _onTapGoAddProductScreen() {
    Navigator.pushNamed(context, AppRoute.addProduct);
  }

  ///------go to edit screen function------///
  void onTapGoEditProductScreen(ProductModel productModel) {
    Navigator.pushNamed(
      context,
      AppRoute.editProductScreen,
      arguments: productModel,
    );
  }

  ///------view type(list/grid) change function------///
  void _toggleViewType() {
    setState(() {
      if (_viewType == ViewType.list) {
        _viewType = ViewType.grid;
      } else {
        _viewType = ViewType.list;
      }
    });
  }

  ///------get product api call function------///
  Future<void> _getProduct() async {
    _productInProgress = true;

    if (mounted) {
      setState(() {});
    }

    NetworkResponseModel response = await NetworkCaller.getRequest(ApiUrl.readUrl);

    if (response.isSuccess) {
      ProductWrapperModel productWrapperModel = ProductWrapperModel.fromJson(response.responseData);
      productList = productWrapperModel.productList ?? [];
    } else {
      if (mounted) {
        customToast(
          response.errorMessage ?? "Data loaded failed!",
          Icons.error_outline,
          AppColor.red,
          AppColor.white,
        ).show(context);
      }
    }

    _productInProgress = false;

    if (mounted) {
      setState(() {});
    }
  }

  ///------Delete api call function------///
  Future<void> deleteProduct(String? id) async {
    _deleteInProgress = true;

    if (mounted) {
      setState(() {});
    }

    NetworkResponseModel responseModel = await NetworkCaller.getRequest(ApiUrl.deleteUrl(id));

    _deleteInProgress = false;

    if (mounted) {
      setState(() {});
    }

    if (responseModel.isSuccess) {
      if (mounted) {
        customToast(
          "Delete success!",
          Icons.done,
          AppColor.green,
          AppColor.white,
        ).show(context);
      }
      _getProduct();
    } else {
      if (mounted) {
        customToast(
          "Something went wrong!!",
          Icons.error,
          AppColor.red,
          AppColor.white,
        ).show(context);
      }
    }
  }
}
