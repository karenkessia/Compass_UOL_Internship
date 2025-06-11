*** Settings ***
Documentation    Sceneries of registering tasks
Library    JSONLibrary
Resource    ../../resources/base.resource
Resource    ../../resources/pages/components/TaskCreatePage.resource

Test Setup    Start Session
Test Teardown    Take Screenshot

*** Test Cases ***
Shall allow registering new task
    ${data}=    Get fixtures    tasks    create
    Clean user from database    ${data}[user][email]
    Insert user into database    ${data}[user]
    Submit login form    ${data}[user]
    User should be logged in    ${data}[user][name]

    Go to task form
    Submit task form    ${data}[task]
    Task should be registered    ${data}[task][name]

Shall not allow registering task with duplicated name
    ${data}    Get fixtures    tasks    duplicate
    Clean user from database    ${data}[user][email]
    Insert user into database    ${data}[user]
    Submit login form    ${data}[user]
    User should be logged in    ${data}[user][name]
    Go to task form
    Submit task form    ${data}[task]
    Go to task form
    Submit task form    ${data}[task]
    Notice should be    Oops! Tarefa duplicada.

Shall not create new task once task limit is reached
    ${data}    Get fixtures    tasks    tags_limit
    Clean user from database    ${data}[user][email]
    Insert user into database    ${data}[user]
    Submit login form    ${data}[user]
    User should be logged in    ${data}[user][name]
    Go to task form
    Submit task form    ${data}[task]
    Notice should be    Oops! Limite de tags atingido.
    