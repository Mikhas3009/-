import { Injectable } from '@nestjs/common';
import * as admin from 'firebase-admin';

@Injectable()
export class FirebaseService {
    public readonly firebaseAdmin: admin.app.App;

    constructor(firebaseAdmin?: admin.app.App,storage?: admin.storage.Storage) {
        this.firebaseAdmin = firebaseAdmin; 
        
    }
   
   async sendEmailMessage(email?: string, subject?: string, body?: string): Promise<void> {
       const message = {
            notification: {
                title: "utq",
                body: "asdasd",
            },
            token: 'prusakov_tr@mail.ru', // Вместо `token` можно использовать `topic`, `condition` и другие опции
        };

        try {
            await this.firebaseAdmin.messaging().send(message);
        }    
        catch (error) {
            throw new Error(`Error sending email message: ${error.message}`);
        }
    }

    async sendNotification(to: string, message: string){
        const messaging = this.firebaseAdmin.messaging();
        const payload = {
            notification: {
                title: 'Подтверждение номера телефона',
                body: message,
            },
        };
        const response = await messaging.sendToDevice(to, payload)
        return response
    }

    async getPhotoUrl(userId?: string, fileName?: string): Promise<string> {
        const fileRef =  this.firebaseAdmin.storage().bucket().file('photo1681746586.jpeg');
        const files = await this.firebaseAdmin.storage().bucket().getFiles();
        const res = files;
        // console.log(res[0][0].getSignedUrl) несколько файлов
        // Получаем публичный URL для файла
        const [url] = await fileRef.getSignedUrl({
            action: 'read',
            expires: Date.now() + 60 * 60 * 1000, // Ссылка будет действительна в течение 1 часа
        });
    
        return url;
      }

}
