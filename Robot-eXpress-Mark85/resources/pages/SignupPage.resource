*** Settings ***
Documentation    Elements and actions of cadastre ${PREV_TEST_MESSAGE}

Library    Browser
Resource    ../env.resource

*** Keywords ***
Go to signup Page
    Go To    ${BASE_URL}/signup
    # Checkpoint
    Wait For Elements State    css=h1    visible    5
    Get Text    css=h1    equal    Faça seu cadastro

Submit signup from
    [Arguments]    ${user}
    Fill Text    id=name     ${user}[name]
    Fill Text    id=email     ${user}[email]
    Fill Text    id=password     ${user}[password]

    Click    id=buttonSignup