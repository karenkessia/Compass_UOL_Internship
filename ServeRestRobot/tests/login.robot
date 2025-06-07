# ╭────────────────────────────────────────────────────────────╮
# │           Testes para cadastro de usuários - Login         │
# ╰────────────────────────────────────────────────────────────╯

*** Settings ***
Documentation    Testes para cadastro de usuários na API ServeRest
Resource         ../variables/serverest_vars.robot
Resource         ../resources/common.robot
Resource         ../resources/user_keywords.robot
Resource         ../resources/login_keywords.robot
Library          RequestsLibrary
Suite Setup      Criar e Iniciar Sessão API

# ╭────────────────────────────────────────────╮
# │ Login Com Credenciais Válidas              │
# ╰────────────────────────────────────────────╯
*** Test Cases ***
TC012-Login Com Credenciais Válidas
    [Documentation]    Verifica que login falha com senha inválida mesmo para usuário cadastrado
    [Tags]    post    login    authentication    negative
    ${email}=         Gerar Email Aleatório Válido
    Cadastrar Usuário
    ...               ${NOME_VALIDO}
    ...               ${email}
    ...               ${SENHA_VALIDA}
    ...               administrador=true

    ${response}=      Realizar Login
    ...               ${EMAIL_VALIDO}
    ...               ${SENHA_INVALIDA}

    Should Be Equal As Integers    ${response.status_code}    401

# ╭────────────────────────────────────────────╮
# │ Login Com Email Inválido                   │
# ╰────────────────────────────────────────────╯
EXTRA-Login Com Email Inválido
    [Documentation]    Verifica que login falha com email não cadastrado no sistema
    [Tags]    post    login    authentication    negative
    ${response}=      Realizar Login    ${EMAIL_INVALIDO}    ${SENHA_VALIDA}
    Should Be Equal As Integers    ${response.status_code}    401

# ╭────────────────────────────────────────────╮
# │ Login Com Senha em Branco                  │
# ╰────────────────────────────────────────────╯
EXTRA-Login Com Senha em Branco
    [Documentation]    Verifica validação quando senha é omitida na requisição
    [Tags]    post    login    authentication    validation
    ${response}=      Realizar Login
    ...               ${EMAIL_VALIDO}
    ...
    Should Be Equal As Integers    ${response.status_code}    400

# ╭────────────────────────────────────────────╮
# │ Login Com Email em Branco                  │
# ╰────────────────────────────────────────────╯
EXTRA-Login Com Email em Branco
    [Documentation]    Verifica validação quando email é omitido na requisição
    [Tags]    post    login    authentication    validation
    ${response}=      Realizar Login
    ...
    ...               ${SENHA_VALIDA}
    Should Be Equal As Integers    ${response.status_code}    400

# ╭────────────────────────────────────────────╮
# │ Login Com Campos Vazios                    │
# ╰────────────────────────────────────────────╯
EXTRA-Login Com Campos Vazios
    [Documentation]    Verifica validação quando todos os campos são omitidos
    [Tags]    post    login    authentication    validation
    ${response}=      Realizar Login
    ...
    ...
    Should Be Equal As Integers    ${response.status_code}    400

# ╭────────────────────────────────────────────╮
# │ Login Com Senha Incorreta                  │
# ╰────────────────────────────────────────────╯
TC013-Login Com Senha invalida
    [Documentation]    Verifica que login falha quando senha está incorreta
    [Tags]    post    login    authentication    negative
    ${email}=         Gerar Email Aleatório Válido
    Cadastrar Usuário
    ...               ${NOME_VALIDO}
    ...               ${email}
    ...               ${SENHA_VALIDA}
    ...               administrador=false

    ${response}=      Realizar Login    ${email}    senhaErrada123
    Should Be Equal As Integers    ${response.status_code}    401

# ╭────────────────────────────────────────────╮
# │ Login Usuario Nao Cadastrado               │
# ╰────────────────────────────────────────────╯
TC014-Login Usuario Nao Cadastrado
    [Documentation]    Verifica que login falha para usuário inexistente no sistema
    [Tags]    post    login    authentication    negative
    ${response}=      Realizar Login    naoexistente@teste.com    123456
    Should Be Equal As Integers    ${response.status_code}    401
