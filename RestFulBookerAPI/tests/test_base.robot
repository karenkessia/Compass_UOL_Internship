*** Settings ***
Resource    ../resources/_base.robot

*** Variables ***
${VALID_STATUS_CODE}    200
${CREATED_STATUS_CODE}    201

*** Keywords ***
Validate Response Status Code
    [Arguments]    ${expected_status_code}
    ${response}=    Set Variable    
    Should Be Equal As Numbers    ${response.status_code}    ${expected_status_code}