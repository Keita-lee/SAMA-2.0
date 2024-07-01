class ProductItem {
  final String productTitle;
  final String productType;

  const ProductItem({
    required this.productTitle,
    required this.productType,
  });
}

List ProductItems = [
  ProductItem(
      productTitle: 'Electronic Medical Doctors Coding Manual',
      productType: 'Coding'),
  ProductItem(
      productTitle: 'Medical Doctors Coding Manual Book',
      productType: 'Coding'),
];
