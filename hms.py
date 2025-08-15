from db_config import get_connection

def add_patient():
    name = input("Enter patient name: ")
    dob = input("Enter DOB (YYYY-MM-DD): ")
    gender = input("Enter gender (Male/Female/Other): ")
    phone = input("Enter phone: ")
    email = input("Enter email: ")
    address = input("Enter address: ")
    
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute(
        "INSERT INTO patients (name, dob, gender, phone, email, address) VALUES (%s,%s,%s,%s,%s,%s)",
        (name, dob, gender, phone, email, address)
    )
    conn.commit()
    print("✅ Patient added successfully!")
    conn.close()

def view_patients():
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM patients")
    for row in cursor.fetchall():
        print(row)
    conn.close()

def add_doctor():
    name = input("Enter doctor name: ")
    specialization = input("Enter specialization: ")
    phone = input("Enter phone: ")
    email = input("Enter email: ")
    
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute(
        "INSERT INTO doctors (name, specialization, phone, email) VALUES (%s,%s,%s,%s)",
        (name, specialization, phone, email)
    )
    conn.commit()
    print("✅ Doctor added successfully!")
    conn.close()

def view_doctors():
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM doctors")
    for row in cursor.fetchall():
        print(row)
    conn.close()

def schedule_appointment():
    patient_id = input("Enter patient ID: ")
    doctor_id = input("Enter doctor ID: ")
    appointment_datetime = input("Enter appointment datetime (YYYY-MM-DD HH:MM:SS): ")
    reason = input("Enter reason: ")
    
    conn = get_connection()
    cursor = conn.cursor()
    try:
        cursor.execute(
            "INSERT INTO appointments (patient_id, doctor_id, appointment_datetime, reason) VALUES (%s,%s,%s,%s)",
            (patient_id, doctor_id, appointment_datetime, reason)
        )
        conn.commit()
        print("✅ Appointment scheduled successfully!")
    except mysql.connector.Error as e:
        print("❌ Error:", e)
    conn.close()

def view_appointments():
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM appointments")
    for row in cursor.fetchall():
        print(row)
    conn.close()

def create_bill():
    patient_id = input("Enter patient ID: ")
    appointment_id = input("Enter appointment ID: ")
    total_amount = float(input("Enter total amount: "))
    payment_method = input("Enter payment method (Cash/Card/Insurance/Other): ")
    
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute(
        "INSERT INTO bills (patient_id, appointment_id, total_amount, payment_method) VALUES (%s,%s,%s,%s)",
        (patient_id, appointment_id, total_amount, payment_method)
    )
    conn.commit()
    print("✅ Bill created successfully!")
    conn.close()

def view_bills():
    conn = get_connection()
    cursor = conn.cursor()
    cursor.execute("SELECT * FROM bills")
    for row in cursor.fetchall():
        print(row)
    conn.close()


def main_menu():
    while True:
        print("\n===== Hospital Management System =====")
        print("1. Add Patient")
        print("2. View Patients")
        print("3. Add Doctor")
        print("4. View Doctors")
        print("5. Schedule Appointment")
        print("6. View Appointments")
        print("7. Create Bill")
        print("8. View Bills")
        print("9. Exit")
        
        choice = input("Enter choice: ")
        
        if choice == "1":
            add_patient()
        elif choice == "2":
            view_patients()
        elif choice == "3":
            add_doctor()
        elif choice == "4":
            view_doctors()
        elif choice == "5":
            schedule_appointment()
        elif choice == "6":
            view_appointments()
        elif choice == "7":
            create_bill()
        elif choice == "8":
            view_bills()
        elif choice == "9":
            print("Goodbye!")
            break
        else:
            print("❌ Invalid choice. Try again.")

if __name__ == "__main__":
    main_menu()
