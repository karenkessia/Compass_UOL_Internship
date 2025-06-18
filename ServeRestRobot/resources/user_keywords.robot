*** Settings ***
Documentation    Keywords para operações com usuários na API ServeRest
Library          RequestsLibrary
Resource         ../variables/serverest_vars.robot
Resource         ./common.robot


# ╭────────────────────────────────────────╮
# │ Cadastro de Usuário                    │
# ╰────────────────────────────────────────╯
*** Keywords ***
Cadastrar Usuário
    [Documentation]    Cadastra um usuário na API
    [Arguments]    ${nome}    ${email}    ${password}    ${administrador}
    ${body}=    Create Dictionary
    ...    nome=${nome}
    ...    email=${email}
    ...    password=${password}
    ...    administrador=${administrador}
    
    ${response}=    Fazer Requisição API    POST    ${USERS_ENDPOINT}    ${body}
    RETURN    ${response}


# ╭────────────────────────────────────────╮
# │ Cadastro com Sucesso                   │
# ╰────────────────────────────────────────╯
Cadastrar Usuário Com Sucesso
    [Documentation]    Cadastra um usuário e valida que foi criado com sucesso (status 201)
    [Arguments]    ${nome}=${EMPTY}    ${email}=${EMPTY}    ${password}=${EMPTY}    ${administrador}=true

    # Gera dados aleatórios se não fornecidos
    ${nome_final}=     Run Keyword If    '${nome}' == '${EMPTY}'     Gerar Nome Aleatório Válido     ELSE     Set Variable    ${nome}
    ${email_final}=    Run Keyword If    '${email}' == '${EMPTY}'    Gerar Email Aleatório Válido    ELSE     Set Variable    ${email}
    ${senha_final}=    Run Keyword If    '${password}' == '${EMPTY}' Gerar Senha Aleatória Válida    ELSE     Set Variable    ${password}
    
    ${response}=    Cadastrar Usuário    ${nome_final}    ${email_final}    ${senha_final}    ${administrador}
    Validar Status Code    ${response}    201
    RETURN    ${response}


# ╭──────────────────────────────────────────────╮
# │ Cadastro com Email Já Existente              │
# ╰──────────────────────────────────────────────╯
Cadastrar Usuário Com Email Já Existente
    [Documentation]    Tenta cadastrar um usuário com email já existente e valida erro 400
    [Arguments]    ${nome}    ${email}    ${password}    ${administrador}
    
    ${response}=    Cadastrar Usuário    ${nome}    ${email}    ${password}    ${administrador}
    Validar Status Code    ${response}    400
    Should Contain    ${response.json()['message']}    já está sendo usado
    RETURN    ${response}


# ╭────────────────────────────────────────╮
# │ Operações com Usuário                  │
# ╰────────────────────────────────────────╯
Obter Usuário Por ID
    [Documentation]    Obtém um usuário pelo ID
    [Arguments]    ${id}
    ${response}=    Fazer Requisição API    GET    ${USERS_ENDPOINT}/${id}
    RETURN    ${response}


Listar Usuários
    [Documentation]    Lista todos os usuários cadastrados
    ${response}=    Fazer Requisição API    GET    ${USERS_ENDPOINT}
    RETURN    ${response}


Excluir Usuário
    [Documentation]    Exclui um usuário pelo ID
    [Arguments]    ${id}    ${token}
    ${response}=    Fazer Requisição API    DELETE    ${USERS_ENDPOINT}/${id}    token=${token}
    RETURN    ${response}


Atualizar Usuário
    [Documentation]    Atualiza os dados de um usuário existente
    [Arguments]    ${id}    ${nome}    ${email}    ${password}    ${administrador}    ${token}
    ${body}=    Create Dictionary
    ...    nome=${nome}
    ...    email=${email}
    ...    password=${password}
    ...    administrador=${administrador}
    
    ${response}=    Fazer Requisição API    PUT    ${USERS_ENDPOINT}/${id}    ${body}    ${token}
    RETURN    ${response}
