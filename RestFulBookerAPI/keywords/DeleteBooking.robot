*** Settings ***
# ──────────────── CONFIGURAÇÕES ────────────────
Library           RequestsLibrary
Library           Collections
Resource          ./_base.robot
Resource    CreateBooking.robot


*** Keywords ***
DEL DeleteBooking
    [Arguments]                ${booking_id}

    # ──────────────── AUTENTICAÇÃO E TOKEN ────────────────
    ${status}    ${token}=     Criando sessao e obtendo token

    # ──────────────── HEADERS COM TOKEN ────────────────
    ${headers}=                Create Dictionary
    ...                        Content-Type=application/json
    ...                        Accept=application/json
    ...                        Cookie=token=${token}

    # ──────────────── CRIA SESSÃO PARA A API ────────────────
    Create Session             BookerAPI    ${BASE_URL}

    # ──────────────── ENVIA REQUISIÇÃO PATCH ────────────────
    ${response}=               Patch On Session
    ...                        BookerAPI
    ...                        /booking/${booking_id}
    ...                        headers=${headers}

    # ──────────────── VALIDAÇÃO DO STATUS CODE ────────────────
    Should Be Equal As Integers    ${response.status_code}    200

    # ──────────────── LOG DE STATUS ────────────────
    Log                         ${response.status_code}
