/*
  # Create admin schema

  1. New Tables
    - `categories`
      - `id` (uuid, primary key)
      - `name` (text, unique)
      - `slug` (text, unique)
      - `created_at` (timestamp)
    - `menus`
      - `id` (uuid, primary key)
      - `name` (text)
      - `url` (text)
      - `order` (integer)
      - `parent_id` (uuid, self-referential)
      - `created_at` (timestamp)

  2. Security
    - Enable RLS on all tables
    - Add policies for authenticated users
*/

-- Create categories table
CREATE TABLE IF NOT EXISTS categories (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text UNIQUE NOT NULL,
  slug text UNIQUE NOT NULL,
  created_at timestamptz DEFAULT now()
);

ALTER TABLE categories ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow authenticated users to read categories"
  ON categories
  FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Allow authenticated users to insert categories"
  ON categories
  FOR INSERT
  TO authenticated
  WITH CHECK (true);

CREATE POLICY "Allow authenticated users to update categories"
  ON categories
  FOR UPDATE
  TO authenticated
  USING (true);

-- Create menus table
CREATE TABLE IF NOT EXISTS menus (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  url text NOT NULL,
  order_num integer NOT NULL DEFAULT 0,
  parent_id uuid REFERENCES menus(id),
  created_at timestamptz DEFAULT now()
);

ALTER TABLE menus ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Allow authenticated users to read menus"
  ON menus
  FOR SELECT
  TO authenticated
  USING (true);

CREATE POLICY "Allow authenticated users to insert menus"
  ON menus
  FOR INSERT
  TO authenticated
  WITH CHECK (true);

CREATE POLICY "Allow authenticated users to update menus"
  ON menus
  FOR UPDATE
  TO authenticated
  USING (true);