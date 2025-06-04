# ╭────────────────────────────────────────╮
# │ Testes de Criação de Usuário           │
# ╰────────────────────────────────────────╯

*** Settings ***
Library           Collections
Library           RequestsLibrary
Resource          ../variables/variables.robot
Resource          ../resources/base.robot
Resource          login_keywords.robot

*** Keywords ***

TC001 - Criar usuário com dados válidos
    ${email}=            Gerar Email Unico
    ${payload}=          Create Dictionary
    ...                  nome=Teste User
    ...                  email=${email}
    ...                  password=12345
    ...                  administrador=true
    ${res}=              Fazer Requisicao POST    /usuarios    ${payload}
    Should Be Equal As Integers                  ${res.status_code}    201


# ╭──────────────────────────────╮
# │ Testes de Produto            │
# ╰──────────────────────────────╯

TC016 - Criar produto com dados válidos
    ${nome}=             Gerar Nome Produto Unico
    ${headers}=          Criar Headers Com Token            ${TOKEN_ADMIN}
    ${payload}=          Create Dictionary
    ...                  nome=${nome}
    ...                  preco=250
    ...                  descricao=Produto x
    ...                  quantidade=8
    ${res}=              Fazer Requisicao POST              /produtos    ${payload}    ${headers}
    Should Be Equal As Integers                            ${res.status_code}    201
    Set Suite Variable                                     ${PRODUTO_ID}              ${res.json()['_id']}
    Set Suite Variable                                     ${NOME_PRODUTO_CRIADO}     ${nome}

TC017 - Criar produto com nome duplicado
    ${headers}=          Criar Headers Com Token            ${TOKEN_ADMIN}
    ${payload}=          Create Dictionary
    ...                  nome=${NOME_PRODUTO_CRIADO}
    ...                  preco=156
    ...                  descricao=Produto nome duplicado
    ...                  quantidade=4
    ${res}=              Fazer Requisicao POST              /produtos    ${payload}    ${headers}
    Should Be Equal As Integers                            ${res.status_code}    400
    Should Contain                                          ${res.json()['message']}    Já existe produto com esse nome

TC019 - Atualizar produto com ID inexistente
    ${nome}=             Gerar Nome Produto Unico
    ${headers}=          Criar Headers Com Token            ${TOKEN_ADMIN}
    ${payload}=          Create Dictionary
    ...                  nome=${nome}
    ...                  preco=76
    ...                  descricao=Teste produto
    ...                  quantidade=1
    ${res}=              Fazer Requisicao PUT               /produtos/${ID_INEXISTENTE}    ${payload}    ${headers}
    Should Be Equal As Integers                            ${res.status_code}    400


# ╭────────────────────────────────────╮
# │ Testes de Acesso sem Autenticação  │
# ╰────────────────────────────────────╯

CT020 - Acessar produtos sem autenticação
    ${res}=              Fazer Requisicao GET               /produtos
    Run Keyword If       ${res.status_code} == 200
    ...                  Log                                BUG CRÍTICO: acesso sem autenticação!    WARN
    Run Keyword If       ${res.status_code} == 401
    ...                  Log                                OK: acesso negado corretamente
