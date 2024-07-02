import 'package:crud_operation_flutter/data/model/product_model.dart';
import 'package:crud_operation_flutter/utils/app_color.dart';
import 'package:crud_operation_flutter/utils/asset_paths.dart';
import 'package:flutter/material.dart';

class CustomProductList extends StatelessWidget {
  final ProductModel productModel;
  final VoidCallback? onPressedEdit;
  final VoidCallback? onPressedDelete;

  const CustomProductList({
    super.key,
    required this.productModel,
    this.onPressedEdit,
    this.onPressedDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.cardBg,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 2,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 95,
            width: 95,
            margin: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                productModel.img ?? '',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    AssetPaths.errorImage, // Replace with your error image path
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 10,
                right: 10,
                bottom: 10,
              ),
              child: RichText(
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                    text: "${productModel.productName ?? ''}\n",
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: "Unit Price: ${productModel.unitPrice ?? ''}\n",
                    style: const TextStyle(
                      color: AppColor.secondText,
                      height: 1.5,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  TextSpan(
                    text: "Quantity: ${productModel.qty ?? ''}\n",
                    style: const TextStyle(
                      color: AppColor.secondText,
                      height: 1.5,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  TextSpan(
                    text: "BDT: ${productModel.totalPrice ?? ''}",
                    style: const TextStyle(
                      color: AppColor.priceText,
                      height: 2,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ]),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: onPressedEdit,
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: onPressedDelete,
                icon: const Icon(Icons.delete),
              )
            ],
          )
        ],
      ),
    );
  }
}
