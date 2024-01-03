CREATE TABLE data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(100) NOT NULL UNIQUE,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    type VARCHAR(100) NOT NULL,
    dob DATE NOT NULL,
    status VARCHAR(100) NOT NULL,
    region VARCHAR(100) NOT NULL,
    phone VARCHAR(100),
    instagram VARCHAR(100),
    twitter VARCHAR(100),
    facebook VARCHAR(100),
    snapchat VARCHAR(100)
);


CREATE TABLE user_bio (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user(id)
);
CREATE INDEX idx_lastname
ON Persons (LastName);

CREATE TABLE user_dob (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    dob DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user(id)
);

CREATE TABLE user_contact (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    method VARCHAR(100) NOT NULL INDEX,
    info VARCHAR(100) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user(id)
);