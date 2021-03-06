﻿unit DB_Structure;

interface

const
  //Количество таблиц
  DBS_Tables_Count=9;
  //Названия таблиц
  DBS_TABLES: array [1..DBS_Tables_Count] of String = ('Conditions','Laboratory','NIR',
    'Name','Organization','Spectra','Task','User','BackupInfo');
  //Запросы на создание таблиц
  DBS_TABLES_QUERY: array [1..DBS_Tables_Count] of String =
    ('CREATE TABLE if not exists `Conditions`   (`ID`	INTEGER PRIMARY KEY AUTOINCREMENT, `Condition` TEXT);',
    'CREATE TABLE if not exists `Laboratory`    (`ID`	INTEGER PRIMARY KEY AUTOINCREMENT, `Name`	TEXT UNIQUE, `FullName`	TEXT UNIQUE, `First`	INTEGER DEFAULT 0);',
    'CREATE TABLE if not exists `NIR`           (`ID` INTEGER PRIMARY KEY AUTOINCREMENT, `Num` TEXT UNIQUE, `Comment` TEXT, `First` INTEGER, `Title` TEXT, `Show` INTEGER DEFAULT 1, `External` INTEGER DEFAULT 0, `ExternalOrganization` TEXT);',
    'CREATE TABLE if not exists `Name`          (`ID`	INTEGER PRIMARY KEY AUTOINCREMENT, `FirstName`	TEXT,	`Fathersname`	TEXT, `LastName`	TEXT, '+
      '`Organization`	INTEGER, `Laboratory`	INTEGER);',
    'CREATE TABLE if not exists `Organization`  (`ID`	INTEGER PRIMARY KEY AUTOINCREMENT, `Name`	TEXT UNIQUE, `FullName`	TEXT UNIQUE, `Other`	INTEGER DEFAULT 1);',
    'CREATE TABLE if not exists `Spectra`       (`ID`	INTEGER PRIMARY KEY AUTOINCREMENT, `No`	INTEGER, `Date`	TEXT, `Organization`	INTEGER, '+
      '`Laboratory`	INTEGER, `Name`	INTEGER, `Subst`	TEXT, `Conditions`	TEXT, `Task`	INTEGER, `User`	INTEGER, `NIR`	INTEGER, `Number`	INTEGER, `Year` INTEGER);',
    'CREATE TABLE if not exists `Task`          (`ID`	INTEGER PRIMARY KEY AUTOINCREMENT, `Name`	TEXT UNIQUE, `Time`	REAL, `Multispectra`	INTEGER DEFAULT 0);',
    'CREATE TABLE if not exists `User`          (`ID`	INTEGER PRIMARY KEY AUTOINCREMENT, `FirstName`	INTEGER, `FathersName`	INTEGER, `LastName`	INTEGER);',
    'create table if not exists `BackupInfo`    (`ID`	INTEGER PRIMARY KEY AUTOINCREMENT, `Backup_date`	TEXT, `Backup_File`	TEXT );');

  //Добавление дефолтной информации
    //Число автозаполняемых таблиц
  DBS_FILL_COUNT=3;
    //Проверка таблиц на пустоту
  DBS_FILL_EMPTY:array [1..DBS_FILL_COUNT] of String =
  ('SELECT * FROM `Organization`;',
   'SELECT * FROM `Laboratory`;',
   'SELECT * FROM `NIR`;');
    //Добавление информации
  DBS_FILL:array [1..DBS_FILL_COUNT] of String =
  ('INSERT INTO `Organization` (`Name`,`FullName`,`Other`) VALUES (''ИОС'',''Институт органического синтеза УрО РАН им. И.Я Постовского'',0);',
   'INSERT INTO `Laboratory` (`Name`,`FullName`,`First`) VALUES ('''', '''', 1),'+
    '(''ЛГС'', ''Лаборатория гетероциклических соединений'', 0);',
    'INSERT INTO `NIR` (`Num`,`Comment`,`First`) VALUES ('' — '', ''Без номера'', 1);');

  // Добавление информации о бекапах
  DBS_Tables_Exists = '';
implementation

end.
