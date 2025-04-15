import 'package:flutter/material.dart';
import '../models/transaction.dart';
import '../services/excel_service.dart';
import '../services/email_service.dart';
import '../widgets/transaction_form.dart';
import '../widgets/transaction_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Transaction> _transactions = [];

  double get _lucro {
    final receitas = _transactions
        .where((tx) => tx.type == 'Receita')
        .fold(0.0, (sum, tx) => sum + tx.value);
    final despesas = _transactions
        .where((tx) => tx.type == 'Despesa')
        .fold(0.0, (sum, tx) => sum + tx.value);
    return receitas - despesas;
  }

  void _addTransaction(Transaction tx) {
    setState(() {
      _transactions.add(tx);
    });
  }

  void _gerarRelatorio() async {
    final excelService = ExcelService();
    final file = await excelService.generateExcelReport(_transactions);
    final emailService = EmailService();
    await emailService.sendEmailWithAttachment(file);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Controle Financeiro - Padaria'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TransactionForm(onSubmit: _addTransaction),
            const SizedBox(height: 10),
            Text(
              'Lucro atual: R\$ ${_lucro.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TransactionList(transactions: _transactions),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _gerarRelatorio,
              child: const Text('Gerar e Enviar Relatório'),
            ),
          ],
        ),
      ),
    );
  }
}
