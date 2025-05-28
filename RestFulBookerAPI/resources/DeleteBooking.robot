*** Settings ***
Documentation     Keywords for deleting bookings
Resource         _base.robot

*** Keywords ***
Delete Booking
    [Documentation]    Deletes a booking by its ID
    [Arguments]    ${booking_id}
    ${token}=    Get Auth Token
    
    ${headers}=    Create Dictionary    
    ...    Content-Type=application/json    
    ...    Cookie=token=${token}
    
    ${response}=    DELETE On Session    
    ...    BookerAPI    
    ...    /booking/${booking_id}    
    ...    headers=${headers}    
    ...    expected_status=any
    
    Run Keyword If    ${response.status_code} == 403    
    ...    Fail    Authentication failed. Please check your token.
    
    Should Be Equal As Numbers    ${response.status_code}    201

Verify Booking Deletion
    [Documentation]    Verifies that the booking was deleted
    [Arguments]    ${booking_id}
    ${response}=    GET On Session    
    ...    BookerAPI    
    ...    /booking/${booking_id}    
    ...    expected_status=404
    
    Should Be Equal As Numbers    ${response.status_code}    404