*** Settings ***
Documentation    Testes para a seção de Login 
Resource         ../resources/base.robot
Resource         ../keywords/Login_Keywords.robot


# ╭────────────────────────────╮
# │     Testes Seção Login     │
# ╰────────────────────────────╯

*** Test Cases ***

TC012 - Login com credenciais válidas
    [Documentation]    Valida login com e-mail e senha válidos
    ...                Resultado esperado: Status 200 - Token Bearer gerado com sucesso
    Realizar Login Com Credenciais Validas

TC013 - Login com senha inválida
    [Documentation]    Valida rejeição de login com senha inválida
    ...                Resultado esperado: Status 401 
    Tentar Login Com Senha Invalida

TC014 - Login com usuário não cadastrado
    [Documentation]    Valida rejeição de login com e-mail inexistente
    ...                Resultado esperado: Status 401 
    Tentar Login Com Usuario Inexistente

TC015 - Acessar rota protegida com token expirado
    [Documentation]    Valida rejeição de acesso com token expirado ou inválido
    ...                Resultado esperado: Status 401 - Erro de token inválido
    Tentar Acessar Rota Com Token Invalido
