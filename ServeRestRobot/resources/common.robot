# ╭────────────────────────────────────────────────────╮
# │ Configurações e Bibliotecas Comuns                 │
# ╰────────────────────────────────────────────────────╯

*** Settings ***
Documentation     Keywords comuns utilizados em múltiplos testes da API ServeRest
Library           String
Library           RequestsLibrary
Library           FakerLibrary
Library           Collections
Resource          ../variables/serverest_vars.robot


# ╭────────────────────────────────────────────────────╮
# │ Sessão de Inicialização da API                     │
# ╰────────────────────────────────────────────────────╯

*** Keywords ***
Criar e Iniciar Sessão API
    [Documentation]    Cria a sessão de API com headers padrão
    Create Session
    ...    api-session
    ...    ${BASE_URL}
    ...    headers=${HEADERS}
    ...    verify=True


# ╭────────────────────────────────────────────────────╮
# │ Geradores de Dados Aleatórios                      │
# ╰────────────────────────────────────────────────────╯

Gerar Nome Aleatório Válido
    [Documentation]    Gera um nome aleatório usando FakerLibrary
    ${nome}=    FakerLibrary.Name
    RETURN      ${nome}

Gerar Email Aleatório Válido
    [Documentation]    Gera um email aleatório com domínio válido
    ${username}=    FakerLibrary.User Name
    ${email}=       Set Variable    ${username}@compasso.com
    RETURN          ${email}

Gerar Email Aleatório Inválido
    [Documentation]    Gera um email aleatório com domínio específico
    [Arguments]        ${dominio}
    ${username}=       FakerLibrary.User Name
    ${email}=          Set Variable    ${username}@${dominio}
    RETURN             ${email}

Gerar Senha Aleatória Válida
    [Documentation]    Gera uma senha aleatória usando FakerLibrary
    ${senha}=    FakerLibrary.Password
    ...          length=8
    ...          special_chars=True
    ...          digits=True
    ...          upper_case=True
    ...          lower_case=True
    RETURN       ${senha}


# ╭────────────────────────────────────────────────────╮
# │ Utilitários para Requisições HTTP                  │
# ╰────────────────────────────────────────────────────╯

Fazer Requisição API
    [Documentation]    Realiza uma requisição HTTP para a API e retorna a resposta
    [Arguments]        ${method}    ${endpoint}    ${body}=${EMPTY}
    ...                ${token}=${EMPTY}           ${expected_status}=any

    ${headers}=        Create Dictionary
    ...                Content-Type=application/json
    ...                Accept=application/json

    # Adiciona token de autorização se fornecido
    IF    '${token}' != '${EMPTY}'
        Set To Dictionary    ${headers}    Authorization=${token}
    END

    ${response}=    Run Keyword If    '${method}' == 'POST'
    ...            POST On Session     api-session
    ...                                url=${endpoint}
    ...                                json=${body}
    ...                                headers=${headers}
    ...                                expected_status=${expected_status}
    ...    ELSE IF    '${method}' == 'GET'
    ...            GET On Session      api-session
    ...                                url=${endpoint}
    ...                                headers=${headers}
    ...                                expected_status=${expected_status}
    ...    ELSE IF    '${method}' == 'PUT'
    ...            PUT On Session      api-session
    ...                                url=${endpoint}
    ...                                json=${body}
    ...                                headers=${headers}
    ...                                expected_status=${expected_status}
    ...    ELSE IF    '${method}' == 'DELETE'
    ...            DELETE On Session   api-session
    ...                                url=${endpoint}
    ...                                headers=${headers}
    ...                                expected_status=${expected_status}

    RETURN    ${response}


# ╭────────────────────────────────────────────────────╮
# │ Validação de Resposta                              │
# ╰────────────────────────────────────────────────────╯

Validar Status Code
    [Documentation]    Valida o status code da resposta
    [Arguments]        ${response}    ${expected_status}
    Should Be Equal As Integers    ${response.status_code}    ${expected_status}
