// This file contains the logic to parse SMS strings into usable transaction data.

/// Parses a given SMS string and returns a transaction map.
/// Extracts amount, merchant, and date if available.
Map<String, dynamic>? parse(String sms) {
  final amountRegex = RegExp(r'(INR|₹|Rs\.?)\s?(\d+[.,]?\d*)');
  final merchantRegex = RegExp(
    r'(Swiggy|Amazon|Uber|ATM|Purchase at\s+\w+)',
    caseSensitive: false,
  );
  final dateRegex = RegExp(r'\d{2}-\d{2}-\d{4}');

  final amountMatch = amountRegex.firstMatch(sms);
  final merchantMatch = merchantRegex.firstMatch(sms);
  final dateMatch = dateRegex.firstMatch(sms);

  if (amountMatch != null) {
    return {
      'amount': double.tryParse(amountMatch.group(2) ?? '0') ?? 0,
      'merchant': merchantMatch?.group(0) ?? 'Unknown',
      'date': dateMatch?.group(0) ?? 'N/A',
    };
  }

  return null;
}
