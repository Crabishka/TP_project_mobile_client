import '../data/product_description.dart';

class ProductDescriptionRepository {
  ProductDescriptionRepository._();

  static final instance = ProductDescriptionRepository._();

  final ProductDescription _product1 = ProductDescription(1, "Card 1",
      "Very very good", 200, "https://via.placeholder.com/600/24f355");
  final ProductDescription _product2 = ProductDescription(
      2,
      "Card 2",
      "Very very bad Very very badVery very badVery very badVery very badV"
          "ery very badVery very badVery very badVery very badVery very bad Very very bad",
      300,
      "https://via.placeholder.com/600/abcdf5");
  final ProductDescription _product3 = ProductDescription(3, "Card 3",
      "Very very great", 400, "https://via.placeholder.com/600/1234f5");
  final ProductDescription _product4 = ProductDescription(4, "Card 4",
      "Very very awesome", 500, "https://via.placeholder.com/600/2ff3f5");
  final ProductDescription _product5 = ProductDescription(5, "Card 5",
      "Very very handsome", 600, "https://via.placeholder.com/600/eadff5");
  final ProductDescription _product6 = ProductDescription(6, "Card 6",
      "Very very awful", 700, "https://via.placeholder.com/600/623ffa");
  final ProductDescription _product7 = ProductDescription(7, "Card 7",
      "Very very terrible", 800, "https://via.placeholder.com/600/aaafdf");
  late var catalog = [
    _product1,
    _product2,
    _product3,
    _product4,
    _product5,
    _product6,
    _product7
  ];

  ProductDescription getProductDescription(int id) {
    return catalog[id];
  }

  List<ProductDescription> getAllProductDescription() {
    return catalog;
  }
}
