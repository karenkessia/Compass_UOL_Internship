*** Settings ***
Documentation     Base resource file with common settings and variables
Library          RequestsLibrary
Library          Collections

*** Variables ***
${BASE_URL}      https://restful-booker.herokuapp.com
${USERNAME}      admin
${PASSWORD}      password123
${HEADERS}       Create Dictionary    Content-Type=application/json    Accept=application/json

*** Keywords ***
Create Session With Base URL
    [Documentation]    Creates a new session with the base URL
    Create Session    BookerAPI    ${BASE_URL}    verify=True    headers=${HEADERS}

Get Auth Token
    [Documentation]    Gets authentication token from the API
    ${body}=    Create Dictionary    username=${USERNAME}    password=${PASSWORD}
    ${response}=    POST On Session    
    ...    BookerAPI    
    ...    /auth    
    ...    json=${body}
    Should Be Equal As Numbers    ${response.status_code}    200
    [Return]    ${response.json()}[token]