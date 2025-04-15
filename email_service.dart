import 'package:share_plus/share_plus.dart';
import 'dart:io';

class EmailService {
  Future<void> sendEmailWithAttachment(File file) async {
    await Share.shareXFiles([XFile(file.path)],
        text: 'Segue em anexo o relatório financeiro da padaria.');
  }
}
