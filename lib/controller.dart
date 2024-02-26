import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class QuotationController extends GetxController {
  RxList<Quote> quotes = <Quote>[].obs;
  
  var isLoading = true.obs; // Observable for tracking loading state

  

  @override
  void onInit() {
    super.onInit();
    fetchData();
    
  }

  Future<void> fetchData() async {
    try {
      isLoading(true); // Set loading to true when starting data fetch
      final response = await http
          .get(Uri.parse('https://appgames.cloudtevent.com/api/get-quotes'));
      
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = json.decode(response.body);
        print('dsgvd@vvvxcv= QuoteList');
        
        if (jsonData['quote'] is List) {
          final List<dynamic> quoteList = jsonData['quote'];
          quotes.addAll(quoteList.map((quoteMap) {
            if (quoteMap is Map<String, dynamic>) {
              return Quote.fromJson(quoteMap);
            }
            return Quote(); // Return a default Quote if data is not valid
          }));
        } else {
          throw Exception('Invalid data format');
        }
      } else {
        throw Exception(
            'Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('An error occurred: $e');
    } finally {
      isLoading(false);
    }
  }

}

class Quote {
  final int id;
  final String text;
  final String byId;
  final String byName;
  final String? byImage;
  final String createdAt;
  final String updatedAt;
  final int categoryId;

  Quote({
    this.id = 0,
    this.text = '',
    this.byId = '',
    this.byName = '',
    this.byImage,
    this.createdAt = '',
    this.updatedAt = '',
    this.categoryId = 0,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      id: json['id'] ?? 0,
      text: json['text'] ?? '',
      byId: json['by_id'] ?? '',
      byName: json['by_name'] ?? '',
      byImage: json['by_image'],
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      categoryId: json['category_id'] ?? 0,
    );
  }

  toJson() {}
}
