import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList({Key? key, required this.transactions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? const Text('Nenhuma movimentação registrada.')
        : ListView.builder(
            shrinkWrap: true,
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final tx = transactions[index];
              return ListTile(
                title: Text('${tx.type}: ${tx.description}'),
                trailing: Text('R\$ ${tx.value.toStringAsFixed(2)}'),
              );
            },
          );
  }
}
