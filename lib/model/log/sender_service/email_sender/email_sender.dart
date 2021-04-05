import 'package:mailer/mailer.dart' as mailer;
import 'package:mailer/smtp_server.dart';
import 'package:path/path.dart';
import 'package:sleeplogger/model/log/sender_service/email_sender/email_sender_config.dart';
import 'package:sleeplogger/model/log/sender_service/sender_service.dart';
import 'package:sleeplogger/model/log/storage_repository/storage_repository.dart';

class EmailSender implements SenderService {
  EmailSender(this.storageRepository);

  final StorageRepository storageRepository;

  @override
  Future<bool> send(String path) async {
    final filename = basename(path);
    final data = await storageRepository.read(path);

    final smtpServer = yandex(emailSenderSmtpUsername, emailSenderSmtpPassword);

    final message = mailer.Message()
      ..from = mailer.Address(emailSenderEmailFrom, 'Sleep Logger')
      ..recipients.add(emailSenderRecipient)
      ..subject = filename
      ..text = data;

    try {
      final sendReport = await mailer.send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      return true;
    } on mailer.MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
      return false;
    }
  }
}
