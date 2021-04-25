***Settings***
Documentation       Ações de Autorização


***Keywords***
Go To Login Page 
    Go To           https://bodytest-web-paula.herokuapp.com/    ##acessa a página que deverá ser acessada

Login With
    [Arguments]     ${email}    ${pass}

    Fill Text       css=input[name=email]            ${email} 
    Fill Text       css=input[placeholder*=senha]    ${pass}
    Click           text=Entrar



