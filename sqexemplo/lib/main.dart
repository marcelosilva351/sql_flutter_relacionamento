// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqexemplo/employee.dart';

import 'package:sqexemplo/sql_test.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var sql = sqlTest();
  var resultAddDepartment = await sql.addDepartment("Teste");
  if (resultAddDepartment) {
    print("Departamento adicionado com sucesso");
  }
  var addEmployee = await sql.addEmployee(employee("Marcos", 3));
  if (addEmployee) {
    print("Funcionario adicionado com sucesso");
  }
  print("------------------");
  print("Lista funcionarios e seu departamento: ");
  //Add department
  var listEmployees = await sql.getEmployees();
  for (var employee in listEmployees) {
    print("NOME: ${employee.name},  DEPARTAMENTO: ${employee.department}");
  }

  runApp(WigetExample());
}

class WigetExample extends StatelessWidget {
  const WigetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
