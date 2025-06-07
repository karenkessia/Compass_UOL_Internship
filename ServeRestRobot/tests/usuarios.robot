*** Settings ***
Documentation     Testes para operações de usuários na API ServeRest
Resource          ../variables/serverest_vars.robot
Resource          ../resources/common.robot
Resource          ../resources/user_keywords.robot
Resource          ../resources/product_keywords.robot
Library           RequestsLibrary
Library           Collections
Suite Setup       Criar e Iniciar Sessão API


# ╭────────────────────────────╮
# │ POST - Testes de Cadastro  │
# ╰────────────────────────────

*** Test Cases ***
TC001-Criar Usuario Com Dados Validos
    [Documentation]    Verifica que é possível cadastrar um novo usuário com dados válidos
    [Tags]    post    usuarios    cadastro    positive
    ${email}=    Gerar Email Aleatório Válido
    ${response}=    Cadastrar Usuário Com Sucesso
    ...    ${NOME_VALIDO}
    ...    ${email}
    ...    ${SENHA_VALIDA}
    ...    true
    Log To Console    Cadastro realizado com ID: ${response.json()['_id']}

TC003-Criar Usuario Com E-mail Duplicado
    [Documentation]    Verifica que não é possível cadastrar usuário com email duplicado
    [Tags]    post    usuarios    cadastro    negative    duplicado
    ${email}=    Gerar Email Aleatório Válido

    # Primeiro cadastro - sucesso
    Cadastrar Usuário Com Sucesso
    ...    ${NOME_VALIDO}
    ...    ${email}
    ...    ${SENHA_VALIDA}
    ...    true

    # Segundo cadastro - falha (email duplicado)
    Cadastrar Usuário Com Email Já Existente
    ...    ${NOME_VALIDO}
    ...    ${email}
    ...    ${SENHA_VALIDA}
    ...    true

TC008-Criar Usuario Com Senha Inferior a 5 Caracteres
    [Documentation]    Verifica validação de tamanho mínimo para senha
    [Tags]    post    usuarios    cadastro    validation    senha
    ${email}=    Gerar Email Aleatório Válido
    ${response}=    Cadastrar Usuário
    ...    ${NOME_VALIDO}
    ...    ${email}
    ...    1
    ...    true
    Should Be Equal As Integers    ${response.status_code}    400

TC009-Criar Usuario Com Senha Superior a 10 Caracteres
    [Documentation]    Verifica validação de tamanho máximo para senha
    [Tags]    post    usuarios    cadastro    validation    senha
    ${email}=    Gerar Email Aleatório Válido
    ${response}=    Cadastrar Usuário
    ...    ${NOME_VALIDO}
    ...    ${email}
    ...    12345678901234567890
    ...    true
    Should Be Equal As Integers    ${response.status_code}    400

TC002-Criar Usuario Com Dominio de E-mail Invalido Gmail
    [Documentation]    Verifica rejeição de cadastro com domínio @gmail.com
    [Tags]    post    usuarios    cadastro    validation    email
    ${email}=    Gerar Email Aleatório Inválido    gmail.com
    ${response}=    Cadastrar Usuário
    ...    ${NOME_VALIDO}
    ...    ${email}
    ...    ${SENHA_VALIDA}
    ...    true
    Should Be Equal As Integers    ${response.status_code}    400

TC002-Criar Usuario Com Dominio de E-mail Invalido Hotmail
    [Documentation]    Verifica rejeição de cadastro com domínio @hotmail.com
    [Tags]    post    usuarios    cadastro    validation    email
    ${email}=    Gerar Email Aleatório Inválido    hotmail.com
    ${response}=    Cadastrar Usuário
    ...    ${NOME_VALIDO}
    ...    ${email}
    ...    ${SENHA_VALIDA}
    ...    true
    Should Be Equal As Integers    ${response.status_code}    400

EXTRA-Cadastro Com Campo Obrigatório Faltando
    [Documentation]    Verifica validação quando campo obrigatório (senha) é omitido
    [Tags]    post    usuarios    cadastro    validation    obrigatorio
    ${email}=    Gerar Email Aleatório Válido
    ${response}=    Cadastrar Usuário
    ...    ${NOME_VALIDO}
    ...    ${email}
    ...
    ...    true
    Should Be Equal As Integers    ${response.status_code}    400


# ╭────────────────────────────╮
# │ GET - Testes de Consulta   │
# ╰────────────────────────────

EXTRA-Listar Todos Os Usuários
    [Documentation]    Verifica que é possível listar todos os usuários cadastrados
    [Tags]    get    usuarios    positive
    ${response}=    Listar Usuários
    Should Be Equal As Integers    ${response.status_code}    200
    Should Not Be Empty    ${response.json()['usuarios']}
    Log To Console    Total de usuários: ${response.json()['quantidade']}

EXTRA-Buscar Usuário Por ID
    [Documentation]    Verifica que é possível buscar um usuário específico por ID
    [Tags]    get    usuarios    positive

    # Cadastra um usuário para garantir que existe
    ${nome}=    Gerar Nome Aleatório Válido
    ${email}=    Gerar Email Aleatório Válido
    ${senha}=    Gerar Senha Aleatória Válida
    ${response}=    Cadastrar Usuário Com Sucesso    ${nome}    ${email}    ${senha}    false
    ${id}=    Set Variable    ${response.json()['_id']}

    # Busca o usuário pelo ID
    ${response}=    Obter Usuário Por ID    ${id}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Be Equal    ${response.json()['nome']}    ${nome}
    Should Be Equal    ${response.json()['email']}    ${email}
    Should Be Equal    ${response.json()['_id']}    ${id}

TC005-Consultar Usuário Com ID Inexistente
    [Documentation]    Verifica o comportamento ao buscar um usuário com ID inexistente
    [Tags]    get    usuarios    negative
    ${id_inexistente}=    Set Variable    abc123inexistente
    ${response}=    Obter Usuário Por ID    ${id_inexistente}
    Should Be Equal As Integers    ${response.status_code}    400
    Should Contain    ${response.json()['message']}    não encontrado


# ╭────────────────────────────╮
# │ PUT - Testes de Atualização│
# ╰────────────────────────────

EXTRA-Atualizar Dados De Usuário Com Sucesso
    [Documentation]    Verifica que é possível atualizar os dados de um usuário existente
    [Tags]    put    usuarios    positive

    ${nome_original}=    Gerar Nome Aleatório Válido
    ${email_original}=    Gerar Email Aleatório Válido
    ${senha_original}=    Gerar Senha Aleatória Válida
    ${response}=    Cadastrar Usuário Com Sucesso    ${nome_original}    ${email_original}    ${senha_original}    false
    ${id}=    Set Variable    ${response.json()['_id']}

    ${token}=    Obter Token De Autenticação

    ${novo_nome}=    Gerar Nome Aleatório Válido
    ${novo_email}=    Gerar Email Aleatório Válido
    ${nova_senha}=    Gerar Senha Aleatória Válida
    ${response}=    Atualizar Usuário
    ...    ${id}
    ...    ${novo_nome}
    ...    ${novo_email}
    ...    ${nova_senha}
    ...    false
    ...    ${token}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Contain    ${response.json()['message']}    sucesso

    ${response}=    Obter Usuário Por ID    ${id}
    Should Be Equal    ${response.json()['nome']}    ${novo_nome}
    Should Be Equal    ${response.json()['email']}    ${novo_email}

TC010-Atualizar Usuário Com E-mail Duplicado
    [Documentation]    Verifica que não é possível atualizar um usuário com email já utilizado por outro
    [Tags]    put    usuarios    negative    duplicado

    ${nome1}=    Gerar Nome Aleatório Válido
    ${email1}=    Gerar Email Aleatório Válido
    ${senha1}=    Gerar Senha Aleatória Válida
    ${response1}=    Cadastrar Usuário Com Sucesso    ${nome1}    ${email1}    ${senha1}    false
    ${id1}=    Set Variable    ${response1.json()['_id']}

    ${nome2}=    Gerar Nome Aleatório Válido
    ${email2}=    Gerar Email Aleatório Válido
    ${senha2}=    Gerar Senha Aleatória Válida
    Cadastrar Usuário Com Sucesso    ${nome2}    ${email2}    ${senha2}    false

    ${token}=    Obter Token De Autenticação

    ${response}=    Atualizar Usuário
    ...    ${id1}
    ...    ${nome1}
    ...    ${email2}
    ...    ${senha1}
    ...    false
    ...    ${token}
    Should Be Equal As Integers    ${response.status_code}    400
    Should Contain    ${response.json()['message']}    já está sendo usado
