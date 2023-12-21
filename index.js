import mysql from 'mysql2';
import { faker } from '@faker-js/faker';


// Create a connection to the database
const connection = mysql.createConnection({
    host: '127.0.0.1',
    port: 3307,
    user: 'fast',
    password: 'fast',
    database: 'fast'
});





let max = 100000;


for (let c = 0; c < max; c++) {

    const users = [];
    for (let i = 0; i < 10; i++) {

        const firstName = faker.person.firstName();
        const lastName = faker.person.lastName();
        const email = `${firstName}.${lastName}@${faker.internet.domainName()}`.toLowerCase();

        const user = {
            email,
            firstName,
            lastName,
            dob: faker.date.past(),
            status: faker.helpers.arrayElement(['active', 'inactive', 'pending', 'deleted', 'suspended', 'banned', 'archived', 'locked', 'flagged', 'verified', 'unverified',]),
            region: faker.location.country().toLocaleLowerCase(),
            type: faker.helpers.arrayElement(['admin', 'user', 'moderator', 'manager', 'owner', 'developer', 'tester', 'support', 'customer', 'guest',])
        };
        users.push(user);
    }

    const query = 'INSERT INTO user (email, first_name, last_name, dob, status, region, type) VALUES ?';
connection.query(query, [users.map(user => [user.email, user.firstName, user.lastName, user.dob, user.status, user.region, user.type])], (error, results) => {
    if (error) {
        console.error('Error inserting users:', error);
    }
});

}

connection.end();


