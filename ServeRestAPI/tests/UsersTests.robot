*** Settings ***
Documentation    Testes para Seção Usuários
Resource         ../resources/base.robot
Resource         ../keywords/Users_Keywords.robot


# ╭─────────────────────────╮
# │ Testes de Criação       │
# ╰─────────────────────────╯

*** Test Cases ***
TC001 - Criar usuário com dados válidos
    ${response}=                TC001 - Criar usuário com dados válidos
    Validar Status E Mensagem   ${response}    201    Cadastro realizado com sucesso

TC002 - Criar usuário com domínio de e-mail inválido
    ${response}=                TC002 - Criar usuário com domínio de e-mail inválido
    Should Be Equal As Integers ${response.status_code}    201

TC003 - Criar usuário com e-mail duplicado
    ${response}=                TC003 - Criar usuário com e-mail duplicado
    Validar Status E Mensagem   ${response}    400    Este email já está sendo usado


# ╭────────────────────────────╮
# │ Testes de Atualização      │
# ╰────────────────────────────╯

TC004 - Atualizar usuário com ID inexistente
    ${response}=                TC004 - Atualizar usuário com ID inexistente
    Should Be Equal As Integers ${response.status_code}    200


# ╭─────────────────────────╮
# │ Testes de Consulta      │
# ╰─────────────────────────╯

TC005 - Consultar usuário inexistente
    ${response}=                TC005 - Consultar usuário inexistente
    Should Be Equal As Integers ${response.status_code}    400


*** Keywords ***

Validar Status E Mensagem
    [Arguments]    ${response}    ${status_esperado}    ${mensagem_esperada}
    Should Be Equal As Integers    ${response.status_code}    ${status_esperado}
    Should Contain                 ${response.json()['message']}    ${mensagem_esperada}