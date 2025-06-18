*** Settings ***
Library    libs/database.py
Library    Browser
Resource    env.resource
Resource    pages/SignupPage.resource
Resource    pages/loginPage.resource
Resource    pages/components/Notice.resource
Resource    pages/components/Headers.resource
Resource    pages/components/AlertsResource.resource
Resource    pages/components/TaskCreatePage.resource
Resource    pages/TasksPage.resource
Resource    pages/services.resource
Library    JSONLibrary
*** Keywords ***
Start Session
    New Browser    browser=chromium    headless=False
    New Page    ${BASE_URL}

Get fixtures
    [Arguments]    ${file_name}    ${scenario}
    ${data}=    Load Json From File    
    ...    ${EXECDIR}/resources/fixtures/${file_name}.Json
    ...    encoding=utf-8
    
    [RETURN]    ${data}[${scenario}]