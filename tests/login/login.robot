***Settings***
Documentation       Suite de Testes de Login do Administrador

Resource    ${EXECDIR}/resources/actions/base.robot

##criar uma sessão do navegador uma única vez / realiza os testes em uma única sessão
Suite Setup     Start Browser Session

#Screenchot para todos os testes, tirar o print sempre no final de todos os cenário de testes dessa suite
Test Teardown   Take Screenshot

***Test Cases***
Cenário: Login do Administrador
    [tags]          admin
    Go To Login Page 
    Login With                  admin@bodytest.com  pwd123
    User Should Be Logged In    Administrador
 
    ##LocalStorage Clear  ##Limpa o local Storage do navegador, ou seja, limpa a sessão do navegador,   
                        ## remove todas as chaves existentes do usuário logado. 
    [Teardown]      Clear Local Storage and Take Screenshot     ##TEARDOWN ESPECIAL foi criado esse keyword pois o test case já tinha um teardown de localstorage clear, e não estava tirando o print (take sreenshot)            

Cenário: Senha Incorreta
    [tags]          temp
    Go To Login Page 
    Login With              admin@bodytest.com  abc123
 
    ##Tem até 5 seg para verificar a existencia do elemento
    # Wait For Elements State     css=.Toastify__toast-body   visible     5
    # ##<div role="alert" class="Toastify__toast-body">Usuário ou senha inválido</div>
    # Get Text                    css=.Toastify__toast-body   should be    Usuário ou senha inválido
    Toaster Text Should Be  Usuário e/ou senha inválidos.      
    [Teardown]      Thinking And Take Screenshot        2 
    # simular a execução do teste congele por 2 seg para que o efeito da animação aconteça 
    # e consiga tirar o print exatamente no momento que o quadradinho é exibido na tela 
    # devido a animação visual (toaster) demorar muito para exibir na tela

Cenário: E-mail não cadastrado
    [tags]          temp
    Go To Login Page 
    Login With              paula@gmail.com  abc123
    Toaster Text Should Be  Usuário e/ou senha inválidos.
    [Teardown]      Thinking And Take Screenshot        2 

Cenário: Email Incorreto
    [tags]          temp
    Go To Login Page 
    Login With              admin&bodytest.com  pwd123
    Alert Text Should Be    Informe um e-mail válido     

Cenário: Senha não informada 
    [tags]          temp
    Go To Login Page 
    Login With              admin@bodytest.com  ${EMPTY}
    Alert Text Should Be    A senha é obrigatória     

Cenário: Email não informado
    [tags]          temp
    Go To Login Page 
    Login With              ${EMPTY}  pwd123
    Alert Text Should Be    O e-mail é obrigatório     

Cenário: Email e Senha não informados
    [tags]          temp
    Go To Login Page 
    Login With              ${EMPTY}  ${EMPTY}
    Alert Text Should Be    O e-mail é obrigatório
    Alert Text Should Be    A senha é obrigatória