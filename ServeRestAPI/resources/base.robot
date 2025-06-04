*** Settings ***
Library           RequestsLibrary
Library           Collections
Library           String
Library           DateTime
Resource          ../variables/variables.robot

*** Keywords ***

# ╭────────────────────────────╮
# │ Sessão da API              │
# ╰────────────────────────────╯
Criar Sessao ServeRest
    [Documentation]    Cria uma sessão HTTP para a API ServeRest
    Create Session     ServeRestAPI    ${base_url}    verify=True
    Log                Sessão criada para: ${base_url}


# ╭────────────────────────────╮
# │ Requisições HTTP           │
# ╰────────────────────────────╯
Fazer Requisicao GET
    [Documentation]    Realiza requisição GET na API
    [Arguments]        ${endpoint}    ${headers}=${None}    ${params}=${None}
    ${response}=       GET On Session     ServeRestAPI    ${endpoint}
    ...                headers=${headers}    params=${params}    expected_status=any
    Log                GET ${endpoint} | Status: ${response.status_code}
    Log                Response: ${response.text}
    RETURN             ${response}

Fazer Requisicao POST
    [Documentation]    Realiza requisição POST na API
    [Arguments]        ${endpoint}    ${data}    ${headers}=${None}
    ${response}=       POST On Session    ServeRestAPI    ${endpoint}
    ...                json=${data}    headers=${headers}    expected_status=any
    Log                POST ${endpoint} | Status: ${response.status_code}
    Log                Payload: ${data}
    Log                Response: ${response.text}
    RETURN             ${response}

Fazer Requisicao PUT
    [Documentation]    Realiza requisição PUT na API
    [Arguments]        ${endpoint}    ${data}    ${headers}=${None}
    ${response}=       PUT On Session    ServeRestAPI    ${endpoint}
    ...                json=${data}    headers=${headers}    expected_status=any
    Log                PUT ${endpoint} | Status: ${response.status_code}
    Log                Payload: ${data}
    Log                Response: ${response.text}
    RETURN             ${response}

Fazer Requisicao DELETE
    [Documentation]    Realiza requisição DELETE na API
    [Arguments]        ${endpoint}    ${headers}=${None}
    ${response}=       DELETE On Session    ServeRestAPI    ${endpoint}
    ...                headers=${headers}    expected_status=any
    Log                DELETE ${endpoint} | Status: ${response.status_code}
    Log                Response: ${response.text}
    RETURN             ${response}


# ╭────────────────────────────╮
# │ Headers e Autenticação     │
# ╰────────────────────────────╯
Criar Headers Com Token
    [Documentation]    Cria headers com token de autorização Bearer
    [Arguments]        ${token}
    ${headers}=        Create Dictionary    Authorization=Bearer ${token}
    RETURN             ${headers}


# ╭────────────────────────────╮
# │ Geradores de Dados Únicos  │
# ╰────────────────────────────╯
Gerar Email Unico
    [Documentation]    Gera um e-mail único com base em timestamp e número aleatório
    ${timestamp}=      Get Current Date    result_format=%Y%m%d%H%M%S%f
    ${random}=         Evaluate    random.randint(1000, 9999)    modules=random
    ${email_unico}=    Set Variable    teste${timestamp}${random}@automation.com
    RETURN             ${email_unico}

Gerar Nome Produto Unico
    [Documentation]    Gera um nome de produto único com base em timestamp e número aleatório
    ${timestamp}=      Get Current Date    result_format=%Y%m%d%H%M%S%f
    ${random}=         Evaluate    random.randint(100, 999)    modules=random
    ${nome_unico}=     Set Variable    Produto Teste ${timestamp}${random}
    RETURN             ${nome_unico}
