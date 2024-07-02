import 'package:crud_operation_flutter/data/model/network_response_model.dart';
import 'package:crud_operation_flutter/data/model/product_model.dart';
import 'package:crud_operation_flutter/data/services/network_caller.dart';
import 'package:crud_operation_flutter/utils/api_url.dart';
import 'package:crud_operation_flutter/utils/app_color.dart';
import 'package:crud_operation_flutter/utils/app_route.dart';
import 'package:crud_operation_flutter/view/widgets/custom_text_field.dart';
import 'package:crud_operation_flutter/view/widgets/loading_dialog.dart';
import 'package:crud_operation_flutter/view/widgets/one_button_dialog.dart';
import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _imgUrlTextEditingController = TextEditingController();
  final TextEditingController _productCodeTextEditingController = TextEditingController();
  final TextEditingController _productNameTextEditingController = TextEditingController();
  final TextEditingController _qtyTextEditingController = TextEditingController();
  final TextEditingController _totalPriceTextEditingController = TextEditingController();
  final TextEditingController _unitPriceTextEditingController = TextEditingController();

  bool _editProductInProgress = false;

  @override
  void initState() {
    super.initState();
    _setProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Product'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    controller: _imgUrlTextEditingController,
                    hintText: 'Image url',
                    validatorText: 'Enter valid image url.',
                    inputType: TextInputType.text,
                  ),
                  const SizedBox(height: 10.0),
                  CustomTextField(
                    controller: _productCodeTextEditingController,
                    hintText: 'Product Code',
                    validatorText: 'Enter valid product code.',
                    inputType: TextInputType.number,
                  ),
                  const SizedBox(height: 10.0),
                  CustomTextField(
                    controller: _productNameTextEditingController,
                    hintText: 'Product Name',
                    validatorText: 'Enter valid product name.',
                    inputType: TextInputType.text,
                  ),
                  const SizedBox(height: 10.0),
                  CustomTextField(
                    controller: _qtyTextEditingController,
                    hintText: 'Quantity',
                    validatorText: 'Enter valid quantity.',
                    inputType: TextInputType.number,
                  ),
                  const SizedBox(height: 10.0),
                  CustomTextField(
                    controller: _totalPriceTextEditingController,
                    hintText: 'Total Price',
                    validatorText: 'Enter valid total price.',
                    inputType: TextInputType.number,
                  ),
                  const SizedBox(height: 10.0),
                  CustomTextField(
                    controller: _unitPriceTextEditingController,
                    hintText: 'Unit Price',
                    validatorText: 'Enter valid unit price.',
                    inputType: TextInputType.number,
                  ),
                  const SizedBox(height: 15.0),
                  SizedBox(
                    width: double.maxFinite,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _editProduct();
                        }
                      },
                      child: const Text(
                        'Add Product',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _setProduct() {
    _imgUrlTextEditingController.text = widget.productModel.img ?? '';
    _productCodeTextEditingController.text = widget.productModel.productCode ?? '';
    _productNameTextEditingController.text = widget.productModel.productName ?? '';
    _qtyTextEditingController.text = widget.productModel.qty ?? '';
    _totalPriceTextEditingController.text = widget.productModel.totalPrice ?? '';
    _unitPriceTextEditingController.text = widget.productModel.unitPrice ?? '';
  }

  Future<void> _editProduct() async {
    _editProductInProgress = true;

    if (mounted) {
      setState(() {});
    }

    loadingDialog(context);

    Map<String, dynamic> bodyData = {
      "Img": _imgUrlTextEditingController.text.trim(),
      "ProductCode": _productCodeTextEditingController.text.trim(),
      "ProductName": _productNameTextEditingController.text.trim(),
      "Qty": _qtyTextEditingController.text.trim(),
      "TotalPrice": _totalPriceTextEditingController.text.trim(),
      "UnitPrice": _unitPriceTextEditingController.text.trim(),
    };

    NetworkResponseModel responseModel = await NetworkCaller.postRequest(
      ApiUrl.updateUrl(widget.productModel.sId ?? ''),
      body: bodyData,
    );

    _editProductInProgress = false;

    if (mounted) {
      Navigator.pop(context);
    }

    if (responseModel.isSuccess) {
      if (mounted) {
        oneButtonDialog(
          context,
          AppColor.appBar,
          'Success!',
          'Product update successfully.',
          Icons.done,
          () {
            Navigator.pushNamedAndRemoveUntil(
                context, AppRoute.home, (Route<dynamic> route) => false);
          },
        );
      }
    } else {
      if (mounted) {
        oneButtonDialog(
          context,
          AppColor.red,
          'Error!',
          'Something went wrong, try again.',
          Icons.error,
          () {
            Navigator.pop(context);
          },
        );
      }
    }
  }

  @override
  void dispose() {
    _imgUrlTextEditingController.dispose();
    _productCodeTextEditingController.dispose();
    _productNameTextEditingController.dispose();
    _qtyTextEditingController.dispose();
    _totalPriceTextEditingController.dispose();
    _unitPriceTextEditingController.dispose();
    super.dispose();
  }
}
