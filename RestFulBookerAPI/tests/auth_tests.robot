*** Settings ***
Resource    ../resources/Auth.robot
Resource    ../resources/_base.robot
Resource    ../keywords/_base.robot
Resource    ../keywords/Auth.robot

*** Test Cases ***
Validate Successful Authentication
    ${status}    ${token}=    Creating session and obtaining token
    Should Be Equal As Strings    ${status}    200
    Should Not Be Equal    ${token}    null
    Should Not Be Empty    ${token}
    
    ${valid_format}=    Validate Token Format    ${token}
    Should Be True    ${valid_format}

Validate Token Printing
    Printing token return
    Variable Should Exist    ${SECURE_TOKEN}
    Should Not Be Empty    ${SECURE_TOKEN}

Validate Status Printing
    Printing status return