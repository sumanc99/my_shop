// --- Data Model for a Sale Entry ---
class SaleEntry {
  final String rawText;
  final double extractedAmount; // Or a List<SaleItem> for multiple items
  // You might add more fields here, e.g., DateTime timestamp, List<Product> items

  SaleEntry({required this.rawText, this.extractedAmount = 0.0});
}