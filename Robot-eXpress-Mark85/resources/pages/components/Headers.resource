*** Settings ***
Documentation    Actions and elements of header

Library    Browser        

*** Keywords ***

User should be logged in
    [Arguments]    ${name}
    ${element}=    Set Variable    header .right small

    Wait For Elements State    css=${element}
    ...    visible    5
    
    Get Text    css=${element}    equal    Olá, ${name}

Go to task form
    Click    css=.button-add