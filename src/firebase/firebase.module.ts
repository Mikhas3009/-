import { Module } from '@nestjs/common';
import { FirebaseService } from './firebase.service';
import * as admin from 'firebase-admin';
import { ConfigModule } from '@nestjs/config';
import { FirebaseModule } from 'nestjs-firebase';


@Module({
    imports:[
        ConfigModule.forRoot({
            isGlobal:false
        }),
    ],
    providers: [
        {
            provide: FirebaseService,
            useFactory: async () => {
                const firebaseAdmin = admin.initializeApp({
                    credential: admin.credential.cert({
                        projectId: process.env.FIREBASE_PROJECT_ID,
                        clientEmail: process.env.FIREBASE_CLIENT_EMAIL,
                        privateKey: process.env.FIREBASE_PRIVATE_KEY, 
                    }),
                    storageBucket:'gs://hackaton1-f4a0b.appspot.com'
                });
            return new FirebaseService(firebaseAdmin);
          },
        },
      ],
    exports: [FirebaseService],
})
export class FirebaseIntegrationModule {}
