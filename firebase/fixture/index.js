const admin = require('firebase-admin');
const serviceAccount = require('./<YOUR_SERVICE_ACCOUNT_KEY>');

const role = 'roles/storage.objectViewer';
const member = 'allUsers';

const storageBucket = '<YOUR_PROJECT_ID>.appspot.com';

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  storageBucket: storageBucket
});

function hasBucketPolicy(policy, binding) {
  return policy.bindings.find(o => {
    return o.role === binding.role && o.members.find(m => {
      return binding.members.find(bm => bm == m);
    });
  });
}

async function setBucketPolicyIfNeeded(bucket, binding) {
  const [policy] = await bucket.iam.getPolicy();
  if (hasBucketPolicy(policy, binding)) {
    return;
  }
  policy.bindings.push(binding);
  await bucket.iam.setPolicy(policy);  
}

function uploadItemImages(bucket, items) {
  const files = [].concat(...items.map(item => [item.image.middle, item.image.large]));
  const results = files.map(file => bucket.upload(file, {
    gzip: true,
    destination: file.replace(/^\.\//, '')
  }));
  results.forEach(async (result) => await result);
}

async function setItems(db, items) {
  const toDownloadURL = (file) => {
    const path = file.replace(/^\.\//, '');
    return `https://storage.googleapis.com/${storageBucket}/${path}`;
  }

  items.forEach(item => {
    item.image.middle = toDownloadURL(item.image.middle);
    item.image.large = toDownloadURL(item.image.large);
  });

  console.dir(items, {depth: 10});

  const batch = db.batch();
  items.forEach(item => {
    const ref = db.collection('item').doc(item.id);
    batch.set(ref, item);
  });

  await batch.commit();
}

async function main() {
  const bucket = admin.storage().bucket();

  // Update bucket policy.
  await setBucketPolicyIfNeeded(bucket, {
    role: role,
    members: [member]
  });

  // Register items.
  const items = require('./items.json');
  uploadItemImages(bucket, items);

  const db = admin.firestore();
  await setItems(db, items);
}

main();