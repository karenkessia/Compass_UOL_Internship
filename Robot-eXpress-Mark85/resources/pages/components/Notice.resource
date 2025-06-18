*** Settings ***
Documentation    Actions and elements of notification field
Library    Browser

*** Keywords ***
Notice should be
    [Arguments]    ${expected_text}
    ${element}    Set Variable    css=.notice p
    
    Wait For Elements State    ${element}    visible
    Get Text    ${element}    equal    ${expected_text}