DROP DATABASE IF EXISTS hospital_db;
CREATE DATABASE hospital_db;
USE hospital_db;

-- Patients
CREATE TABLE patients (
  patient_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(120) NOT NULL,
  dob DATE,
  gender ENUM('Male','Female','Other'),
  phone VARCHAR(20),
  email VARCHAR(120),
  address VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Doctors
CREATE TABLE doctors (
  doctor_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(120) NOT NULL,
  specialization VARCHAR(100),
  phone VARCHAR(20),
  email VARCHAR(120),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Appointments
CREATE TABLE appointments (
  appointment_id INT AUTO_INCREMENT PRIMARY KEY,
  patient_id INT NOT NULL,
  doctor_id INT NOT NULL,
  appointment_datetime DATETIME NOT NULL,
  reason VARCHAR(255),
  status ENUM('Scheduled','Completed','Cancelled') DEFAULT 'Scheduled',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (patient_id) REFERENCES patients(patient_id) ON DELETE CASCADE,
  FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id) ON DELETE CASCADE,
  UNIQUE KEY uniq_doctor_slot (doctor_id, appointment_datetime)
);

-- Medical records
CREATE TABLE medical_records (
    record_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT,
    diagnosis TEXT,
    prescription TEXT,
    record_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

-- Billing (simple)
CREATE TABLE bills (
  bill_id INT AUTO_INCREMENT PRIMARY KEY,
  patient_id INT NOT NULL,
  appointment_id INT,
  total_amount DECIMAL(12,2) DEFAULT 0,
  paid BOOLEAN DEFAULT FALSE,
  payment_method ENUM('Cash','Card','Insurance','Other') DEFAULT 'Cash',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
  FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id) ON DELETE SET NULL
);

-- Medicines & pharmacy sales
CREATE TABLE medicines (
  medicine_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(150) NOT NULL,
  stock INT DEFAULT 0,
  price DECIMAL(10,2) DEFAULT 0,
  expiry_date DATE
);

CREATE TABLE pharmacy_sales (
  sale_id INT AUTO_INCREMENT PRIMARY KEY,
  medicine_id INT NOT NULL,
  patient_id INT NOT NULL,
  quantity INT NOT NULL,
  total_amount DECIMAL(12,2) NOT NULL,
  sale_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (medicine_id) REFERENCES medicines(medicine_id),
  FOREIGN KEY (patient_id) REFERENCES patients(patient_id)
);

-- Sample data
INSERT INTO patients (name, dob, gender, phone, email, address) VALUES
('John Doe','1995-03-10','Male','9876543210','john@example.com','Hyderabad'),
('Priya Sharma','1990-06-20','Female','9123456789','priya@example.com','Bangalore');

INSERT INTO doctors (name, specialization, phone, email) VALUES
('Dr. Meena Rao','Cardiologist','9876512345','meena@hospital.com'),
('Dr. Arun Varma','Orthopedic','9876523456','arun@hospital.com');

INSERT INTO appointments (patient_id, doctor_id, appointment_datetime, reason) VALUES
(1,1,'2025-09-01 10:00:00','Fever and cold'),
(2,2,'2025-09-02 11:30:00','Knee pain');

INSERT INTO medical_records (patient_id, doctor_id, diagnosis, prescription, record_date) VALUES
(1,1,'Mild Viral Fever','Paracetamol 500mg twice daily','2025-09-01'),
(2,2,'Ligament Strain','Physiotherapy','2025-09-02');

INSERT INTO medicines (name, stock, price, expiry_date) VALUES
('Paracetamol 500mg', 500, 1.50, '2027-01-01'),
('Amoxicillin 250mg', 200, 2.75, '2026-06-30');
