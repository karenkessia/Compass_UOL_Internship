*** Settings ***
Library           RequestsLibrary
Library           Collections
Resource     ../../keywords/_base.robot
Resource    ../../keywords/CreateBooking.robot

*** Keywords ***
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
    ...                 expected_status=any

    # ──────────────── VALIDAÇÃO DO STATUS ────────────────
    IF    ${response.status_code} == 200
        Log To Console    >>> Booking created successfully with status code: ${response.status_code}
        ${booking_id}=      Get From Dictionary    ${response.json()}    bookingid
        RETURN              ${booking_id}
    ELSE
        Log To Console    >>> Failed to create booking. Status code: ${response.status_code}
        RETURN              ${NONE}
    END

Post Invalid Booking Without Required Fields
    # ──────────────── DADOS DO BOOKING INVÁLIDO ────────────────
    ${payload}=         Create Dictionary
    ...                 firstname=Jim
    ...                 totalprice=110
    # Missing lastname, bookingdates, and depositpaid

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
    ...                 expected_status=any

    # ──────────────── VALIDAÇÃO DO STATUS ────────────────
    Should Be Equal As Numbers    ${response.status_code}    400
    Log To Console    >>> Expected failure - Missing required fields. Status code: ${response.status_code}

Post Booking With Invalid Dates
    # ──────────────── DADOS DO BOOKING INVÁLIDO ────────────────
    ${bookingdates}=    Create Dictionary
    ...                 checkin=2024-01-01
    ...                 checkout=2023-01-01    # Checkout before checkin

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
    ...                 expected_status=any

    # ──────────────── VALIDAÇÃO DO STATUS ────────────────
    Should Be Equal As Numbers    ${response.status_code}    400
    Log To Console    >>> Expected failure - Invalid dates. Status code: ${response.status_code}