import 'dart:convert';
import 'package:hommie/models/apartment_model.dart';
import 'package:http/http.dart' as http;

class ApartmentsService {
  static const String baseUrl = "http://10.0.2.2:8000/api/"; 
  static const String imageBaseUrl = "http://10.0.2.2:8000/";

static String getCleanImageUrl(String serverImagePath) {
    if (serverImagePath.startsWith('http') || serverImagePath.startsWith('https')) {
      return serverImagePath; 
    }
    serverImagePath = serverImagePath.replaceAll(RegExp(r'^/|public/'), ''); 
    if (!serverImagePath.contains('/')) {
        serverImagePath = 'storage/apartments/' + serverImagePath; 
    } 
    else if (!serverImagePath.startsWith('storage/')) {
        serverImagePath = 'storage/' + serverImagePath;
    }
    return imageBaseUrl + serverImagePath;
}
  static Future<List<ApartmentModel>> fetchApartments() async {
    final url = Uri.parse("${baseUrl}apartments");
    final response = await http.get(url);
    if (response.statusCode != 200) {
      throw Exception("Failed to load apartments");
    }
    final decoded = jsonDecode(response.body);
    final paginatedData = decoded["data"];
    final List apartmentsList = paginatedData?["data"] ?? [];
    return apartmentsList.map((e) => ApartmentModel.fromJson(e)).toList();
  }
  static Future<Map<String, dynamic>> fetchApartmentDetails(int apartmentId) async {
    final url = Uri.parse("${baseUrl}apartments/$apartmentId");
    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception("Failed to load apartment details for ID $apartmentId");
    }

    final decoded = jsonDecode(response.body);
    final detailsData = decoded["data"];
    if (detailsData == null) {
      throw Exception("Apartment details data is empty");
    }
    return detailsData;
  }
}