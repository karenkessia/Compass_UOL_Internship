*** Settings ***
Library           RequestsLibrary
Library           Collections

*** Variables ***
# ──────────────── VARIÁVEIS GLOBAIS ────────────────
${BASE_URL}       https://restful-booker.herokuapp.com/
${USERNAME}       admin
${PASSWORD}       password123


*** Keywords ***
Criando sessao e obtendo token
    # ──────────────── CRIANDO SESSÃO NA API ────────────────
    Create Session                   BookerAPI    ${BASE_URL}

    # ──────────────── DEFININDO BODY DA REQUEST ────────────────
    ${body}=                         Create Dictionary
    ...                              username=${USERNAME}
    ...                              password=${PASSWORD}

    # ──────────────── REALIZANDO AUTENTICAÇÃO ────────────────
    ${response}=                     Post On Session
    ...                              BookerAPI
    ...                              /auth
    ...                              json=${body}

    # ──────────────── VALIDAÇÃO DO STATUS CODE ────────────────
    Should Be Equal As Integers     ${response.status_code}    200

    # ──────────────── VALIDAÇÃO DO TOKEN NO RETORNO ────────────────
    Dictionary Should Contain Key   ${response.json()}    token

    # ──────────────── EXTRAINDO TOKEN E STATUS ────────────────
    ${token}=                        Get From Dictionary    ${response.json()}    token
    ${status}=                       Set Variable           ${response.status_code}

    # ──────────────── RETORNO DO STATUS E TOKEN ────────────────
    RETURN                           ${status}    ${token}

