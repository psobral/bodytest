***Settings***
Documentation       Suite de Consulta de planos

Resource    ${EXECDIR}/resources/actions/base.robot

# criar uma sessão do navegador uma única vez / realiza os testes em uma única sessão
Suite Setup     Start Admin Session  # cria a sessão do navegador e faz o login como administrador 
                # keyword base.robot
                # pré-condição para Login 

#Screenchot para todos os testes, tirar o print sempre no final de todos os cenário de testes dessa suite
Test Teardown   Take Screenshot


***Test Cases***
Cenário: Consultar Plano cadastrado

    &{plan}     Create Dictionary       title=Plano Diario      duration=1     price=19.99     total=R$ 19,99

    Remove Plan                 ${plan.title}
    Insert Plan                 ${plan}
    Go To Plans
    Search Plan By Title        ${plan.title}
    Plan Should Be Visible      ${plan.title}
    Total Items Should Be       1


Cenário: Registro não encontrado
    [tags]          search
    ${title}        Set Variable        Plano zero

    Remove Plan             ${title} 
    Go To Plans
    Search Plan By Title    ${title}   
    Register Should Not Be found 

    
