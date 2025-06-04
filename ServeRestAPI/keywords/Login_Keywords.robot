# ╭────────────────────────────╮
# │     Testes de Login        │
# ╰────────────────────────────╯

*** Settings ***
Library           Collections
Library           RequestsLibrary
Library           DateTime

Resource          ../variables/variables.robot
Resource          ../resources/base.robot

*** Keywords ***

# ╭──────────────────────────────────────────╮
# │      Ações de Login (Fluxo Principal)    │
# ╰──────────────────────────────────────────╯

Realizar Login Com Credenciais Validas
    ${response}=    Login Com Credenciais Validas
    Validar Login Bem Sucedido    ${response}
    Logar Token Obtido            ${response}

Realizar Login Com Senha Invalida
    ${response}=    Login Com Senha Invalida
    Validar Login Rejeitado       ${response}

Realizar Login Com Usuario Inexistente
    ${response}=    Login Com Usuario Nao Cadastrado
    Validar Login Rejeitado       ${response}

Acessar Rota Com Token Invalido
    ${response}=    Acessar Rota Protegida Com Token Expirado
    Validar Acesso Negado Por Token    ${response}

# ╭──────────────────────────────────────────╮
# │     Validações de Respostas de Login     │
# ╰──────────────────────────────────────────╯

Validar Login Bem Sucedido
    [Arguments]    ${response}
    Should Be Equal As Integers              ${response.status_code}    200
    Should Contain                           ${response.json()['message']}    Login realizado com sucesso
    Dictionary Should Contain Key            ${response.json()}         authorization
    Should Not Be Empty                      ${response.json()['authorization']}

Validar Login Rejeitado
    [Arguments]    ${response}
    Should Be Equal As Integers              ${response.status_code}    401
    Should Contain                           ${response.json()['message']}    Email e/ou senha inválidos
    Dictionary Should Not Contain Key        ${response.json()}         authorization

Validar Acesso Negado Por Token
    [Arguments]    ${response}
    Should Be Equal As Integers              ${response.status_code}    401
    Should Contain                           ${response.json()['message']}    Token de acesso ausente, inválido, expirado ou usuário do token não existe mais

# ╭────────────────────────────────────────────╮
# │        Extração e Armazenamento de Token   │
# ╰────────────────────────────────────────────╯

Logar Token Obtido
    [Arguments]    ${response}
    ${authorization}=    Set Variable        ${response.json()['authorization']}
    ${token}=           Replace String       ${authorization}    Bearer${SPACE}    ${EMPTY}
    Log To Console                           Token obtido: ${token[:20]}...

Extrair Token Da Resposta De Login
    [Arguments]    ${response}
    ${auth}=    Set Variable                 ${response.json()['authorization']}
    ${token}=   Replace String               ${auth}    Bearer${SPACE}    ${EMPTY}
    RETURN     ${token}

# ╭──────────────────────────────────────────╮
# │    Criação de Usuário para Login Teste   │
# ╰──────────────────────────────────────────╯

Criar Usuario Para Login
    ${email}=    Gerar Email Unico
    ${payload}=    Create Dictionary
    ...    nome=${nome_do_usuario}
    ...    email=${email}
    ...    password=${senha_do_usuario}
    ...    administrador=true

    ${response}=    Fazer Requisicao POST    /usuarios    ${payload}
    Should Be Equal As Integers              ${response.status_code}    201

    ${json}=    Set Variable                 ${response.json()}
    Set Suite Variable    ${EMAIL_TESTE_LOGIN}    ${email}
    Set Suite Variable    ${SENHA_TESTE_LOGIN}    ${senha_do_usuario}
    Set Suite Variable    ${USER_ID_LOGIN}        ${json['_id']}
    RETURN    ${response}

# ╭────────────────────────────────────────────╮
# │    Cenários de Login com Diferentes Dados  │
# ╰────────────────────────────────────────────╯

Login Com Credenciais Validas
    ${payload}=    Create Dictionary
    ...    email=${EMAIL_TESTE_LOGIN}
    ...    password=${SENHA_TESTE_LOGIN}

    ${response}=    Fazer Requisicao POST    /login    ${payload}

    IF    ${response.status_code} == 200
        ${auth}=    Set Variable    ${response.json()['authorization']}
        ${token}=   Replace String   ${auth}    Bearer${SPACE}    ${EMPTY}
        Set Suite Variable    ${TOKEN_VALIDO}           ${token}
        Set Suite Variable    ${AUTHORIZATION_HEADER}   ${auth}
    END
    RETURN    ${response}

Login Com Senha Invalida
    ${payload}=    Create Dictionary
    ...    email=${EMAIL_TESTE_LOGIN}
    ...    password=senha_incorreta_123

    ${response}=    Fazer Requisicao POST    /login    ${payload}
    RETURN         ${response}

Login Com Usuario Nao Cadastrado
    ${payload}=    Create Dictionary
    ...    email=${email_inexistente}
    ...    password=${senha_do_usuario}

    ${response}=    Fazer Requisicao POST    /login    ${payload}
    RETURN         ${response}

# ╭────────────────────────────────────────────╮
# │   Acesso Indevido com Token Inexistente   │
# ╰────────────────────────────────────────────╯

Acessar Rota Protegida Com Token Expirado
    ${token}=      Set Variable               token_completamente_invalido_123
    ${headers}=    Criar Headers Com Token    ${token}
    ${response}=   Fazer Requisicao GET       /usuarios    ${headers}
    RETURN         ${response}

# ╭────────────────────────────────────────────╮
# │   Login Direto para Obtenção de Token     │
# ╰────────────────────────────────────────────╯

Fazer Login E Obter Token
    [Arguments]    ${email}    ${password}
    ${payload}=    Create Dictionary
    ...    email=${email}
    ...    password=${password}

    ${response}=   Fazer Requisicao POST    /login    ${payload}
    Should Be Equal As Integers             ${response.status_code}    200

    ${token}=      Extrair Token Da Resposta De Login    ${response}
    RETURN         ${token}