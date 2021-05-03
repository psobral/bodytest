***Settings***
Documentation       Ações do menu superior de navegação

***Keywords***
## faz parte das ações do menu superior. É Na barra de navegação que vai ter a ação de clicar em Alunos e redirecionar
## para a gestão de alunos
Go To Students
    Click       css=a[href$=alunos]  ##Colocou o "#" termina com  - quando clicar no titulo "alunos" e mostrar gestão de alunos, garate que estou no lugar certo
    Wait For Elements State         css=h1 >> text=Gestão de Alunos       visible         5  
    # Wait For Elements State         xpath=//h1[(text()="Gestão de Alunos")]       visible         5 
    ## clicou e foi para a subpágina "gestão de alunos"
    ## CheckPoint -> Vai garantir que estou na pagina certa para cadastrar um novo aluno 

Go To Plans
    Click       css=a[href$=planos]  
    Wait For Elements State         css=h1 >> text=Gestão de Planos       visible         5  

Go To Enrolls
    Click       css=a[href$=matriculas]  ## Foi colocado o $ para pegar a palavra que termina com  matricula, 
    Wait For Elements State         css=h1 >> text=Gestão de Matrículas       visible         5  


##valida se estou logado , a validação é feita através do nome que esta logado
##por isso será criada uma variável
User Should Be Logged In
    [Arguments]     ${user_name}

    Get Text        css=aside strong    should be       ${user_name}       ##Administrador - nome do usuário logado 
                                                                            ##aside - Menu lateral de navegação 
