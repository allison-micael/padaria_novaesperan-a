import 'dart:io';
import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import '../models/transaction.dart';

class ExcelService {
  Future<File> generateExcelReport(List<Transaction> transactions) async {
    final excel = Excel.createExcel();
    final Sheet sheet = excel['Movimentações'];

    sheet.appendRow(['Tipo', 'Descrição', 'Valor']);
    for (var tx in transactions) {
      sheet.appendRow([tx.type, tx.description, tx.value]);
    }

    final receitas = transactions
        .where((tx) => tx.type == 'Receita')
        .fold(0.0, (sum, tx) => sum + tx.value);
    final despesas = transactions
        .where((tx) => tx.type == 'Despesa')
        .fold(0.0, (sum, tx) => sum + tx.value);
    final lucro = receitas - despesas;

    sheet.appendRow([]);
    sheet.appendRow(['Receitas', receitas]);
    sheet.appendRow(['Despesas', despesas]);
    sheet.appendRow(['Lucro', lucro]);

    final bytes = excel.encode();
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/relatorio_padaria.xlsx');
    await file.writeAsBytes(bytes!);
    return file;
  }
}
