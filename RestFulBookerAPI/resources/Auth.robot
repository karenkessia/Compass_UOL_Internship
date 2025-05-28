*** Settings ***
Documentation     Keywords for authentication operations
Resource         _base.robot

*** Keywords ***
Authenticate User
    [Documentation]    Authenticates user and returns token
    Create Session With Base URL
    ${token}=    Get Auth Token
    Set Test Variable    ${TOKEN}    ${token}
    [Return]    ${token}

Verify Authentication Success
    [Documentation]    Verifies that authentication was successful
    ${token}=    Authenticate User
    Should Not Be Empty    ${token}
    Log    Authentication successful with token: ${token}