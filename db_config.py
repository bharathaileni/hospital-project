import mysql.connector

def get_connection():
    return mysql.connector.connect(
        host="localhost",      
        user="root",           
        password="Bharath@8688",  
        database="hospital_db"
    )
