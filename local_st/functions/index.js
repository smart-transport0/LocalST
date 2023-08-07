const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp();

exports.sendNotification = functions.firestore
    .document('TransporterList/{documentId}')
    .onCreate(async (snapshot, context) => {
        const message = {
            notification: {
                title: 'New Document',
                body: 'A new document was created.',
            },
            topic: 'yourTopic',
        };

        try {
            await admin.messaging().send(message);
            console.log('Notification sent successfully.');
        } catch (error) {
            console.error('Error sending notification:', error);
        }
    });
