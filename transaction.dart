class Transaction {
  final String type; // 'Receita' ou 'Despesa'
  final String description;
  final double value;

  Transaction({
    required this.type,
    required this.description,
    required this.value,
  });
}
