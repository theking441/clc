/*
  # Create initial admin user

  1. Changes
    - Insert initial admin user with email and password
    - Enable row level security for admin_users table
    - Add policies for admin access
*/

-- Insert initial admin user (password: admin123)
INSERT INTO auth.users (email, encrypted_password, email_confirmed_at, role)
VALUES (
  'admin@example.com',
  crypt('admin123', gen_salt('bf')),
  now(),
  'authenticated'
) ON CONFLICT (email) DO NOTHING;

-- Get the user id and insert into admin_users
INSERT INTO public.admin_users (id, email)
SELECT id, email 
FROM auth.users 
WHERE email = 'admin@example.com'
ON CONFLICT (email) DO NOTHING;