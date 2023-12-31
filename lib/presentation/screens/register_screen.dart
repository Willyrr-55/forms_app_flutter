import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/blocs/register/register_cubit.dart';

import '../widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo usuario'),
      ),
      body: BlocProvider(
        create: (context) => RegisterCubit() ,
        child: const _RegisterView(),
      ) 
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FlutterLogo(
              size: 100,
            ),
            SizedBox(height: 15),
            _RegisterForm(),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}

class _RegisterForm extends StatefulWidget {
  const _RegisterForm();

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final registerCubit = context.watch<RegisterCubit>();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            label: 'Nombre de usuario',
            onChanged: (value) {
              registerCubit.usernameChange(value);
              _formKey.currentState?.validate();
            },
            validator: (value) {
              if(value == null || value.isEmpty) return 'Campo requerido';
              if(value.trim().isEmpty) return 'Campo requerido';
              if(value.length < 6) return 'Más de 6 letras';
              return null;
            },
          ),
          const SizedBox(height: 15),
          
          CustomTextFormField(
            label: 'Correo electrónico',
            onChanged: (value) {
              registerCubit.emailChange(value);
              _formKey.currentState?.validate();
            },
            validator: (value) {
              if(value == null || value.isEmpty) return 'Campo requerido';
              if(value.trim().isEmpty) return 'Campo requerido';
              final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',);
              if(!emailRegExp.hasMatch(value)) return 'No tiene formato de correo'; 
              return null;
            },
          ),
          const SizedBox(height: 15),
          
          CustomTextFormField(
            label: 'Contraseñas',
            obscureText:true,
            onChanged: (value) {
              registerCubit.passwordChange(value);
              _formKey.currentState?.validate();
            },
            validator: (value) {
              if(value == null || value.isEmpty) return 'Campo requerido';
              if(value.trim().isEmpty) return 'Campo requerido';
              if(value.length < 6) return 'Más de 6 letras';
              return null;
            },
          ),

          const SizedBox(height: 20),
          FilledButton.tonalIcon(
            onPressed: () {
              final isValid = _formKey.currentState!.validate();
              if(!isValid) return; 

              registerCubit.onSubmit();

              // print('$username, $email, $password');
            },
            icon: const Icon(Icons.save),
            label: const Text('Crear usuario'),
          ),
        ],
      ),
    );
  }
}
