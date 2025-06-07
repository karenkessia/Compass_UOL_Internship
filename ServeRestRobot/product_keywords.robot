# ╭────────────────────────────────────────────────────────────╮
# │ Configurações e Recursos                                   │
# ╰────────────────────────────────────────────────────────────╯

*** Settings ***
Documentation    Keywords para operações com produtos na API ServeRest
Library          RequestsLibrary
Library          String
Library          FakerLibrary
Resource         ../variables/serverest_vars.robot
Resource         ./common.robot
Resource         ./user_keywords.robot


# ╭────────────────────────────────────────────────────────────╮
# │ Keyword: Cadastrar Produto                                 │
# ╰────────────────────────────────────────────────────────────╯

*** Keywords ***
Cadastrar Produto
    [Documentation]    Cadastra um produto na API
    [Arguments]         ${nome}    ${preco}    ${descricao}    ${quantidade}    ${token}=${TOKEN}
    
    ${body}=            Create Dictionary
    ...                 nome=${nome}
    ...                 preco=${preco}
    ...                 descricao=${descricao}
    ...                 quantidade=${quantidade}
    
    ${response}=        Fazer Requisição API    POST    ${PRODUCTS_ENDPOINT}    ${body}    ${token}
    RETURN              ${response}


# ╭────────────────────────────────────────────────────────────╮
# │ Keyword: Cadastrar Produto Com Sucesso                     │
# ╰────────────────────────────────────────────────────────────╯

Cadastrar Produto Com Sucesso
    [Documentation]    Cadastra um produto e valida que foi criado com sucesso (status 201)
    [Arguments]         ${nome}=${EMPTY}    ${preco}=100    ${descricao}=${EMPTY}    ${quantidade}=100    ${token}=${TOKEN}

    # Gera dados aleatórios se não fornecidos
    ${nome_final}=      Run Keyword If    '${nome}' == '${EMPTY}'    Gerar Nome Produto Aleatório
    ...                 ELSE    Set Variable    ${nome}

    ${descricao_final}= Run Keyword If    '${descricao}' == '${EMPTY}'    Gerar Descrição Produto Aleatória
    ...                 ELSE    Set Variable    ${descricao}

    ${response}=        Cadastrar Produto    ${nome_final}    ${preco}    ${descricao_final}    ${quantidade}    ${token}
    Validar Status Code    ${response}    201
    RETURN              ${response}


# ╭────────────────────────────────────────────────────────────╮
# │ Keyword: Gerar Nome Produto Aleatório                      │
# ╰────────────────────────────────────────────────────────────╯

Gerar Nome Produto Aleatório
    ${numero}=          Generate Random String    4    [NUMBERS]
    ${nome}=            Set Variable    Produto${numero}
    RETURN              ${nome}


# ╭────────────────────────────────────────────────────────────╮
# │ Keyword: Gerar Descrição Produto Aleatória                 │
# ╰────────────────────────────────────────────────────────────╯

Gerar Descrição Produto Aleatória
    [Documentation]     Gera uma descrição aleatória para produto
    ${bs}=              FakerLibrary.BS
    ${descricao}=       Set Variable    Produto: ${bs}
    RETURN              ${descricao}


# ╭────────────────────────────────────────────────────────────╮
# │ Keyword: Obter Token De Autenticação                       │
# ╰────────────────────────────────────────────────────────────╯

Obter Token De Autenticação
    [Documentation]     Obtém um token de autenticação para um usuário
    [Arguments]         ${email}=${EMPTY}    ${senha}=${EMPTY}

    # Usa credenciais fornecidas ou gera novas
    ${email_final}=     Run Keyword If    '${email}' == '${EMPTY}'    Gerar Email Aleatório Válido
    ...                 ELSE    Set Variable    ${email}

    ${senha_final}=     Run Keyword If    '${senha}' == '${EMPTY}'    Gerar Senha Aleatória Válida
    ...                 ELSE    Set Variable    ${senha}

    # Cadastra um usuário administrador
    ${nome}=            Gerar Nome Aleatório Válido
    Cadastrar Usuário Com Sucesso    ${nome}    ${email_final}    ${senha_final}    true

    # Faz login para obter o token
    ${body}=            Create Dictionary
    ...                 email=${email_final}
    ...                 password=${senha_final}

    ${response}=        Fazer Requisição API    POST    ${AUTH_ENDPOINT}    ${body}
    Validar Status Code    ${response}    200

    ${token}=           Set Variable    ${response.json()['authorization']}
    RETURN              ${token}


# ╭────────────────────────────────────────────────────────────╮
# │ Keyword: Listar Produtos                                   │
# ╰────────────────────────────────────────────────────────────╯

Listar Produtos
    [Documentation]     Lista todos os produtos cadastrados
    ${response}=        Fazer Requisição API    GET    ${PRODUCTS_ENDPOINT}
    RETURN              ${response}


# ╭────────────────────────────────────────────────────────────╮
# │ Keyword: Obter Produto Por ID                              │
# ╰────────────────────────────────────────────────────────────╯

Obter Produto Por ID
    [Documentation]     Obtém um produto pelo ID
    [Arguments]         ${id}
    ${response}=        Fazer Requisição API    GET    ${PRODUCTS_ENDPOINT}/${id}
    RETURN              ${response}
