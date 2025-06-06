*** Settings ***
Documentation     Testes para a seção de Login
Resource         ../keywords/Login_Keywords.robot
Resource         ../resources/base.robot

*** Test Cases ***
TC012 - Login com credenciais válidas
    [Documentation]    Valida login com e-mail e senha válidos
    ...    Resultado esperado: Status 200 - Token Bearer gerado com sucesso
    ${response}    Realizar Login Com Credenciais Validas
    Validar Login Bem Sucedido    ${response}
    Logar Token Obtido    ${response}

TC013 - Login com senha inválida
    [Documentation]    Valida rejeição de login com senha inválida
    ...    Resultado esperado: Status 401
    ${response}    Realizar Login Com Senha Invalida
    Validar Login Rejeitado    ${response}

TC014 - Login com usuário não cadastrado
    [Documentation]    Valida rejeição de login com e-mail inexistente
    ...    Resultado esperado: Status 401
    ${response}    Realizar Login Com Usuario Inexistente
    Validar Login Rejeitado    ${response}

TC015 - Acessar rota protegida com token expirado
    [Documentation]    Valida rejeição de acesso com token expirado ou inválido
    ...    Resultado esperado: Status 401 - Erro de token inválido
    ${response}    Acessar Rota Com Token Invalido
    Validar Login Rejeitado    ${response}