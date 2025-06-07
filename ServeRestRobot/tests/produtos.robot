*** Settings ***
Documentation    Testes para operações de produtos na API ServeRest
Resource         ../variables/serverest_vars.robot
Resource         ../resources/common.robot
Resource         ../resources/product_keywords.robot
Resource         ../resources/user_keywords.robot
Library          RequestsLibrary
Library          Collections
Suite Setup      Criar e Iniciar Sessão API

 

*** Test Cases ***

# ╭────────────────────────────╮
# │ POST - Testes de Cadastro  │
# ╰────────────────────────────╯

TC016-Criar Produto Com Dados Validos
    [Documentation]    Verifica que é possível cadastrar um novo produto com dados válidos
    [Tags]    post    produtos    cadastro    positive

    ${token}=          Obter Token De Autenticação
    ${nome}=           Gerar Nome Produto Aleatório
    ${descricao}=      Gerar Descrição Produto Aleatória
    ${response}=       Cadastrar Produto Com Sucesso    ${nome}    100    ${descricao}    50    ${token}
    Should Be Equal As Integers    ${response.status_code}    201
    Log To Console     Produto cadastrado com ID: ${response.json()['_id']}

TC017-Criar Produto Com Nome Duplicado
    [Documentation]    Verifica que não é possível cadastrar produto com nome duplicado
    [Tags]    post    produtos    cadastro    negative    duplicado

    ${token}=          Obter Token De Autenticação
    ${nome}=           Gerar Nome Produto Aleatório
    ${descricao}=      Gerar Descrição Produto Aleatória
    Cadastrar Produto Com Sucesso    ${nome}    100    ${descricao}    50    ${token}

    ${response}=       Cadastrar Produto    ${nome}    200    ${descricao}    100    ${token}
    Should Be Equal As Integers    ${response.status_code}    400
    Should Contain     ${response.json()['message']}    já está sendo usado

TC020-Acessar Produtos Sem Autenticação
    [Documentation]    Verifica que não é possível cadastrar produto sem token
    [Tags]    post    produtos    cadastro    negative    autenticacao

    ${nome}=           Gerar Nome Produto Aleatório
    ${descricao}=      Gerar Descrição Produto Aleatória
    ${response}=       Cadastrar Produto    ${nome}    100    ${descricao}    50    ${EMPTY}
    Should Be Equal As Integers    ${response.status_code}    401
    Should Contain     ${response.json()['message']}    Token

# ╭────────────────────────────╮
# │ GET - Testes de Consulta   │
# ╰────────────────────────────╯

EXTRA-Listar Todos Os Produtos
    [Documentation]    Verifica que é possível listar todos os produtos cadastrados
    [Tags]    get    produtos    positive

    ${response}=       Listar Produtos
    Should Be Equal As Integers    ${response.status_code}    200
    Should Not Be Empty            ${response.json()['produtos']}
    Log To Console                 Total de produtos: ${response.json()['quantidade']}

EXTRA-Buscar Produto Por ID
    [Documentation]    Verifica que é possível buscar um produto específico por ID
    [Tags]    get    produtos    positive

    ${token}=          Obter Token De Autenticação
    ${nome}=           Gerar Nome Produto Aleatório
    ${descricao}=      Gerar Descrição Produto Aleatória
    ${response}=       Cadastrar Produto Com Sucesso    ${nome}    100    ${descricao}    50    ${token}
    ${id}=             Set Variable    ${response.json()['_id']}

    ${response}=       Obter Produto Por ID    ${id}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Be Equal               ${response.json()['nome']}        ${nome}
    Should Be Equal               ${response.json()['descricao']}   ${descricao}
    Should Be Equal               ${response.json()['_id']}         ${id}

EXTRA-Buscar Produto Com ID Inexistente
    [Documentation]    Verifica o comportamento ao buscar um produto com ID inexistente
    [Tags]    get    produtos    negative

    ${id_inexistente}=    Set Variable   abc123inexistente 
    ${response}=       Obter Produto Por ID    ${id_inexistente}
    Should Be Equal As Integers    ${response.status_code}    400
    Should Contain     ${response.json()['message']}    não encontrado

# ╭────────────────────────────────╮
# │ PUT - Testes de Atualização    │
# ╰────────────────────────────────╯

EXTRA-Atualizar Produto Com Sucesso
    [Documentation]    Verifica que é possível atualizar os dados de um produto existente
    [Tags]    put    produtos    positive

    ${token}=             Obter Token De Autenticação
    ${nome_original}=     Gerar Nome Produto Aleatório
    ${descricao_original}=    Set Variable    
    ${descricao_original}=Gerar Descrição Produto Aleatória
    ${response}=          Cadastrar Produto Com Sucesso    ${nome_original}    100    ${descricao_original}    50    ${token}
    ${id}=                Set Variable    ${response.json()['_id']}

    ${novo_nome}=         Gerar Nome Produto Aleatório
    ${nova_descricao}=    Gerar Descrição Produto Aleatória
    ${body}=              Create Dictionary
    ...                   nome=${novo_nome}
    ...                   preco=200
    ...                   descricao=${nova_descricao}
    ...                   quantidade=100

    ${response}=          Fazer Requisição API    PUT    ${PRODUCTS_ENDPOINT}/${id}    ${body}    ${token}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Contain     ${response.json()['message']}    sucesso

    ${response}=          Obter Produto Por ID    ${id}
    Should Be Equal      ${response.json()['nome']}        ${novo_nome}
    Should Be Equal      ${response.json()['descricao']}   ${nova_descricao}
    Should Be Equal As Strings    ${response.json()['preco']}    200

# ╭──────────────────────────────╮
# │ DELETE - Testes de Exclusão  │
# ╰──────────────────────────────╯

EXTRA-Excluir Produto Com Sucesso
    [Documentation]    Verifica que é possível excluir um produto existente
    [Tags]    delete    produtos    positive

    ${token}=          Obter Token De Autenticação
    ${nome}=           Gerar Nome Produto Aleatório
    ${descricao}=      Gerar Descrição Produto Aleatória
    ${response}=       Cadastrar Produto Com Sucesso    ${nome}    100    ${descricao}    50    ${token}
    ${id}=             Set Variable    ${response.json()['_id']}

    ${response}=       Fazer Requisição API    DELETE    ${PRODUCTS_ENDPOINT}/${id}    token=${token}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Contain     ${response.json()['message']}    excluído com sucesso

    ${response}=       Obter Produto Por ID    ${id}
    Should Be Equal As Integers    ${response.status_code}    400
    Should Contain     ${response.json()['message']}    não encontrado

EXTRA-Excluir Produto Sem Autenticação
    [Documentation]    Verifica que não é possível excluir um produto sem token
    [Tags]    delete    produtos    negative    autenticacao

    ${token}=          Obter Token De Autenticação
    ${nome}=           Gerar Nome Produto Aleatório
    ${descricao}=      Gerar Descrição Produto Aleatória
    ${response}=       Cadastrar Produto Com Sucesso    ${nome}    100    ${descricao}    50    ${token}
    ${id}=             Set Variable    ${response.json()['_id']}

    ${response}=       Fazer Requisição API    DELETE    ${PRODUCTS_ENDPOINT}/${id}
    Should Be Equal As Integers    ${response.status_code}    401
    Should Contain     ${response.json()['message']}    Token
