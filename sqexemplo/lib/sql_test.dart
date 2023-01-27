import 'package:sqexemplo/employee.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class sqlTest {
  Future<Database> getDataBase() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'employes.db');

// Delete the database

// open the database
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute('''
CREATE TABLE department (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL
);
''');
      await db.execute('''
CREATE TABLE employee (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    department_id INTEGER NOT NULL,
    FOREIGN KEY (department_id) REFERENCES department(id)
);
''');
    });
    return database;
  }

  Future<bool> addDepartment(String departmentName) async {
    var db = await getDataBase();
    var value = {'name': departmentName};
    int id = await db.insert(
      "department",
      value,
    );
    if (id != 0) {
      return true;
    }
    return false;
  }

  Future<bool> addEmployee(employee employeeAdd) async {
    var db = await getDataBase();
    var value = {
      'name': employeeAdd.name,
      "department_id": employeeAdd.departmentId
    };
    int id = await db.insert(
      "employee",
      value,
    );
    if (id != 0) {
      return true;
    }
    return false;
  }

  Future<List<employee>> getEmployees() async {
    var db = await getDataBase();
    var empoloyessFromDb = await db.rawQuery('''
    SELECT employee.name as employee_name, 
    departament.name as department_name
    FROM employee employee 
    JOIN department departament 
    ON employee.department_id = departament.id
    ''');
    List<employee> listEmployes = empoloyessFromDb.map((e) {
      var employeeReturn = employee(e["employee_name"].toString(), 0);
      employeeReturn.department = e["department_name"].toString();
      return employeeReturn;
    }).toList();
    return listEmployes;
  }

  Future<List<employee>> getEmployeesWithoutDepartment() async {
    var db = await getDataBase();
    List<Map> list = await db.rawQuery('SELECT * FROM employee');

    List<employee> listEmployes = list.map((e) {
      var employeeReturn = employee(
          e["name"].toString(), int.parse(e["department_id"].toString()));
      return employeeReturn;
    }).toList();
    return listEmployes;
  }

  void getDepartments() async {
    var db = await getDataBase();
    print(db.rawQuery("Select * from departments"));
  }
}
