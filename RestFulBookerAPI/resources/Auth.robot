*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    String
Resource    ./_base.robot

*** Keywords ***
Printing token return
    # ──────────────── GETTING STATUS AND TOKEN ────────────────
    ${status}    ${token}=    Creating session and obtaining token
    
    # ──────────────── TOKEN VALIDATION AND SECURE HANDLING ────────────────
    IF    "${token}" != "null" and "${token}" != ""
        ${masked_token}=    Get Substring    ${token}    0    8
        Set Suite Variable    ${SECURE_TOKEN}    ${token}    # Store securely for suite usage
        Log To Console    >>> Token received successfully (starts with: ${masked_token}...)
        Log To Console    >>> Token length: ${token.__len__()}
    ELSE
        Log To Console    >>> Login failed: No valid token received
        Fail    Authentication failed - no valid token received
    END

Printing status return
    # ──────────────── GETTING STATUS AND TOKEN ────────────────
    ${status}    ${token}=    Creating session and obtaining token
    
    # ──────────────── ENHANCED STATUS VALIDATION ────────────────
    ${is_success}=    Evaluate    200 <= ${status} < 300
    IF    ${is_success}
        Log To Console    >>> Authentication successful (Status: ${status})
    ELSE IF    ${status} == 401
        Log To Console    >>> Authentication failed: Invalid credentials (Status: ${status})
        Fail    Authentication failed - invalid credentials
    ELSE IF    ${status} == 403
        Log To Console    >>> Authentication failed: Access forbidden (Status: ${status})
        Fail    Authentication failed - access forbidden
    ELSE
        Log To Console    >>> Authentication failed: Unexpected error (Status: ${status})
        Fail    Authentication failed - unexpected error
    END

Validate Token Format
    [Arguments]    ${token}
    ${valid}=    Run Keyword And Return Status    
    ...    Should Match Regexp    ${token}    ^[a-zA-Z0-9_-]+$
    [Return]    ${valid}