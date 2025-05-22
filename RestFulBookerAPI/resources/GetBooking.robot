*** Settings ***
# ──────────────── CONFIGURAÇÕES ────────────────
Library           RequestsLibrary
Library           Collections
Resource          ./_base.robot


*** Keywords ***
GET GetBooking
    [Arguments]               ${booking_id}

    # ──────────────── AUTENTICAÇÃO E TOKEN ────────────────
    Criando sessao e obtendo token

    # ──────────────── HEADERS DA REQUISIÇÃO ────────────────
    &{headers}=               Create Dictionary    Accept=application/json

    # ──────────────── ENVIA REQUISIÇÃO GET ────────────────
    ${response}=              GET On Session    BookerAPI    /booking/${booking_id}    headers=${headers}

    # ──────────────── VALIDAÇÃO DE STATUS CODE ────────────────
    IF    ${response.status_code} == 200
        Log To Console        >>> ${response.status_code}
    ELSE
        Log To Console        >>> Falha ao buscar booking. Status: ${response.status_code}
    END
