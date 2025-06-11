*** Settings ***
Documentation    Actions and elements of login ${PREV_TEST_MESSAGE}

Library    Browser

*** Keywords ***
Submit login form
    [Arguments]    ${user}
    Fill Text    css=input[placeholder="E-mail"]    ${user}[email]
    Fill Text    css=input[placeholder="Senha"]    ${user}[password]
    
    Click    css=button >> text=Entrar