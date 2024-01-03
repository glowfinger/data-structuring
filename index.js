import mysql from 'mysql2/promise';
import { faker } from '@faker-js/faker';
import cliProgress from 'cli-progress';
import colors from 'ansi-colors';
// Create a connection to the database
const connection = await mysql.createConnection({
    host: '127.0.0.1',
    port: 3306,
    user: 'db',
    password: 'db',
    database: 'db'
});

const b1 = new cliProgress.SingleBar({
    format: 'Progress |' + colors.cyan('{bar}') + '| {percentage}%  | {value}/{total} Chunks',
    barCompleteChar: '\u2588',
    barIncompleteChar: '\u2591',
    hideCursor: true
});

let max = 3000000;
let i = 0;

b1.start(max, 0, {
    speed: "N/A"
});

while (i < max) {

    const firstName = faker.person.firstName();
    const lastName = faker.person.lastName();
    const email = `${firstName}.${lastName}@${faker.internet.domainName()}`.toLowerCase();

    const phone = faker.number.int({ max: 100 }) > 89 ? faker.phone.number() : null;
    const instagram = faker.number.int({ max: 100 }) > 89 ? `@${firstName}.${lastName}i` : null;
    const twitter = faker.number.int({ max: 100 }) > 89 ? `@${firstName}.${lastName}t` : null;
    const facebook = faker.number.int({ max: 100 }) > 89 ? `@${firstName}.${lastName}f` : null;
    const snapchat = faker.number.int({ max: 100 }) > 89 ? `@${firstName}.${lastName}s` : null;


    const user = {
        email,
        firstName,
        lastName,
        dob: faker.date.past(),
        status: faker.helpers.arrayElement(['active', 'inactive', 'pending', 'deleted', 'suspended', 'banned', 'archived', 'locked', 'flagged', 'verified', 'unverified',]),
        region: faker.location.country().toLocaleLowerCase(),
        type: faker.helpers.arrayElement(['admin', 'user', 'moderator', 'manager', 'owner', 'developer', 'tester', 'support', 'customer', 'guest',]),
        phone,
        instagram,
        twitter,
        facebook,
        snapchat,
    };

    const query = 'INSERT INTO data (email, first_name, last_name, dob, status, region, type, phone, instagram, twitter, facebook, snapchat) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)';


    try {
        await connection.query(query, [user.email, user.firstName, user.lastName, user.dob, user.status, user.region, user.type, user.phone, user.instagram, user.twitter, user.facebook, user.snapchat ]);
    } catch (error) {
        console.error( error);
    }

    i++;
    b1.update(i);
}

b1.stop();

connection.end();

