*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Variables ***
${BASE_URL}    https://restful-booker.herokuapp.com
${AUTH_ENDPOINT}    /auth
${CONTENT_TYPE}    application/json

*** Keywords ***
Creating session and obtaining token
    ${headers}=    Create Dictionary    Content-Type=${CONTENT_TYPE}
    ${body}=    Create Dictionary    username=admin    password=password123
    
    Create Session    auth_session    ${BASE_URL}    verify=True
    
    ${response}=    POST On Session    
    ...    auth_session    
    ...    ${AUTH_ENDPOINT}    
    ...    json=${body}    
    ...    headers=${headers}
    
    ${status}=    Convert To String    ${response.status_code}
    ${token}=    Set Variable    ${response.json()}[token]
    
    [Return]    ${status}    ${token}