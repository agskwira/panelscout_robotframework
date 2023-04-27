*** Settings ***
Library  SeleniumLibrary
Documentation    Suite description #automated tests for scout website


*** Variables ***
${LOGIN URL}        https://scouts-test.futbolkolektyw.pl/en
${BROWSER}      Chrome
${SIGNINBUTTON}     //*[@id='__next']/form/div/div[2]/button
${EMAILINPUT}       //*[@id='login']
${PASSWORDINPUT}        //*[@id='__next']/form/div/div[1]/div[2]/div[1]//input
${PAGELOGO}     //*[text()='Scouts Panel']
${ALERTMESSAGE}     //*[text()='Identifier or password invalid.']
${REMINDPASSWORD}    //*[@id='__next']/form/div/div[1]/a
${NAME}     //*[@name='name']
${SURNAME}      //*[@name='surname']
${ADDPLAYER}        //*[text()='Add player']
${SEND}     //*[text()='Send']


*** Test Cases ***
Login to the system
    Open login page
    Type in email
    Type in password
    Click on the Submit button
    Assert dashboard
    [Teardown]    Close Browser
TC001
    Open login page
    Type in email
    Type in password
    Click on the Submit button
    Assert dashboard
    [Teardown]    Close Browser
TC002
    Open login page
    Type in incorrect email
    Type in password
    Click on the Submit button
    Get alert message
    [Teardown]    Close Browser
TC003
    Open login page
    Type in email
    Type in incorrect password
    Click on the Submit button
    Get alert message
    [Teardown]    Close Browser
TC004
    Open login page
    Type in email
    Type in password
    Click on the remind password hyperlink
    Assert remind password page
    [Teardown]    Close Browser
TC005
    Open login page
    Type in email
    Type in password
    Click on the Submit button
    Click on the Add player
    Type in name
    Type in surname
    [Teardown]    Close Browser


*** Keywords ***
Open login page
    Open Browser    ${LOGIN URL}    ${BROWSER}
    Title Should Be     Scouts panel - sign in
Type in email
    Input Text   ${EMAILINPUT}   user07@getnada.com
Type in incorrect email
    Input Text   ${EMAILINPUT}   er07@getnada.com
Type in name
    wait until element is visible    ${NAME}
    Input Text    ${NAME}   AGNIESZKA
Type in surname
    Input Text    ${SURNAME}    SKWIRA
Get alert message
    wait until element is visible    ${ALERTMESSAGE}
    Element Text Should Be  ${ALERTMESSAGE}       Identifier or password invalid.
Type in password
    Input Text  ${PASSWORDINPUT}    Test-1234
Type in incorrect password
    Input Text  ${PASSWORDINPUT}    Test-12
Click on the Submit button
    Click Element   ${SIGNINBUTTON}
Click on the Add player
    wait until element is visible   ${ADDPLAYER}
    Click Element    ${ADDPLAYER}
Click on the remind password hyperlink
    Click Element   ${REMINDPASSWORD}
    wait until element is visible   ${SEND}
Assert dashboard
    wait until element is visible  ${PAGELOGO}
    Title Should Be     Scouts panel - sign in
Assert remind password page
    Title Should Be     Remind password
Provided precondition
    Setup system under test

