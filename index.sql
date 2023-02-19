-- 1- Créez les tables suivantes pour la démonstration
CREATE TABLE accounts(
   id SERIAL PRIMARY KEY,
   first_name CHARACTER VARYING(100),
   last_name CHARACTER VARYING(100)
);

CREATE TABLE plans(
   id SERIAL PRIMARY KEY,
   plan CHARACTER VARYING(10) NOT NULL
);

CREATE TABLE account_plans(
   account_id INTEGER NOT NULL,
   plan_id INTEGER NOT NULL,
   effective_date DATE NOT NULL,
   PRIMARY KEY (account_id,plan_id),
   FOREIGN KEY(account_id) REFERENCES accounts(id),
   FOREIGN KEY(plan_id) REFERENCES plans(id)

);

-- 2- Connectez-vous à la base de données PostgreSQL
$host= 'localhost';
$db = 'public';
$user = 'postgres';
$password = 'postgres';

$dsn = "pgsql:host=$host;dbname=$db;user=$user;password=$password";

try {
    $pdo = new PDO($dsn);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    echo "Connected successfully to the database.";
} catch (PDOException $e) {
    echo "Connection failed: " . $e->getMessage();
}


-- 3- Insérez trois comptes avec des niveaux d'argent, d'or et de platine

INSERT INTO accounts (first_name, last_name)VALUES ('Som', 'Sordi'); 
INSERT INTO accounts (first_name, last_name)VALUES ('Som', 'Detche'); 
INSERT INTO accounts (first_name, last_name)VALUES ('Som', 'Dombine');

SELECT id FROM plans WHERE plan = 'SILVER' OR plan = 'GOLD' OR plan = 'PLATINUM';

INSERT INTO account_plans (account_id, plan_id, effective_date)VALUES (1, 1, current_date);
INSERT INTO account_plans (account_id, plan_id, effective_date)VALUES (2, 2, current_date);
INSERT INTO account_plans (account_id, plan_id, effective_date)VALUES (3, 3, current_date);


-- 4- Essayez d'insérer un autre compte mais avec un identifiant de plan qui n'existe pas dans le tableau des plans
BEGIN;

INSERT INTO accounts(first_name, last_name) VALUES ('Som', 'Sordi');
INSERT INTO account_plans(account_id, plan_id, effective_date) VALUES (1, 1, current_date);

INSERT INTO accounts(first_name, last_name) VALUES ('Som', 'Detche');
-- Try to assign a plan with an ID that does not exist in the plans table:
INSERT INTO account_plans(account_id, plan_id, effective_date) VALUES (2, 4, current_date);

 



