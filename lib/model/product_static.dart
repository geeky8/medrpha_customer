import 'package:get/get.dart';

class Product {
  static const base_url = "https://partner.medrpha.com/product_image/";
  String product_img,
      product_name,
      categorystr,
      compnaystr,
      newmrp,
      oldmrp,
      percent,
      saleqtytypestr,
      prodsaletypedetails,
      quantity,
      pid,
      wpid,
      priceID,
      saleprice,
      cartquantity;
  Product(
      this.product_img,
      this.product_name,
      this.categorystr,
      this.compnaystr,
      this.newmrp,
      this.oldmrp,
      this.percent,
      this.saleqtytypestr,
      this.prodsaletypedetails,
      this.quantity,
      this.pid,
      this.wpid,
      this.priceID,
      this.saleprice,
      this.cartquantity);
}

class ProductController extends GetxController {
  var products = <Product>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchProducts();
  }

  Future fetchProducts() async {
    await Future.delayed(
      Duration(seconds: 1),
    );
    var response;
    response = [
      Product(
          "pro-1-291221025631.jpg",
          "CIPLOX 500MG TABLET",
          "Ethical",
          "ANIMAX   ",
          "Rs 408.00",
          "Rs 700.00",
          "41.71% OFF",
          "Ampul",
          "asdas",
          "4567",
          "1",
          "6",
          "6",
          "408.00",
          "0"),
      Product(
          "pro-1-291221025710.jpg",
          "HADENSA 20 GM1",
          "Ethical",
          "ANIMAX   ",
          "Rs 21420.00",
          "Rs 23223.00",
          "7.77% OFF",
          "Cartoon",
          "1*10",
          "4567",
          "1",
          "2",
          "2",
          "408.00",
          "0"),
      Product(
          "pro-1-291221025738.jpg",
          "CIPLOX 200",
          "Ethical",
          "ANIMAX   ",
          "Rs 408.00",
          "Rs 700.00",
          "41.71% OFF",
          "Ampul",
          "asdas",
          "4567",
          "3",
          "3",
          "3",
          "408.00",
          "0"),
      Product(
          "pro-1-291221025807.jpg",
          "glyco 200 GM1",
          "Ethical",
          "ANIMAX   ",
          "Rs 21420.00",
          "Rs 23223.00",
          "7.77% OFF",
          "Cartoon",
          "1*10",
          "4567",
          "4",
          "4",
          "4",
          "408.00",
          "0"),
      Product(
          "pro-1-291221025832.jpg",
          "insulin injection",
          "Ethical",
          "ANIMAX   ",
          "Rs 21420.00",
          "Rs 23223.00",
          "7.77% OFF",
          "Cartoon",
          "1*10",
          "4567",
          "5",
          "5",
          "5",
          "408.00",
          "0")
    ];
    products.value = response;
  }
}
