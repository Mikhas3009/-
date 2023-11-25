import { Injectable } from '@nestjs/common';
import * as admin from 'firebase-admin';
import { join } from 'path';
import * as fs from 'fs';

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

    async getPhotoUrl(id?: string, fileName?: string,user = ''): Promise<string> {
        const fileRef =  this.firebaseAdmin.storage().bucket().file(`${id}/${fileName}`);
        // const files = await this.firebaseAdmin.storage().bucket().getFiles({
        //     prefix: ''
        // // });
        // const res = files;
        // console.log(files);
        // console.log(res[0][0].getSignedUrl) несколько файлов
        // Получаем публичный URL для файла

        const [url] = await fileRef.getSignedUrl({
            action: 'read',
            expires: Date.now() + 60 * 60 * 1000, // Ссылка будет действительна в течение 1 часа
        });
        return url;
    }

    async uploadFilesToUserFolder(markId: string, files: Express.Multer.File[],user=''): Promise<string[]> {

        const bucket = admin.storage().bucket(); // создаем путь к папке пользователя
        files.map(async (file) => {
          // Загрузка файла в папку пользователя
            const pathFile = join(__dirname,file.originalname)
            await bucket.file(`${user}${markId}/${file.originalname}`).save(Buffer.from(file.buffer))
        });
      
        return;
    }

}
