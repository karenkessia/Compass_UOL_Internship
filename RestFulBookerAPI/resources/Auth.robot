*** Settings ***
Library           RequestsLibrary
Library           Collections
Resource          ./_base.robot

*** Keywords ***
Printando retorno do token
    # ──────────────── OBTENDO STATUS E TOKEN ────────────────
    ${status}    ${token}=    Criando sessao e obtendo token

    # ──────────────── VALIDAÇÃO DO TOKEN ────────────────
    IF    "${token}" != "null"
        Log To Console    >>> ${token}
    ELSE
        Log To Console    >>> Falha no login.
    END


Printando retorno do status
    # ──────────────── OBTENDO STATUS E TOKEN ────────────────
    ${status}    ${token}=    Criando sessao e obtendo token

    # ──────────────── VALIDAÇÃO DO STATUS ────────────────
    IF    ${status} == 200
        Log To Console    >>> ${status}
    ELSE
        Log To Console    >>> Falha no login.
    END
