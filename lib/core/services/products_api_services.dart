import 'package:whitematrix_groupa_shopping_app/core/network/api_helper.dart';
import 'package:whitematrix_groupa_shopping_app/model/product_res_model.dart';

class ProductsApiServices {
  Future<List<ProductsResModel>?>fetchProducts()async{
    final resp = await ApiHelper.getData(endpoint: "/all-products");
    if(resp !=null){
      try{
      return productsResModelFromJson(resp);
      }
      catch(e){
        return null;
      }
    }
    return null;
  }
   
}