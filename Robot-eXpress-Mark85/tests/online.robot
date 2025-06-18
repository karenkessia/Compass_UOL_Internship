*** Settings ***
Documentation    Veryfing If website is online
Resource    ../resources/base.resource
Library    Process

*** Test Cases ***
Verifying If site is online    
    Start Session    
    Get Title    equal    Mark85 by QAx
    
   