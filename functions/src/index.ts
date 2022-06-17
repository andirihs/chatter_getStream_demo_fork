import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import { StreamChat } from "stream-chat";

admin.initializeApp();

// const serverClient = StreamChat.getInstance(
//     process.env.STREAM_API_KEY!,
//     process.env.STREAM_API_SECRET!,
// );

// Start writing Firebase Functions
// https://firebase.google.com/docs/functions/typescript

// The code is mainly according to the stream tutorial (js): https://github.com/HayesGordon/chatter/blob/main/functions/index.js
// YouTube turorial video: https://www.youtube.com/watch?v=y6OlrO3Bzag
// Some code is copied from the official firebase-extensions: https://github.com/GetStream/stream-firebase-extensions/blob/main/auth-chat/functions/src/index.ts
// callable cloud functions could be run on flutter client like follow: 
// ``final callable = FirebaseFunctions.instanceFor(region: "europe-west3").httpsCallable('xyFunction');``
// ´´final result = await callable();´´
//
// Befor you start using this function, you must add key and secret to enviroment variables with this command in firebase cli:
// ``firebase functions:config:set stream.key="app.key" stream.secret="app.secret"``

const serverClient = StreamChat.getInstance(functions.config().stream.key, functions.config().stream.secret);

export const setStreamUserAndGetToken = functions.region("europe-west3").https.onCall(async (data, context) => {
    // Checking that the user is authenticated.
    if (!context.auth) {
        // Throwing an HttpsError so that the client gets the error details.
        console.error(`client not authenticated`);
        throw new functions.https.HttpsError('failed-precondition',
            'The function must be called while authenticated.');
    } else {
        try {
            console.log(`client authenticated as ${context.auth.uid}`);
            // Create user using the serverClient.
            await serverClient.upsertUser({
                id: context.auth.uid,
                name: context.auth.token.name,
                email: context.auth.token.email,
                image: context.auth.token.image,
            });

            console.log(`Stream user created`);

            const token = serverClient.createToken(context.auth.uid);

            console.log(`Token for user ${context.auth.uid} is ${token}`);

            return token;

        } catch (err) {
            console.error(`Create/Update the stream user with ID ${context.auth.uid}. Error ${err}`);
            // Throwing an HttpsError so that the client gets the error details.
            throw new functions.https.HttpsError('aborted', "Could not create Stream user");
        }
    }
});
