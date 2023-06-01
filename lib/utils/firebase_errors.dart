String getErrorString(String code){
  switch (code) {
    case 'ERROR_WEAK_PASSWORD':
      return 'Sua senha é muito fraca.';
    case 'invalid-email':
      return 'Seu e-mail é inválido.';
    case 'ERROR_EMAIL_ALREADY_IN_USE':
      return 'E-mail já está sendo utilizado em outra conta.';
    case 'ERROR_INVALID_CREDENTIAL':
      return 'Seu e-mail é inválido.';
    case 'auth/invalid-password':
      return 'Sua senha está incorreta.';
    case 'user-not-found':
      return 'E-mail não encontrado. Solicite seu Cadastro.';
    case 'ERROR_USER_DISABLED':
      return 'Este usuário foi desabilitado.';
    case 'ERROR_TOO_MANY_REQUESTS':
      return 'Muitas solicitações. Tente novamente mais tarde.';
    case 'ERROR_OPERATION_NOT_ALLOWED':
      return 'Operação não permitida.';

    default:
      return 'Um erro indefinido ocorreu.';
  }
}