import 'package:socket/app/features/contact/models/contact_model.dart';
import 'package:sqlite3/sqlite3.dart';

class ContactRepository {
  Future<void> createConnection() async {
    final Database database = sqlite3.open('contacts.db');
    database.execute('''
      CREATE TABLE IF NOT EXISTS contacts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL,
        avatarPath TEXT
      )
    ''');
    database.dispose();
  }

  Future<void> createContact({required ContactModel contacts}) async {
    final Database database = sqlite3.open('contacts.db');

    final insertSql = database.prepare(
        'INSERT INTO contacts (name, email, avatarPath) VALUES (?, ?, ?)');

    insertSql.execute([contacts.name, contacts.email, contacts.avatarPath]);
    database.dispose();
  }

  Future<List<ContactModel>> listContact() async {
    final Database database = sqlite3.open('contacts.db');

    final ResultSet contactsMap = database.select('SELECT * FROM contacts');
    final contacts = contactsMap
        .map((contact) => ContactModel.fromMap(map: contact))
        .toList();

    return contacts;
  }

  Future<List<ContactModel>> listContactByName(String name) async {
    final Database database = sqlite3.open('contacts.db');

    final ResultSet resultSet =
        database.select('SELECT * FROM contacts WHERE name LIKE ?', ['$name']);

    final contacts =
        resultSet.map((contact) => ContactModel.fromMap(map: contact)).toList();

    database.dispose();
    return contacts;
  }

  Future<void> createHost(ContactModel host) async {
    final Database database = sqlite3.open('contacts.db');
    database.execute('''
        CREATE TABLE IF NOT EXISTS host (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          email TEXT NOT NULL,
          avatarPath TEXT
        )
    ''');

    final insertSql = database
        .prepare('INSERT INTO host (name, email, avatarPath) VALUES (?, ?, ?)');

    insertSql.execute([host.name, host.email, host.avatarPath]);

    database.dispose();
  }

  Future<ContactModel> getHost() async {
    final Database database = sqlite3.open('contacts.db');

    database.execute('''
        CREATE TABLE IF NOT EXISTS host (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT NOT NULL,
          email TEXT NOT NULL,
          avatarPath TEXT
        )
    ''');

    final ResultSet resultSet = database.select('SELECT * FROM host');
    if (resultSet.isEmpty) {
      return ContactModel(name: 'Nulo', email: 'Nulo');
    }

    final host = ContactModel.fromMap(map: resultSet.toList()[0]);
    database.dispose();
    return host;
  }
}
