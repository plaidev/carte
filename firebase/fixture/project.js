const admin = require('firebase-admin');
const serviceAccount = require('./karte-play-firebase-adminsdk-5i9co-d4140d76a4.json');
const readlineSync = require('readline-sync');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

function question(q) {
  let input = '';
  let ok = false;
  do {
    console.log(q);
    input = readlineSync.question();
    if (input.trim().length > 0) {
      ok = true;
    }
  } while (!ok);
  console.log("");
  return input;
}

async function main() {
  const apiKey = question('What is the API key for the project?');
  const appKey = question('What is the APP key for the project?');
  const name = question('What is the name for the project?');
  const time = question('What is the expiration time for the project?');
  
  const db = admin.firestore();
  await db.collection('project').add({
    apiKey: apiKey,
    applicationKey: appKey,
    endpoint: 'https://api.karte.io',
    group: 'PRIVATE GROUP',
    name: `[PLAID検証用] ${name}`,
    visitorIdExpirationTime: parseInt(time),
    webContentHostingURL: 'https://karte-play.web.app'
  });
}

main();