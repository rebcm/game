import sqlite3 from 'sqlite3';

const db = new sqlite3.Database('passdriver.db');

db.serialize(function() {
  db.run();
});

db.close();
