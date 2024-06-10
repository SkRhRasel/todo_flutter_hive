# hive_db

A new Todo Application Using Flutter Hive offline database.

## Getting Started

## Generate model class by code

Run this command :
dart run build_runner build

If any conflicts Run this command :
dart run build_runner build --delete-conflicting-outputs


## But before that, you will have to import the generator.

Example: If your file name is project_database.dart, then in that file :

Import,

import 'package:hive/hive.dart';
part 'project_database.g.dart'; 
//this will show an error initially but if
// you run the above command, it will generate the generator file
