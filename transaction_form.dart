import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionForm extends StatefulWidget {
  final Function(Transaction) onSubmit;

  const TransactionForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _descriptionController = TextEditingController();
  final _valueController = TextEditingController();

  void _submit(String type) {
    final description = _descriptionController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (description.isEmpty || value <= 0) return;

    widget.onSubmit(Transaction(
      type: type,
      description: description,
      value: value,
    ));

    _descriptionController.clear();
    _valueController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _descriptionController,
          decoration: const InputDecoration(labelText: 'Descrição'),
        ),
        TextField(
          controller: _valueController,
          decoration: const InputDecoration(labelText: 'Valor (R\$)'),
          keyboardType: TextInputType.number,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              onPressed: () => _submit('Receita'),
              child: const Text('Registrar Receita'),
            ),
            ElevatedButton(
              onPressed: () => _submit('Despesa'),
              child: const Text('Registrar Despesa'),
            ),
          ],
        ),
      ],
    );
  }
}
