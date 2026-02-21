-- Esquema de Base de Datos para Sisol_Sistema

-- 1. Sucursales
CREATE TABLE branches (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL,
  address TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 2. Departamentos
CREATE TABLE departments (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  name TEXT NOT NULL,
  branch_id UUID REFERENCES branches(id),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 3. Perfiles (Auth / Admin)
CREATE TABLE profiles (
  id UUID REFERENCES auth.users ON DELETE CASCADE PRIMARY KEY,
  full_name TEXT,
  role TEXT DEFAULT 'employee' CHECK (role IN ('admin', 'employee', 'manager')),
  avatar_url TEXT,
  updated_at TIMESTAMPTZ
);

-- 4. Empleados (Ficha Integral)
CREATE TABLE employees (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  profile_id UUID REFERENCES profiles(id),
  employee_code TEXT UNIQUE NOT NULL,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  email TEXT UNIQUE,
  phone TEXT,
  birth_date DATE,
  gender TEXT,
  address TEXT,
  curp TEXT UNIQUE,
  rfc TEXT UNIQUE,
  nss TEXT UNIQUE,
  -- Estudios
  education_level TEXT,
  institution TEXT,
  graduation_year INTEGER,
  -- Empresa
  branch_id UUID REFERENCES branches(id),
  department_id UUID REFERENCES departments(id),
  position TEXT,
  hire_date DATE,
  salary DECIMAL,
  status TEXT DEFAULT 'active' CHECK (status IN ('active', 'inactive', 'on_leave')),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- 5. Registro de Asistencia (Reloj Checador)
CREATE TABLE attendance_logs (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  employee_id UUID REFERENCES employees(id),
  type TEXT CHECK (type IN ('in', 'out')),
  timestamp TIMESTAMPTZ DEFAULT NOW(),
  photo_url TEXT,
  latitude DOUBLE PRECISION,
  longitude DOUBLE PRECISION,
  device_info JSONB
);

-- 6. Bóveda de Credenciales Externas
CREATE TABLE external_credentials (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  employee_id UUID REFERENCES employees(id),
  service_name TEXT NOT NULL, -- Bitrix24, eKontrol, etc.
  username TEXT,
  encrypted_password TEXT,
  url TEXT,
  notes TEXT,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);
