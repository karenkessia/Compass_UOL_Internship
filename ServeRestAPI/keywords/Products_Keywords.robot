# ╭────────────────────────────────────────╮
# │ Testes de Criação de Usuário           │
# ╰────────────────────────────────────────╯

*** Settings ***
Library           Collections
Library           RequestsLibrary
Resource          ../variables/variables.robot
Resource          ../resources/base.robot
Resource          Login_Keywords.robot

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


TC018 - Deletar produto vinculado a carrinho
    ${nome}=             Gerar Nome Produto Unico
    ${headers}=          Criar Headers Com Token            ${TOKEN_ADMIN}
    ${payload}=          Create Dictionary
    ...                  nome=${nome}
    ...                  preco=${preco_produto}
    ...                  descricao=Produto para teste de carrinho
    ...                  quantidade=${quantidade_produto}
    ${res}=              Fazer Requisicao POST              /produtos    ${payload}    ${headers}
    Should Be Equal As Integers                            ${res.status_code}    201
    ${produto_id}=       Set Variable                       ${res.json()['_id']}
    Log                                                     Produto criado - ID: ${produto_id}

    ${lista_produtos}=   Create List
    ${produto}=          Create Dictionary
    ...                  idProduto=${produto_id}
    ...                  quantidade=2
    Append To List       ${lista_produtos}                 ${produto}
    ${payload_carrinho}=    Set Variable    
    ${payload_carrinho}= Create Dictionary                 produtos=${lista_produtos}
    ${carrinho_res}=     Fazer Requisicao POST              /carrinhos    ${payload_carrinho}    ${headers}
    Should Be Equal As Integers                            ${carrinho_res.status_code}    201
    ${carrinho_id}=      Set Variable                       ${carrinho_res.json()['_id']}
    Log                                                     Carrinho criado - ID: ${carrinho_id}

    ${res_delete}=       Fazer Requisicao DELETE            /produtos/${produto_id}    ${headers}
    Should Be Equal As Integers                            ${res_delete.status_code}    400
    Should Contain                                         ${res_delete.json()['message']}    Não é permitido excluir produto que faz parte de carrinho
    Log                                                     Exclusão impedida corretamente

    ${res_check}=        Fazer Requisicao GET               /produtos/${produto_id}    ${headers}
    Should Be Equal As Integers                            ${res_check.status_code}    200
    Should Be Equal                                        ${res_check.json()['_id']}    ${produto_id}
    Log                                                     Produto ainda existe no sistema

    ${res_cleanup}=      Fazer Requisicao DELETE            /carrinhos/concluir-compra    ${headers}
    Should Be Equal As Integers                            ${res_cleanup.status_code}    200

    ${res_final}=        Fazer Requisicao DELETE            /produtos/${produto_id}    ${headers}
    Should Be Equal As Integers                            ${res_final.status_code}    200
    Log                                                     Produto excluído com sucesso


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

TC020 - Acessar produtos sem autenticação
    ${res}=              Fazer Requisicao GET               /produtos
    Run Keyword If       ${res.status_code} == 200
    ...                  Log                                BUG: acesso sem autenticação!    WARN
    Run Keyword If       ${res.status_code} == 401
    ...                  Log                                OK: acesso negado corretamente
