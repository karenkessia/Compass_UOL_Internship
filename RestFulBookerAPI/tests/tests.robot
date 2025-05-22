*** Settings ***
# ──────────────── CONFIGURAÇÕES ────────────────
Library           RequestsLibrary
Library           Collections

Resource          ../resources/Auth.robot
Resource          ../resources/CreateBooking.robot
Resource          ../resources/GetBooking.robot
Resource          ../resources/UpdateBooking.robot
Resource          ../resources/DeleteBooking.robot


*** Test Cases ***
# ──────────────── AUTENTICAÇÃO ────────────────
Autenticação com sucesso
    Printando retorno do status
    Log To Console    >>> Token de acesso gerado com sucesso.
    Printando retorno do token


# ──────────────── CRIAÇÃO DE BOOKING ────────────────
Criar novo booking
    ${booking_id}=    POST CreateBooking
    Log To Console    >>> Booking criado com ID: ${booking_id}


# ──────────────── CONSULTA DE BOOKING ────────────────
Buscar booking existente
    ${booking_id}=    POST CreateBooking
    GET GetBooking    ${booking_id}


# ──────────────── ATUALIZAÇÃO DE BOOKING ────────────────
Atualizar booking existente
    ${booking_id}=    POST CreateBooking
    PUT UpdateBooking    ${booking_id}


# ──────────────── REMOÇÃO DE BOOKING ────────────────
Deletar booking existente
    ${booking_id}=    POST CreateBooking
    DEL DeleteBooking    ${booking_id}
