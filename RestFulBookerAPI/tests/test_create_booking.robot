*** Settings ***
Resource    ../resources/CreateBooking.robot
Resource    test_base.robot

*** Variables ***
${variable}    Booking
${variable}    variable

*** Test Cases ***
Create New Booking With Valid Data
    [Documentation]    Test creating a new booking with valid data
    ${variable}=    Create New ${variable}
    Validate Response Status Code    ${CREATED_STATUS_CODE}
    Response Should Contain Booking ID

Create Booking With Missing Required Fields
    [Documentation]    Test creating a booking with missing required fields
    ${${variable}}=    Create Booking Without Required Fields
    Validate Response Status Code    400

Create Booking With Invalid Date Format
    [Documentation]    Test creating a booking with invalid date format
    ${variable}=    Create Booking With Invalid Dates
    Validate Response Status Code    400

*** Keywords ***
Response Should Contain Booking ID
    ${response}=    Set Variable    
    Dictionary Should Contain Key    ${response.json()}    bookingid

Create Booking Without Required Fields
    

Create Booking With Invalid Dates
    

