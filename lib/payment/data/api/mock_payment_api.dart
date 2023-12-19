part of 'api.dart';

class MockPaymentApi extends PaymentApi {
  @override
  Future<void> markPaymentCompleted({required String ticketId}) async {
    final String apiUrl =
        'https://65575a02bd4bcef8b6127c07.mockapi.io/tickets/$ticketId';
    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'paymentCompleted': true}),
      );

      if (response.statusCode != 200) {
        throw Exception(
          'Error marking payment as completed: ${response.statusCode}, ${response.body}',
        );
      }
    } catch (error) {
      throw Exception('Error marking payment as completed: $error');
    }
  }
}
