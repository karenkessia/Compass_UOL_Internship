*** Settings ***
Library           RequestsLibrary
Library           Collections
Resource    _base.robot

*** Keywords ***
    Criando sessao e obtendo token
    

    Post CreateBooking
    # ──────────────── AUTENTICAÇÃO ────────────────
Criando sessao e obtendo token

    # ──────────────── DADOS DO BOOKING ────────────────
    ${bookingdates}=    Create Dictionary
    ...                 checkin=2018-01-01
    ...                 checkout=2019-01-01

    ${payload}=         Create Dictionary
    ...                 firstname=Jim
    ...                 lastname=Brown
    ...                 totalprice=110
    ...                 depositpaid=${True}
    ...                 bookingdates=${bookingdates}
    ...                 additionalneeds=Breakfast

    # ──────────────── HEADERS ────────────────
    ${headers}=         Create Dictionary
    ...                 Content-Type=application/json
    ...                 Accept=application/json

    # ──────────────── ENVIO DA REQUISIÇÃO ────────────────
    ${response}=        Post On Session
    ...                 BookerAPI
    ...                 /booking
    ...                 headers=${headers}
    ...                 json=${payload}

    # ──────────────── VALIDAÇÃO DO STATUS ────────────────
    IF    ${response.status_code} == 200
        Log To Console    >>> ${response.status_code}
    ELSE
        Log To Console    >>> Falha ao criar booking.
    END

    # ──────────────── RETORNO DO ID ────────────────
    ${booking_id}=      Get From Dictionary    ${response.json()}    bookingid
    RETURN              ${booking_id}

