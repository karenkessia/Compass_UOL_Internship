*** Settings ***
Documentation     Keywords for creating bookings
Resource         _base.robot

*** Keywords ***
Create New Booking
    [Documentation]    Creates a new booking with the given details
    [Arguments]    ${firstname}    ${lastname}    ${totalprice}    ${depositpaid}    ${checkin}    ${checkout}    ${additionalneeds}
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
    
    ${response}=    POST On Session    
    ...    BookerAPI    
    ...    /booking    
    ...    json=${body}
    
    Should Be Equal As Numbers    ${response.status_code}    200
    [Return]    ${response.json()}

Verify Booking Creation
    [Documentation]    Verifies that a booking was created successfully
    [Arguments]    ${booking_response}
    Should Not Be Empty    ${booking_response}[bookingid]
    Dictionary Should Contain Key    ${booking_response}    booking
    Dictionary Should Contain Key    ${booking_response}[booking]    firstname
    Dictionary Should Contain Key    ${booking_response}[booking]    lastname