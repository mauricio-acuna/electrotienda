-- Initialize additional databases for different environments
CREATE DATABASE sputnik_core_test;
CREATE DATABASE sputnik_core_prod;

-- Grant permissions
GRANT ALL PRIVILEGES ON DATABASE sputnik_core_dev TO sputnik_user;
GRANT ALL PRIVILEGES ON DATABASE sputnik_core_test TO sputnik_user;
GRANT ALL PRIVILEGES ON DATABASE sputnik_core_prod TO sputnik_user;
