import 'package:telephony/telephony.dart';

class SMSService {
  static final Telephony telephony = Telephony.instance;

  static void startListening(Function(Map<String, dynamic>) onMessage) {
    telephony.listenIncomingSms(
      onNewMessage: (SmsMessage message) {
        final parsed = _parse(message.body ?? '');
        if (parsed != null) {
          onMessage(parsed);
        }
      },
      listenInBackground: false,
    );
  }

  static Map<String, dynamic>? _parse(String sms) {
    final amountRegex = RegExp(r'(INR|₹|Rs\.?)\s?(\d+[\.,]?\d*)');
    final merchantRegex = RegExp(
      r'(Swiggy|Amazon|Uber|Zomato|Ola)',
      caseSensitive: false,
    );

    final amountMatch = amountRegex.firstMatch(sms);
    final merchantMatch = merchantRegex.firstMatch(sms);

    if (amountMatch != null) {
      return {
        'amount': double.tryParse(amountMatch.group(2) ?? '0') ?? 0,
        'merchant': merchantMatch?.group(0) ?? 'Unknown',
        'date': DateTime.now().toString().split(' ')[0],
      };
    }

    return null;
  }
}
