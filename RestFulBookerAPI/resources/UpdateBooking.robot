*** Settings ***
Documentation     Keywords for updating bookings
Resource         _base.robot

*** Keywords ***
Update Booking
    [Documentation]    Updates an existing booking
    [Arguments]    ${booking_id}    ${firstname}    ${lastname}    ${totalprice}    ${depositpaid}    ${checkin}    ${checkout}    ${additionalneeds}
    ${token}=    Get Auth Token
    
    ${booking_dates}=    Create Dictionary    
    ...    checkin=${checkin}    
    ...    checkout=${checkout}
    
    ${body}=    Create Dictionary
    ...    firstname=${firstname}
    ...    lastname=${lastname}
    ...    totalprice=${totalprice}
    ...    depositpaid=${depositpaid}
    ...    bookingdates=${booking_dates}
    ...    additionalneeds=${additionalneeds}
    
    ${headers}=    Create Dictionary    
    ...    Content-Type=application/json    
    ...    Accept=application/json    
    ...    Cookie=token=${token}
    
    ${response}=    PUT On Session    
    ...    BookerAPI    
    ...    /booking/${booking_id}    
    ...    json=${body}    
    ...    headers=${headers}    
    ...    expected_status=any
    
    Run Keyword If    ${response.status_code} == 403    
    ...    Fail    Authentication failed. Please check your token.
    
    Should Be Equal As Numbers    ${response.status_code}    200
    [Return]    ${response.json()}

Verify Booking Update
    [Documentation]    Verifies that the booking was updated correctly
    [Arguments]    ${original_booking}    ${updated_booking}
    Should Not Be Equal    ${original_booking}    ${updated_booking}
    Dictionary Should Contain Key    ${updated_booking}    firstname
    Dictionary Should Contain Key    ${updated_booking}    lastname