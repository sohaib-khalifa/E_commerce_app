import 'package:login_app_test/features/products/models/product_model.dart';
import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  final Product product;
  const Details({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(product.thumbnail),
            Text(product.title, style: const TextStyle(fontSize: 30)),
            Text('\$${product.price}', style: const TextStyle(fontSize: 20)),
            Text(product.description, style: const TextStyle(fontSize: 20)),
            Table(
              border: TableBorder.all(color: Colors.grey.shade300),
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(3),
              },
              children: [
                _buildRow("Price", "\$${product.price}"),
                _buildRow(
                    "Category", categoryValues.reverse[product.category]!),
                _buildRow("Brand", product.brand),
                _buildRow("Stock", product.stock.toString()),
                _buildRow("Rating", "${product.rating}/5"),
                _buildRow("Return Policy",
                    returnPolicyValues.reverse[product.returnPolicy]!),
                _buildRow("Dimensions",
                    "${product.dimensions.width} x ${product.dimensions.height} x ${product.dimensions.depth}"),
                _buildRow("Barcode", product.meta.barcode),
                _buildRow("Created At",
                    product.meta.createdAt.toString().split('T').first),
              ],
            ),

            const SizedBox(height: 20),
            if (product.images.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "More Images",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: product.images.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            product.images[index],
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  TableRow _buildRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
        ),
      ],
    );
  }
}
