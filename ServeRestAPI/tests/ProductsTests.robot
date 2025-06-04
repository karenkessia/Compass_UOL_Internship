*** Settings ***
Documentation    Testes para Seção de Produtos 
Resource         ../resources/base.robot
Resource         ../keywords/Products_Keywords.robot


*** Keywords ***

# ╭────────────────────────────╮
# │ Testes de Criação          │
# ╰────────────────────────────╯

TC016 - Criar produto com dados válidos
    [Documentation]    Resultado esperado: Status 201 - Produto criado com sucesso
    ${response}=       TC016 - Criar produto com dados válidos
    Validar Status E Mensagem    ${response}    201    Cadastro realizado com sucesso
    Dictionary Should Contain Key    ${response.json()}    _id
    Log To Console    TC016 - Produto criado - ID: ${response.json()['_id']}

TC017 - Criar produto com nome duplicado
    [Documentation]    Resultado esperado: Status 400 
    ${response}=       TC017 - Criar produto com nome duplicado
    Validar Status E Mensagem    ${response}    400    Já existe produto com esse nome
    Log To Console    TC017 - Criação de produto duplicado rejeitada corretamente


# ╭────────────────────────────╮
# │ Testes de Exclusão         │
# ╰────────────────────────────╯

TC018 - Deletar produto vinculado a carrinho
    [Documentation]    Resultado esperado: Status 400 - Produto vinculado não pode ser excluído
    ${response}=       TC018 - Deletar produto vinculado a carrinho
    Validar Status E Mensagem    ${response}    400    Não é permitido excluir produto que faz parte de carrinho
    Log To Console    TC018 - Sistema protege produto vinculado a carrinho corretamente


# ╭────────────────────────────╮
# │ Testes de Atualização      │
# ╰────────────────────────────╯

TC019 - Atualizar produto com ID inexistente
    [Documentation]    Resultado esperado: Status 400 - Possível inconsistência na documentação
    ${response}=       TC019 - Atualizar produto com ID inexistente
    Should Be Equal As Integers    ${response.status_code}    400
    Log To Console    TC019 - API retorna 400 (contradiz documentação)


# ╭────────────────────────────╮
# │ Testes de Segurança        │
# ╰────────────────────────────╯

TC020 - Acessar produtos sem autenticação
    [Documentation]    Resultado esperado: Status 401 - Token obrigatório
    ${response}=       CT020 - Acessar produtos sem autenticação
    Validar Status E Mensagem    ${response}    401    Token de acesso obrigatório
    Log To Console    TC020 - Segurança ok: acesso negado sem autenticação


*** Keywords ***

Validar Status E Mensagem
    [Arguments]    ${response}    ${status_esperado}    ${mensagem_esperada}
    Should Be Equal As Integers    ${response.status_code}    ${status_esperado}
    Should Contain    ${response.json()['message']}    ${mensagem_esperada}
