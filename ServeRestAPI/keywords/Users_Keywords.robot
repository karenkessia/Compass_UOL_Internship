*** Settings ***
Library           Collections
Library           RequestsLibrary
Resource          ../variables/variables.robot
Resource          ../resources/base.robot

*** Keywords ***

# ╭──────────────────────────────╮
# │ Testes de Criação de Usuário │
# ╰──────────────────────────────╯

TC001 - Criar usuário com dados válidos
    [Documentation]                TC001 - Cria usuário com dados válidos
    ${payload}=                    Create Dictionary
    ...                            nome=${nome_do_usuario}
    ...                            email=${email_do_usuario}
    ...                            password=${senha_do_usuario}
    ...                            administrador=true
    ${response}=                   Fazer Requisicao POST               /usuarios    ${payload}
    Should Be Equal As Integers   ${response.status_code}             201
    Dictionary Should Contain Key ${response.json()}                  _id
    Set Suite Variable            ${USUARIO_ID}                       ${response.json()['_id']}
    RETURN                        ${response}

TC002 - Criar usuário com domínio de e-mail inválido
    [Documentation]                TC002 - Cria usuário com email inválido
    ${payload}=                    Create Dictionary
    ...                            nome=TesteX
    ...                            email=${email_gmail}
    ...                            password=${senha_do_usuario}
    ...                            administrador=true
    ${response}=                   Fazer Requisicao POST               /usuarios    ${payload}
    Log                            ISSUE: API aceita domínio de email inválido
    Should Be Equal As Integers   ${response.status_code}             201
    RETURN                        ${response}

TC003 - Criar usuário com e-mail duplicado
    [Documentation]                TC003 - Cria usuário com email duplicado
    ${email}=                      Gerar Email Unico
    ${payload1}=                   Create Dictionary
    ...                            nome=Userone
    ...                            email=${email}
    ...                            password=${senha_do_usuario}
    ...                            administrador=true
    Fazer Requisicao POST         /usuarios                           ${payload1}

    ${payload2}=                   Create Dictionary
    ...                            nome=Segundo Usuario
    ...                            email=${email}
    ...                            password=${senha_do_usuario}
    ...                            administrador=false
    ${response}=                   Fazer Requisicao POST               /usuarios    ${payload2}
    Should Be Equal As Integers   ${response.status_code}             400
    Should Contain                ${response.json()['message']}       Este email já está sendo usado
    RETURN                        ${response}


# ╭──────────────────────────────╮
# │ Testes de Atualização        │
# ╰──────────────────────────────╯

TC004 - Atualizar usuário com ID inexistente
    [Documentation]                TC004 - Tenta atualizar usuário com ID inexistente
    ${email}=                      Gerar Email Unico
    ${payload}=                    Create Dictionary
    ...                            nome=Usuario inexistente
    ...                            email=${email}
    ...                            password=${senha_do_usuario}
    ...                            administrador=false
    ${response}=                   Fazer Requisicao PUT                /usuarios/${ID_INEXISTENTE}    ${payload}
    Log                            ISSUE: API retorna 200 em vez de 404
    Should Be Equal As Integers   ${response.status_code}             200
    RETURN                        ${response}


# ╭────────────────────────────╮
# │ Testes de Consulta         │
# ╰────────────────────────────╯

TC005 - Consultar usuário inexistente
    [Documentation]                TC005 - Consulta usuário com ID inválido
    ${response}=                   Fazer Requisicao GET                /usuarios/${ID_INEXISTENTE}
    Should Be Equal As Integers   ${response.status_code}             400
    RETURN                        ${response}
