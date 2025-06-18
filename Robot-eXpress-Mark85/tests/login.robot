*** Settings ***
Documentation    Sceneries with user authentication
Library    Collections
Resource    ../resources/base.resource

Test Setup    Start Session
Test Teardown    Take Screenshot

*** Test Cases ***
Shall login with pre-registered user
    ${user}    Create Dictionary    
    ...    name=QaTester
    ...    email=QaTester@gmail.com
    ...    password=123456
    
    Remove user from database    ${user}[email]
    Insert user into database    ${user}
    Submit login form    ${user}
    User should be logged in    ${user}[name]

Shall not login with invalid password
    ${user}    Create Dictionary    
    ...    name=QaTester
    ...    email=QaTester@gmail.com
    ...    password=123456
    
    Remove user from database    ${user}[email]
    Insert user into database    ${user}
    Set To Dictionary    ${user}    password=Invalid_password
    Submit login form    ${user}
    Notice should be    Ocorreu um erro ao fazer login, verifique suas credenciais.

      
    