import 'package:fooding_final_app/data/api/api_service.dart';
import 'package:fooding_final_app/data/model/get_restaurants_response.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'json_parsing_test.mocks.dart'; // Import generated mocks file

@GenerateMocks([http.Client])
void main() {
  group('ApiService Tests', () {
    late MockClient mockClient;
    late ApiService apiService;

    setUp(() {
      mockClient = MockClient(); // Inisialisasi mock client
      apiService = ApiService(client: mockClient); // Inject client
    });

    test('Verify JSON Parsing', () async {
      const mockResponse =
          '{"error": false, "message": "success", "count": 20, "restaurants": [{"id": "rqdv5juczeskfw1e867","name": "Melting Pot","description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.","pictureId": "14","city": "Medan","rating": 4.2},]}';

      when(mockClient.get(Uri.parse('${ApiService.baseUrl}/list')))
          .thenAnswer((_) async => http.Response(mockResponse, 200));

      final result = await apiService.getListRestaurants();
      expect(result, isA<List<Restaurant>>());
    });
  });
}
