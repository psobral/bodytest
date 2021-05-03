import psycopg2
from logging import info ## importar somente info do "remove_student" do modulo de logging 

class DeloreanLibrary():

    def connect(self):
         return psycopg2.connect(
            host='ec2-18-204-101-137.compute-1.amazonaws.com',
            database='dd2pte6s7392mb',
            user='ceqqfducsqebut',
            password='c5b84b488329bc3d2cd3129b5d13b82162733feb1ef574c06e9a414364f2093c'
        )

## Gestão de Alunos 
    # No Robot vira uma Keyword automáticamente => Remove Student  email@desejado.com
    def remove_student(self, email):

        query = "delete from students where email = '{}'".format(email)
        info(query)  # logar a query

        conn = self.connect()
           
        cur = conn.cursor()
        cur.execute(query)
        conn.commit()
        conn.close()

        ## conecta no banco e remove o email que desejar 

    def remove_student_by_name(self, name):

        query = "delete from students where name LIKE '%{}%'".format(name)
        info(query)  # logar a query

#Like  - consegue remover um texto especifico em qualquer tabela, independente do que vem antes ou depois
        conn = self.connect()
           
        cur = conn.cursor()
        cur.execute(query)
        conn.commit()
        conn.close()


    def insert_student(self, student):

        self.remove_student(student['email'])

        query = ("insert into students (name, email, age, weight, feet_tall, created_at, updated_at)"
                "values('{}','{}',{},{},{}, NOW(), NOW());"    
                .format(student['name'],student['email'],student['age'],student['weight'],student['feet_tall']))

        info(query)  # logar a query

        conn = self.connect()

        cur = conn.cursor()
        cur.execute(query)
        conn.commit()
        conn.close()

## Gestão de Planos 
    # def remove_plan(self, title):

    #     query = "delete from plans where title = '{}'".format(title)
    #     info(query)  # logar a query

    #     conn = self.connect()
           
    #     cur = conn.cursor()
    #     cur.execute(query)
    #     conn.commit()
    #     conn.close()

    def remove_plan(self, title):

        query = "delete from plans where title LIKE '%{}%'".format(title)
        info(query)  # logar a query

#Like  - consegue remover um texto especifico em qualquer tabela, independente do que vem antes ou depois
        conn = self.connect()
           
        cur = conn.cursor()
        cur.execute(query)
        conn.commit()
        conn.close()

    
    def insert_plan(self, plan):

        self.remove_plan(plan['title'])

        query = ("insert into plans (title, duration, price, created_at, updated_at)"
                "values('{}','{}',{}, NOW(), NOW());"    
                .format(plan['title'],plan['duration'],plan['price']))

        info(query)  # logar a query

        conn = self.connect()

        cur = conn.cursor()
        cur.execute(query)
        conn.commit()
        conn.close()