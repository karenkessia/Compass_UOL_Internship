*** Settings ***
# ──────────────── CONFIGURAÇÕES ────────────────
Library           RequestsLibrary
Library           Collections
Resource          ./_base.robot


*** Keywords ***
PUT UpdateBooking
    [Arguments]               ${booking_id}

    # ──────────────── AUTENTICAÇÃO ────────────────
    ${status}    ${token}=    Criando sessao e obtendo token

    # ──────────────── DEFINIÇÃO DO PAYLOAD ────────────────
    ${bookingdates}=          Create Dictionary
    ...                       checkin=2018-01-01
    ...                       checkout=2019-01-01

    ${payload}=               Create Dictionary
    ...                       firstname=James
    ...                       lastname=Brown
    ...                       totalprice=111
    ...                       depositpaid=${True}
    ...                       bookingdates=${bookingdates}
    ...                       additionalneeds=Breakfast

    # ──────────────── HEADERS COM TOKEN ────────────────
    ${headers}=               Create Dictionary
    ...                       Content-Type=application/json
    ...                       Accept=application/json
    ...                       Cookie=token=${token}

    # ──────────────── CRIAÇÃO DA SESSÃO E REQUISIÇÃO PUT ────────────────
    Create Session            BookerAPI    ${BASE_URL}
    ${response}=              Put On Session
    ...                       BookerAPI
    ...                       /booking/${booking_id}
    ...                       headers=${headers}
    ...                       json=${payload}

    # ──────────────── VALIDAÇÃO DE STATUS ────────────────
    Should Be Equal As Integers    ${response.status_code}    200
    Log                            ${response.status_code}
